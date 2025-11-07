<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT 
 * @defgroup    Tasks Tasks
 * @ingroup     UnaModules
 *
 * @{
 */

class BxTasksGridTimeAdministration extends BxBaseModGeneralGrid
{
    protected $_iContextPid;

    protected $_sFilter1Name;
    protected $_sFilter1Value;
    protected $_aFilter1Values;
    protected $_sFilter2Name;
    protected $_sFilter2Value;
    protected $_aFilter2Values;

    public function __construct ($aOptions, $oTemplate = false)
    {
        $this->_sModule = 'bx_tasks';

        parent::__construct ($aOptions, $oTemplate);

        $this->_sDefaultSortingOrder = 'DESC';

        if(($iContextPid = bx_get('context_pid')) !== false) 
            $this->setContextPid($iContextPid);
    }

    public function setContextPid($iContextPid)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $this->_iContextPid = (int)$iContextPid;
        $this->_aQueryAppend['context_pid'] = $this->_iContextPid;

        /*
         * Filter by author_id
         */
        $this->_sFilter1Name = 'filter1';
        $this->_aFilter1Values = [];
        $this->_sFilter1Value = '';

        if($this->_sObject == $CNF['OBJECT_GRID_TIME_ADMINISTRATION']) {
            if(($oContext = BxDolProfile::getInstance($this->_iContextPid)) !== false) {
                $aPids = bx_srv($oContext->getModule(), 'fans', [$oContext->getContentId(), true]);
                foreach($aPids as $iPid)
                    $this->_aFilter1Values[$iPid] = $oContext->getDisplayName($iPid);
            }

            if(($sFilter1 = bx_get($this->_sFilter1Name)) !== false) {
                $this->_sFilter1Value = bx_process_input($sFilter1);
                $this->_aQueryAppend[$this->_sFilter1Name] = $this->_sFilter1Value;
            }
        }

        /*
         * Filter by object_id
         */
        $this->_sFilter2Name = 'filter2';
        $this->_aFilter2Values = [];
        $this->_sFilter2Value = '';

        $aTasks = $this->_oModule->_oDb->getTasks(-$this->_iContextPid);
        foreach($aTasks as $aTask)
            $this->_aFilter2Values[$aTask[$CNF['FIELD_ID']]] = $aTask[$CNF['FIELD_TITLE']];

        if(($sFilter2 = bx_get($this->_sFilter2Name)) !== false) {
            $this->_sFilter2Value = bx_process_input($sFilter2);
            $this->_aQueryAppend[$this->_sFilter2Name] = $this->_sFilter2Value;
        }
    }

    public function performActionCalculate()
    {
        $sAction = 'calculate';

        $aIds = $this->_getIds();
        if($aIds === false)
            return $this->_getActionResult([]);

        $iTotal = 0;
        foreach($aIds as $iId) {
            $aTrack = $this->_oModule->_oDb->getTimeTracks(['sample' => 'id', 'id' => $iId]);
            if(empty($aTrack) || !is_array($aTrack))
                continue;

            $iTotal += $aTrack['value'];
        }

        $sContent = BxTemplFunctions::getInstance()->transBox($this->_oModule->_oConfig->getHtmlIds('total_popup'), $this->_oModule->_oTemplate->parseHtmlByName('popup_total.html', [
            'total' => $this->_oModule->_oConfig->timeI2S($iTotal)
        ]));

        return echoJson(['popup' => ['html' => $sContent, 'options' => ['closeOnOuterClick' => true]]]);
    }

    protected function _getCellAuthorId($mixedValue, $sKey, $aField, $aRow)
    {
        if($this->_bIsApi)
            return ['type' => 'profile', 'data' => BxDolProfile::getData($mixedValue)];

        if(($oProfile = BxDolProfile::getInstanceMagic($mixedValue)) !== false)
            $mixedValue = $oProfile->getUnit();

        return parent::_getCellDefault($mixedValue, $sKey, $aField, $aRow);
    }
    
    protected function _getCellObjectId($mixedValue, $sKey, $aField, $aRow)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $sTitle = $aRow[$CNF['FIELD_TITLE']];
        if((int)$aField['chars_limit'] > 0)
            $sTitle = strmaxtextlen($sTitle, (int)$aField['chars_limit']);
        if($sTitle == '')
            $sTitle = _t('_sys_txt_no_title');

        $sUrl = bx_absolute_url(BxDolPermalinks::getInstance()->permalink('page.php?i=' . $CNF['URI_VIEW_ENTRY'] . '&id=' . $mixedValue));
        
        if($this->_bIsApi)
            return ['type' => 'link', 'data' => [
                'text' => $aRow[$CNF['FIELD_TITLE']],
                'url' => bx_api_get_relative_url($sUrl)
            ]];
        
        return parent::_getCellDefault($this->_getEntryLink($sTitle, $sUrl, $aRow), $sKey, $aField, $aRow);
    }

    protected function _getCellValue($mixedValue, $sKey, $aField, $aRow)
    {
        return parent::_getCellDefault($this->_oModule->_oConfig->timeI2S($mixedValue), $sKey, $aField, $aRow);
    }

    protected function _getCellValueDate($mixedValue, $sKey, $aField, $aRow)
    {
        return $this->_bIsApi ? [
            'type' => 'time', 
            'data' => $mixedValue
        ] : parent::_getCellDefault($mixedValue ? bx_time_js($mixedValue, BX_FORMAT_DATE, true) : '', $sKey, $aField, $aRow);
    }

    protected function _getActionEdit($sType, $sKey, $a, $isSmall = false, $isDisabled = false, $aRow = [])
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        if($this->_sObject == $CNF['OBJECT_GRID_TIME_ADMINISTRATION'])
            $isDisabled = true;

        return parent::_getActionDefault($sType, $sKey, $a, $isSmall, $isDisabled, $aRow);
    }

    protected function _getActionDelete($sType, $sKey, $a, $isSmall = false, $isDisabled = false, $aRow = [])
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        if($this->_sObject == $CNF['OBJECT_GRID_TIME_ADMINISTRATION'])
            $isDisabled = true;

        return parent::_getActionDelete($sType, $sKey, $a, $isSmall, $isDisabled, $aRow);
    }
    
    protected function _getFilterControls()
    {
        $this->__getFilterControls();

        $sContent = $this->_getFilterSelectOne($this->_sFilter1Name, $this->_sFilter1Value, $this->_aFilter1Values);
        $sContent .= $this->_getFilterSelectOne($this->_sFilter2Name, $this->_sFilter2Value, $this->_aFilter2Values);
        $sContent .= $this->_getSearchInput();

        return $sContent;
    }

    protected function _getFilterOnChange()
    {
        return $this->_oModule->_oConfig->getJsObject('manage_tools') . '.onChangeFilter(this)';
    }

    protected function _getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage)
    {
        $this->_aOptions['source'] .= $this->_oModule->_oDb->prepareAsString(" AND ABS(`tt`.`allow_view_to`)=?", $this->_iContextPid);

        $aFilterParts = explode($this->_sParamsDivider, $sFilter);
        switch (substr_count($sFilter, $this->_sParamsDivider)) {
            case 1:
                list($this->_sFilter1Value, $sFilter) = $aFilterParts;
                break;

            case 2:
                list($this->_sFilter1Value, $this->_sFilter2Value, $sFilter) = $aFilterParts;
                break;
        }

    	if(!empty($this->_sFilter1Value))
            $this->_aOptions['source'] .= $this->_oModule->_oDb->prepareAsString(" AND `ttt`.`author_id`=?", $this->_sFilter1Value);

        if(!empty($this->_sFilter2Value))
            $this->_aOptions['source'] .= $this->_oModule->_oDb->prepareAsString(" AND `ttt`.`object_id`=?", $this->_sFilter2Value);

        return parent::_getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage);
    }

    protected function _getEntryLink($sTitle, $sUrl, $aRow)
    {
        return $this->_oTemplate->parseHtmlByName('title_link.html', [
            'href' => $sUrl,
            'title' => bx_html_attribute($sTitle),
            'content' => bx_process_output($sTitle),
            'target' => '_blank'
        ]);
    }

    protected function __getFilterControls()
    {
        parent::_getFilterControls();
    }

    protected function _getIds()
    {
        $aIds = bx_get('ids');
        if(!$aIds || !is_array($aIds)) {
            $iId = (int)bx_get('id');
            if(!$iId) 
                return false;

            $aIds = [$iId];
        }

        return $aIds;
    }
}

/** @} */
