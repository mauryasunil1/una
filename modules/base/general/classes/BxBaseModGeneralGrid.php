<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    BaseGeneral Base classes for modules
 * @ingroup     UnaModules
 * @{
 */

class BxBaseModGeneralGrid extends BxTemplGrid
{
    protected $MODULE;
    protected $_sModule;
    protected $_oModule;

    protected $_sParamsDivider;

    protected $_sJsObject;

    public function __construct ($aOptions, $oTemplate = false)
    {
        $this->MODULE = $this->MODULE ?: $this->_sModule;
        $this->_sModule = $this->_sModule ?: $this->MODULE;
    	$this->_oModule = BxDolModule::getInstance($this->_sModule);

        parent::__construct ($aOptions, $oTemplate ?: $this->_oModule->_oTemplate);

        $this->_sParamsDivider = '#-#';
    }

    protected function _getFilterOnChange()
    {
        return '';
    }

    protected function _getFilterSelectOne($sFilterName, $sFilterValue, $aFilterValues, $bAddSelectOne = true)
    {
        if(empty($sFilterName))
            return '';

        $CNF = &$this->_oModule->_oConfig->CNF;

        $aInputValues = [];
        if($bAddSelectOne)
            $aInputValues[''] = _t($CNF['T']['filter_item_select_one_' . $sFilterName] ?? '_Select_one');

        foreach($aFilterValues as $mixedKey => $mixedValue)
            if(is_array($mixedValue) && isset($mixedValue['key'], $mixedValue['value']))
                $aInputValues[$mixedValue['key']] = _t($mixedValue['value']);
            else
                $aInputValues[$mixedKey] = _t($mixedValue);

        $aInputModules = [
            'type' => 'select',
            'name' => $sFilterName,
            'attrs' => [
                'id' => 'bx-grid-' . $sFilterName . '-' . $this->_sObject,
                'onChange' => 'javascript:' . $this->_getFilterOnChange()
            ],
            'value' => $sFilterValue,
            'values' => $aInputValues
        ];

        $oForm = new BxTemplFormView([]);
        return $oForm->genRow($aInputModules);
    }

    protected function _getSearchInput()
    {
        $sOnChange = $this->_getFilterOnChange();

        $aInputSearch = [
            'type' => 'text',
            'name' => 'search',
            'attrs' => [
                'id' => 'bx-grid-search-' . $this->_sObject,
                'onKeyup' => 'javascript:$(this).off(\'keyup focusout\'); ' . $sOnChange,
                'onBlur' => 'javascript:' . $sOnChange,
            ]
        ];

        $oForm = new BxTemplFormView([]);
        return $oForm->genRow($aInputSearch);
    }
}

/** @} */
