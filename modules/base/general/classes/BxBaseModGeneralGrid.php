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

    protected function _getFilterSelectOne($sFilterName, $sFilterValue, $aFilterValues, $mixedAddSelectOne = true, $bAsArray = false)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        if($mixedAddSelectOne === true && ($sKey = $CNF['T']['filter_item_select_one_' . $sFilterName] ?? ''))
            $mixedAddSelectOne = $sKey;

        return parent::_getFilterSelectOne($sFilterName, $sFilterValue, $aFilterValues, $mixedAddSelectOne, $bAsArray);
    }
}

/** @} */
