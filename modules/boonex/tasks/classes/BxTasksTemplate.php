<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT 
 * @defgroup    Tasks Tasks
 * @ingroup     UnaModules
 *
 * @{
 */

/*
 * Module representation.
 */
class BxTasksTemplate extends BxBaseModTextTemplate
{
    function __construct(&$oConfig, &$oDb)
    {
        $this->MODULE = 'bx_tasks';

        parent::__construct($oConfig, $oDb);
    }

    /**
     * Use Gallery image for both because currently there is no Unit types with small thumbnails.
     */
    protected function getUnitThumbAndGallery ($aData)
    {
        list($sPhotoThumb, $sPhotoGallery) = parent::getUnitThumbAndGallery($aData);

        return array($sPhotoGallery, $sPhotoGallery);
    }
    
    public function entryText ($aData, $sTemplateName = 'entry-text.html')
    {
        $aVars = $this->getTmplVarsText($aData);

        return $this->parseHtmlByName($sTemplateName, $aVars);
    }

    public function getEntriesList($iContextId)
    {
        $CNF = &$this->_oConfig->CNF;

        $oPermalinks = BxDolPermalinks::getInstance();
        $oConnection = BxDolConnection::getObjectInstance($CNF['OBJECT_CONNECTION']);

        $aTypes = BxDolFormQuery::getDataItems($CNF['OBJECT_PRE_LIST_TYPES']);
        $aPriorities = BxDolFormQuery::getDataItems($CNF['OBJECT_PRE_LIST_PRIORITIES']);
        $aStates = BxDolFormQuery::getDataItems($CNF['OBJECT_PRE_LIST_STATES']);

        $aFilterValues = array();
        if(isset($_COOKIE[$CNF['COOKIE_SETTING_KEY']]))
            $aFilterValues = json_decode($_COOKIE[$CNF['COOKIE_SETTING_KEY']], true);

        $_iContextId = abs($iContextId);

        $oModule = $this->getModule();
        $bAllowAdd = $oModule->isAllowAdd($_iContextId);
        $bAllowManage = $oModule->isAllowManageByContext($_iContextId);

        $aLists = $this->_oDb->getLists($iContextId);

        $aTmplVarsLists = [];
        foreach($aLists as $aList) {
            $aTasks = $this->_oDb->getTasks($iContextId, $aList['id'], true);

            $aTmplVarsTasks = [];
            foreach($aTasks as $aTask) {
                $sState = $aStates[$aTask[$CNF['FIELD_STATE']]] ?? '';
                if(!empty($aTask['time']))
                    $sState .= ' ' . $this->_oConfig->timeI2S($aTask['time']);
                if($bAllowManage && !empty($aTask['time_total']))
                    $sState .= ' (' . $this->_oConfig->timeI2S($aTask['time_total']) . ')';

                $aMembers = $oConnection->getConnectedInitiators($aTask[$CNF['FIELD_ID']]);

                $aTmplVarsMembers = [];
                foreach($aMembers as $iMember)
                    if(($oProfile = BxDolProfile::getInstance($iMember)) !== false && !($oProfile instanceof BxDolProfileUndefined))
                        $aTmplVarsMembers[] = array('info' => $oProfile->getUnit(0, array('template' => 'unit_wo_info')));

                $aTmplVarsTasks[] = array(
                    'id' => $aTask[$CNF['FIELD_ID']],
                    'title' => bx_process_output($aTask[$CNF['FIELD_TITLE']]),
                    'created' => bx_time_js($aTask[$CNF['FIELD_ADDED']]),
                    'class' => $aTask[$CNF['FIELD_COMPLETED']] == 1 ? 'completed' : 'uncompleted',
                    'due' => $aTask[$CNF['FIELD_DUEDATE']] > 0 ? bx_time_js($aTask[$CNF['FIELD_DUEDATE']]) : '',
                    'type' => $aTypes[$aTask[$CNF['FIELD_TYPE']]] ?? '',
                    'priority' => $aPriorities[$aTask[$CNF['FIELD_PRIORITY']]] ?? '',
                    'state' => $sState,
                    'bx_repeat:members' => $aTmplVarsMembers,
                    'badges' => $oModule->serviceGetBadges($aTask[$CNF['FIELD_ID']], true),
                    'url' => bx_absolute_url($oPermalinks->permalink('page.php?i=' . $CNF['URI_VIEW_ENTRY'] . '&id=' . $aTask[$CNF['FIELD_ID']])),
                    'object' => $this->_oConfig->getJsObject('tasks'),
                    'bx_if:allow_manage' => array(
                        'condition' => $bAllowManage,
                        'content' => array(
                            'id' => $aTask[$CNF['FIELD_ID']],
                            'object' => $this->_oConfig->getJsObject('tasks'),
                            'checked' => $aTask[$CNF['FIELD_COMPLETED']] == 1 ? 'checked' : '',
                        )
                    ),
                    'bx_if:deny_manage' => array(
                        'condition' => !$bAllowManage,
                        'content' => array(
                            'id' => $aTask[$CNF['FIELD_ID']],
                            'checked' => $aTask[$CNF['FIELD_COMPLETED']] == 1 ? 'checked' : '',
                        )
                    ),
                );
            }

            $sClass = $sCompleted = $sAll = "";
            if (isset($aFilterValues[$aList[$CNF['FIELD_ID']]])){
                $sClass = $aFilterValues[$aList[$CNF['FIELD_ID']]];
                if ($sClass == 'completed')
                    $sCompleted= 'selected';
                if ($sClass == 'all')
                    $sAll = 'selected';
            }

            $aTmplVarsLists[] = array(
                'bx_if:allow_edit_list' => array(
                    'condition' => $bAllowAdd,
                    'content' => array(
                        'title' => $aList[$CNF['FIELD_TITLE']],
                        'context_id' => $iContextId,
                        'list_id' => $aList[$CNF['FIELD_ID']],
                        'object' => $this->_oConfig->getJsObject('tasks'),
                    )
                ),
                'bx_if:allow_add' => array(
                    'condition' => $bAllowAdd,
                    'content' => array(
                        'context_id' => $iContextId,
                        'list_id' => $aList[$CNF['FIELD_ID']],
                        'object' => $this->_oConfig->getJsObject('tasks'),
                    )
                ),
                'bx_if:allow_delete_list' => array(
                    'condition' => $bAllowManage,
                    'content' => array(
                        'context_id' => $iContextId,
                        'list_id' => $aList[$CNF['FIELD_ID']],
                        'object' => $this->_oConfig->getJsObject('tasks'),
                    )
                ),
                'bx_if:deny_edit_list' => array(
                    'condition' => !$bAllowAdd,
                    'content' => array(
                        'title' => $aList[$CNF['FIELD_TITLE']],
                    )
                ),
                'id' => $aList['id'],
                'bx_repeat:tasks' =>  $aTmplVarsTasks,
                'context_id' => $iContextId,
                'list_id' => $aList[$CNF['FIELD_ID']],
                'object' => $this->_oConfig->getJsObject('tasks'),
                'class' => $sClass,
                'completed' => $sCompleted,
                'all' => $sAll,
            );
        }

        $this->addCssJs();
        $this->addJs([
            'jquery-ui/jquery-ui.min.js',
            'tasks.js',
            'modules/base/general/js/|forms.js'
        ]);

        return $this->getJsCode('tasks', ['t_confirm_block_deletion' => _t('_bx_tasks_confirm_tasklist_deletion')]) . $this->parseHtmlByName('browse_tasks.html', [
            'bx_repeat:task_lists' => $aTmplVarsLists,
            'bx_if:allow_add_list' => [
                'condition' => $bAllowAdd,
                'content' => [
                    'context_id' => $iContextId,
                    'object' => $this->_oConfig->getJsObject('tasks'),
                ]
            ],
        ]);
    }
}

/** @} */
