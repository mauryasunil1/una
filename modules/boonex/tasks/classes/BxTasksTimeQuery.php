<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT 
 * @defgroup    Tasks Tasks
 * @ingroup     UnaModules
 *
 * @{
 */

class BxTasksTimeQuery extends BxDolReportQuery
{
    public function __construct(&$oModule)
    {
        parent::__construct($oModule);
    }

    public function getReport($iObjectId)
    {
        $aResult = $this->getRow("SELECT `count` as `count`, `sum` AS `sum` FROM `{$this->_sTable}` WHERE `object_id` = :object_id LIMIT 1", ['object_id' => $iObjectId]);
        if(empty($aResult) || !is_array($aResult))
            $aResult = ['count' => 0, 'sum' => 0];

        return $aResult;
    }

    public function updateReport($iObjectId, $iValue, $bUndo = false)
    {
        return (int)$this->query("UPDATE `{$this->_sTable}` SET `sum` = `sum` " . ($bUndo ? "-" : "+") . " :value WHERE `object_id` = :object_id", [
            'object_id' => $iObjectId,
            'value' => $iValue
        ]) != 0;
    }

    /**
     * Note. Tracks shouldn't be deleted on Undo.
     * 
     * @see BxDolReportQuery::putReport
     */
    protected function _deleteTrack($iObjectId, $iAuthorId)
    {
        return true;
    }

    protected function _updateTriggerTable($iObjectId, $aEntry)
    {
        return (int)$this->query("UPDATE `{$this->_sTriggerTable}` SET `{$this->_sTriggerFieldCount}` = :field_count WHERE `{$this->_sTriggerFieldId}` = :field_id", [
            'field_count' => $aEntry['sum'],
            'field_id' => $iObjectId
        ]) > 0;
    }
}

/** @} */
