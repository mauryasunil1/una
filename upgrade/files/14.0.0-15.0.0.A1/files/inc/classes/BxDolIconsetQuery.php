<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    UnaCore UNA Core
 * @{
 */

/**
 * Database queries for iconset objects.
 * @see BxDolIconset
 */
class BxDolIconsetQuery extends BxDolDb
{
    protected $_aObject;

    public function __construct($aObject)
    {
        parent::__construct();

        $this->_aObject = $aObject;
    }

    static public function getIconsetObject ($sObject)
    {
        $oDb = BxDolDb::getInstance();

        $aObject = $oDb->getRow("SELECT * FROM `sys_objects_iconset` WHERE `object` = :object", ['object' => $sObject]);
        if(!$aObject || !is_array($aObject))
            return false;

        return $aObject;
    }

}

/** @} */
