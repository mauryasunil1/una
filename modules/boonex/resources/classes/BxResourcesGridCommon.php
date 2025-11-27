<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT 
 * 
 * @defgroup    Resources Resources
 * @ingroup     UnaModules
 *
 * @{
 */

class BxResourcesGridCommon extends BxBaseModTextGridCommon
{
    protected $_aCategories;

    protected $_iContextPid;

    public function __construct ($aOptions, $oTemplate = false)
    {
    	$this->MODULE = 'bx_resources';

        parent::__construct ($aOptions, $oTemplate);

        $CNF = &$this->_oModule->_oConfig->CNF;

        $this->_aCategories = BxDolFormQuery::getDataItems($CNF['OBJECT_CATEGORY']);

        if(($iContextPid = bx_get('context_pid')) !== false) 
            $this->setContextPid($iContextPid);
    }

    public function setContextPid($iContextPid)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $this->_iContextPid = (int)$iContextPid;
        $this->_aQueryAppend['context_pid'] = $this->_iContextPid;   
    }

    protected function _getCellCat($mixedValue, $sKey, $aField, $aRow)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        return parent::_getCellDefault($this->_aCategories[$aRow[$CNF['FIELD_CATEGORY']]] ?? '', $sKey, $aField, $aRow);
    }

    protected function _getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage)
    {
        if($this->_iContextPid)
            $this->_aOptions['source'] .= $this->_oModule->_oDb->prepareAsString(" AND ABS(`allow_view_to`)=?", $this->_iContextPid);

        return $this->__getDataSql($sFilter, $sOrderField, $sOrderDir, $iStart, $iPerPage);
    }
}

/** @} */
