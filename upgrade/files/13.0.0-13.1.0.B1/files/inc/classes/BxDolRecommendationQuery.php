<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    UnaCore UNA Core
 * @{
 */

class BxDolRecommendationQuery extends BxDolDb
{
    public static $sTableObjects = 'sys_objects_recommendation';
    public static $sTableCriteria = 'sys_recommendation_criteria';
    public static $sTableData = 'sys_recommendation_data';
            
    protected $_aObject;

    public function __construct()
    {
        parent::__construct();

        $this->_aObject = [];
    }

    static public function getObjects($bActiveOnly = true)
    {
        $sWhereClause = "";
        if($bActiveOnly)
            $sWhereClause = " AND `active` = 1";

        return BxDolDb::getInstance()->getAllWithKey("SELECT * FROM `" . self::$sTableObjects . "` WHERE 1" . $sWhereClause, 'name');
    }

    static public function getObject($sName)
    {
        $oDb = BxDolDb::getInstance();

        $aObject = $oDb->getRow("SELECT * FROM `" . self::$sTableObjects . "` WHERE `name` = :name", ['name' => $sName]);
        if(!$aObject || !is_array($aObject))
            return false;
        
        $aCriteria = $oDb->getAllWithKey("SELECT * FROM `" . self::$sTableCriteria . "` WHERE `object_id` = :object_id AND `weight` > 0 AND `active` = 1 ORDER BY `weight` DESC", 'name', ['object_id' => $aObject['id']]);
        if(!$aCriteria || !is_array($aCriteria))
            return false;

        $aObject['weights'] = $oDb->getPairs("SELECT `name`, `weight` FROM `" . self::$sTableCriteria . "` WHERE `object_id` = :object_id AND `weight` > 0 AND `active` = 1 ORDER BY `weight` DESC", 'name', 'weight', ['object_id' => $aObject['id']]);

        return [
            'object' => $aObject,
            'criteria' => $aCriteria
        ];
    }

    public function init($aObject = [])
    {
        if(empty($aObject) || !is_array($aObject)) 
            return;

        $this->_aObject = $aObject;
    }

    public function clean($iProfileId, $iObjectId, $bAll = false)
    {
        $sWhereClause = "";
        if(!$bAll)
            $sWhereClause = " AND `item_reducer` = 0";

        return $this->query("DELETE FROM `" . self::$sTableData . "` WHERE `profile_id` = :profile_id AND `object_id` = :object_id" . $sWhereClause, [
            'profile_id' => $iProfileId,
            'object_id' => $iObjectId
        ]);
    }

    public function add($iProfileId, $iObjectId, $iItemId, $iItemValue)
    {
        return $this->query("INSERT INTO `" . self::$sTableData . "` (`profile_id`, `object_id`, `item_id`, `item_value`) VALUES (:profile_id, :object_id, :item_id, :item_value) ON DUPLICATE KEY UPDATE `item_value` = :item_value", [
            'profile_id' => $iProfileId,
            'object_id' => $iObjectId,
            'item_id' => $iItemId, 
            'item_value' => $iItemValue
        ]) !== false;
    }
    
    public function update($iProfileId, $iObjectId, $iItemId, $aSet)
    {
        if(empty($aSet) || !is_array($aSet))
            return false;

        return $this->query("UPDATE `" . self::$sTableData . "` SET " . $this->arrayToSQL($aSet) . " WHERE `profile_id` = :profile_id AND `object_id` = :object_id AND `item_id` = :item_id ", [
            'profile_id' => $iProfileId,
            'object_id' => $iObjectId,
            'item_id' => $iItemId
        ]) !== false;
    }

    public function get($iProfileId, $iObjectId, $iStart = 0, $iPerPage = 0)
    {
        $sLimitClause = "";
        if($iPerPage)
            $sLimitClause = " LIMIT " . $iStart . ", " . $iPerPage;

        return $this->getPairs("SELECT `item_id` AS `id`, (`item_value` - `item_reducer`) AS `value` FROM `" . self::$sTableData . "` WHERE `profile_id` = :profile_id AND `object_id` = :object_id AND (`item_value` - `item_reducer`) > 0 ORDER BY `value` DESC" . $sLimitClause, 'id', 'value', [
            'profile_id' => $iProfileId,
            'object_id' => $iObjectId
        ]);
    }

    public function getItem($iProfileId, $iObjectId, $iItemId)
    {
        return $this->getRow("SELECT * FROM `" . self::$sTableData . "` WHERE `profile_id` = :profile_id AND `object_id` = :object_id AND `item_id` = :item_id", [
            'profile_id' => $iProfileId,
            'object_id' => $iObjectId,
            'item_id' => $iItemId
        ]);
    }
}

/** @} */
