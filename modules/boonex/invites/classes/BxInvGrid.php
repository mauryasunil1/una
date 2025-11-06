<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Invites Invites
 * @ingroup     UnaModules
 * 
 * @{
 */

class BxInvGrid extends BxTemplGrid
{
    protected $_sModule;
    protected $_oModule;

    protected $_sFilter1Name;
    protected $_sFilter1Value;
    protected $_aFilter1Values;
    protected $_sParamsDivider;
    
    public function __construct ($aOptions, $oTemplate = false)
    {
        parent::__construct ($aOptions, $oTemplate);

        $this->_sModule = 'bx_invites';
        $this->_oModule = BxDolModule::getInstance($this->_sModule);

        $this->_sParamsDivider = '#-#';
    }

    public function getFormCallBackUrlAPI($sAction, $iId = 0)
    {
         return '/api.php?r=system/perfom_action_api/TemplServiceGrid/&params[]=&o=' . $this->_sObject . '&a=' . $sAction;
    }

    public function performActionAdd()
    {
        $sAction = 'add';

        $oForm = $this->_oModule->getFormObjectInvite();
        if(!$oForm)
            return $this->_getActionResult([]);

        $oForm->aInputs['text']['value'] = _t('_bx_invites_msg_invitation');
        $oForm->aFormAttrs['action'] = BX_DOL_URL_ROOT . 'grid.php?' . bx_encode_url_params($_GET, array('ids', '_r'));
        $oForm->initChecker();

        $aResult = [];
        if($oForm->isSubmittedAndValid()) {
            $sResult = $this->_oModule->processFormObjectInvite($oForm);
            if($this->_bIsApi)
                $aResult = [bx_api_get_msg($sResult)];
            else
                $aResult = ['msg' => $sResult];
        }
        else {
            if($this->_bIsApi)
                $aResult = $this->getFormBlockAPI($oForm, $sAction);
            else
                $aResult = ['popup' => [
                    'html' => BxTemplFunctions::getInstance()->popupBox('_bx_invites_form_invite', _t('_bx_invites_form_invite'), $this->_oModule->_oTemplate->parseHtmlByName('popup_invite.html', [
                        'form_id' => $oForm->id,
                        'form' => $oForm->getCode(true),
                        'object' => $this->_sObject,
                        'action' => $sAction
                    ])), 
                    'options' => ['closeOnOuterClick' => true]
                ]];
        }

        return $this->_getActionResult($aResult);
    }

    protected function _getFilterControls ()
    {
        parent::_getFilterControls();
        return  $this->_getFilterSelectOne($this->_sFilter1Name, $this->_sFilter1Value, $this->_aFilter1Values) . $this->_getSearchInput();
    }
    
    protected function _getSearchInput()
    {
        $sJsObject = $this->_oModule->_oConfig->getJsObject('main');
        $aInputSearch = [
            'type' => 'text',
            'name' => 'search',
            'attrs' => [
                'id' => 'bx-grid-search-' . $this->_sObject,
                'onKeyup' => 'javascript:$(this).off(\'keyup focusout\'); ' . $sJsObject . '.onChangeFilter(this)',
                'onBlur' => 'javascript:' . $sJsObject . '.onChangeFilter(this)',
            ]
        ];

        $oForm = new BxTemplFormView([]);
        return $oForm->genRow($aInputSearch);
    }
    
    protected function _getFilterSelectOne($sFilterName, $sFilterValue, $aFilterValues)
    {
        if(empty($sFilterName) || empty($aFilterValues))
            return '';

        $CNF = &$this->_oModule->_oConfig->CNF;
        $sJsObject = $this->_oModule->_oConfig->getJsObject('main');

        foreach($aFilterValues as $sKey => $sValue)
            $aFilterValues[$sKey] = _t($sValue);

        $aInputModules = [
            'type' => 'select',
            'name' => $sFilterName,
            'attrs' => [
                'id' => 'bx-grid-' . $sFilterName . '-' . $this->_sObject,
                'onChange' => 'javascript:' . $sJsObject . '.onChangeFilter(this)'
            ],
            'value' => $sFilterValue,
            'values' => $aFilterValues
        ];

        $oForm = new BxTemplFormView([]);
        return $oForm->genRow($aInputModules);
    }

    protected function _getId()
    {
        $iId = 0;

        if(($aIds = bx_get('ids')) !== false) {
            if(!$aIds || !is_array($aIds))
                return 0;

            $iId = (int)array_shift($aIds);
        }
        else if(($iId = bx_get('id')) !== false)
            $iId = (int)$iId;
        
        return $iId;
    }

    protected function _getIds()
    {
        $aIds = [];

        if(($aIds = bx_get('ids')) !== false) {
            if(!$aIds || !is_array($aIds))
                return [];

            $aIds = bx_process_input($aIds, BX_DATA_INT);
        }
        else if(($iId = bx_get('id')) !== false)
            $aIds = [(int)$iId];

        return $aIds;
    }
}

/** @} */
