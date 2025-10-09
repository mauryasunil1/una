<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT 
 * @defgroup    Tasks Tasks
 * @ingroup     UnaModules
 *
 * @{
 */

require_once('BxTasksGridTimeAdministration.php');

class BxTasksGridTime extends BxTasksGridTimeAdministration
{
    protected $_iLogged;

    public function __construct ($aOptions, $oTemplate = false)
    {
        parent::__construct ($aOptions, $oTemplate);

        $this->_iLogged = bx_get_logged_profile_id();
    }

    public function performActionAdd()
    {
        $sAction = 'add';

        $oForm = $this->_getFormObject($sAction);
        $oForm->initChecker();
        if($oForm->isSubmittedAndValid()) {
            $aValsToAdd = [
                'author_id' => $this->_iLogged,
                'author_nip' => bx_get_ip_hash(getVisitorIP()),
                'value' => $this->_oModule->_oConfig->timeS2I($oForm->getCleanValue('value')),
                'date' => time()
            ];

            $iTrackId = $oForm->insert($aValsToAdd);
            if(!$iTrackId)
                return $this->_getActionResult(['msg' => _t('_bx_tasks_txt_err_cannot_perform_action')]);

            $sSystem = $oForm->getCleanValue('sys');
            $iObjectId = $oForm->getCleanValue('object_id');
            if(($oTime = BxDolReport::getObjectInstance($sSystem, $iObjectId)) && $oTime->isEnabled())
                $oTime->putReport($iObjectId, $this->_iLogged, $iTrackId);

            return $this->_bIsApi ? [] : echoJson(['grid' => $this->getCode(false), 'blink' => $iTrackId]);    
        }

        if($this->_bIsApi)
            return $this->getFormBlockAPI($oForm, $sAction);

        $sContent = BxTemplFunctions::getInstance()->popupBox($this->_oModule->_oConfig->getHtmlIds('time_popup'), _t('_bx_tasks_popup_title_time_add'), $this->_oModule->_oTemplate->parseHtmlByName('popup_time.html', [
            'form_id' => $oForm->getId(),
            'form' => $oForm->getCode(true),
            'object' => $this->_sObject,
            'action' => $sAction
        ]));

        return echoJson(['popup' => ['html' => $sContent, 'options' => ['closeOnOuterClick' => false]]]);
    }

    public function performActionEdit()
    {
    	$CNF = &$this->_oModule->_oConfig->CNF;

        $sAction = 'edit';

        $aIds = $this->_getIds();
        if($aIds === false)
            return $this->_getActionResult([]);

        $iTrack = array_shift($aIds);
        $aTrack = $this->_oModule->_oDb->getTimeTracks(['sample' => 'id', 'id' => $iTrack]);
        if(empty($aTrack) || !is_array($aTrack))
            return $this->_getActionResult([]);

        $oForm = $this->_getFormObject($sAction, $iTrack);
        $oForm->initChecker(array_merge($aTrack, ['value' => $this->_oModule->_oConfig->timeI2S($aTrack['value'])]));
        if($oForm->isSubmittedAndValid()) {
            $aValsToAdd = [
                'value' => $this->_oModule->_oConfig->timeS2I($oForm->getCleanValue('value')),
            ];

            if(!$oForm->update($iTrack, $aValsToAdd))
                return $this->_getActionResult(['msg' => _t('_bx_tasks_txt_err_cannot_perform_action')]);

            $iObjectId = (int)$aTrack['object_id'];
            $iAuthorId = (int)$aTrack['author_id'];
            if(($oTime = BxDolReport::getObjectInstance($CNF['OBJECT_REPORTS_TIME'], $iObjectId)) && $oTime->isEnabled()) {
                $oTime->putReport($iObjectId, $iAuthorId, $aTrack, true); //--- Revoke old value
                $oTime->putReport($iObjectId, $iAuthorId, $iTrack); //--- Process new value
            }

            return $this->_bIsApi ? [] : echoJson(['grid' => $this->getCode(false), 'blink' => $iTrack]);    
        }

        if($this->_bIsApi)
            return $this->getFormBlockAPI($oForm, $sAction, $iLevel);

        $sContent = BxTemplFunctions::getInstance()->popupBox($this->_oModule->_oConfig->getHtmlIds('time_popup'), _t('_bx_tasks_popup_title_time_edit'), $this->_oModule->_oTemplate->parseHtmlByName('popup_time.html', [
            'form_id' => $oForm->getId(),
            'form' => $oForm->getCode(true),
            'object' => $this->_sObject,
            'action' => $sAction
        ]));

        return echoJson(['popup' => ['html' => $sContent, 'options' => ['closeOnOuterClick' => false]]]);
    }

    protected function _delete ($mixedId)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $aTrack = $this->_oModule->_oDb->getTimeTracks(['sample' => 'id', 'id' => (int)$mixedId]);
        if(!is_array($aTrack) || empty($aTrack))
            return false;

        $iObjectId = (int)$aTrack['object_id'];
        $iAuthorId = (int)$aTrack['author_id'];

        $bResult = parent::_delete($mixedId);
        if($bResult && ($oTime = BxDolReport::getObjectInstance($CNF['OBJECT_REPORTS_TIME'], $iObjectId)) && $oTime->isEnabled())
            $oTime->putReport($iObjectId, $iAuthorId, $aTrack, true);

        return $bResult;
    }

    protected function _getFormObject($sAction, $iId = 0)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $bActionAdd = $sAction == 'add';
        $bActionEdit = $sAction == 'edit';

        $aActionParams = [
            'o' => $this->_sObject, 
            'a' => $sAction,
            'context_pid' => $this->_iContextPid
        ];
        if($bActionEdit && !empty($iId))
            $aActionParams['id'] = $iId;

        $sForm = $CNF['OBJECT_FORM_TIME_DISPLAY_' . strtoupper($sAction)];
        $oForm = BxDolForm::getObjectInstance($CNF['OBJECT_FORM_TIME'], $sForm);
        $oForm->setId($sForm);
        $oForm->setName($sForm);
    	$oForm->setAction(BX_DOL_URL_ROOT . bx_append_url_params('grid.php', $aActionParams));

        $oForm->aParams['db']['table'] = $CNF['TABLE_TIME_TRACK'];
        if($bActionAdd) {
            $oForm->aInputs['sys']['value'] = $CNF['OBJECT_REPORTS_TIME'];
            $oForm->aInputs['action']['value'] = 'Report';
            $oForm->aInputs['object_id'] = array_merge($oForm->aInputs['object_id'], [
                'type' => 'select',
                'values' => [['key' => 0, 'value' => _t('_sys_please_select')]],
                'required' => true,
                'checker' => [
                    'func' => 'Avail',
                    'error' => _t('_bx_tasks_form_time_input_object_id_err')
                ]
            ]);

            $aTasks = $this->_oModule->_oDb->getTasks(-$this->_iContextPid);
            foreach($aTasks as $aTask) {
                if($aTask[$CNF['FIELD_STATUS_ADMIN']] !== 'active')
                    continue;

                $oForm->aInputs['object_id']['values'][] = [
                    'key' => $aTask[$CNF['FIELD_ID']],
                    'value' => $aTask[$CNF['FIELD_TITLE']]
                ];
            }
        }

        return $oForm;
    }

    protected function _getFilterControls()
    {
        $this->__getFilterControls();

        $sContent = $this->_getFilterSelectOne($this->_sFilter2Name, $this->_sFilter2Value, $this->_aFilter2Values);
        $sContent .= $this->_getSearchInput();

        return $sContent;
    }

    protected function _getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage)
    {
        $this->_aOptions['source'] .= $this->_oModule->_oDb->prepareAsString(" AND `ttt`.`author_id`=?", $this->_iLogged);

        return parent::_getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage);
    }
}

/** @} */
