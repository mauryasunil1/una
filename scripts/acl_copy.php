<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    UnaCoreScripts Scripts
 * @{
 */

$aPathInfo = pathinfo(__FILE__);
require_once($aPathInfo['dirname'] . '/../inc/header.inc.php');
require_once(BX_DIRECTORY_PATH_INC . 'design.inc.php');

class BxDolAclCopyCmd
{
    protected $_oDb;

    protected $_bQuiet;

    protected $_LevelIdFrom;
    protected $_LevelIdTo;
    
    protected $_LevelMaskFrom;
    protected $_LevelMaskTo;

    public function __construct() 
    {
        $this->_oDb = BxDolDb::getInstance();

        $this->_bQuiet = false;
    }

    public function main()
    {
        $a = getopt('hf:t:');

        if (isset($a['h']) || !$a)
            $this->finish(0, $this->getHelp());

        if (isset($a['f']))
            $this->_LevelIdFrom = (int)$a['f'];

        if (isset($a['t']))
            $this->_LevelIdTo = (int)$a['t'];

        $this->_LevelMaskFrom = pow(2, $this->_LevelIdFrom - 1);
        $this->_LevelMaskTo = pow(2, $this->_LevelIdTo - 1);

        $this->output($this->_setAclMatrix());
        $this->output($this->_setRoles('sys_objects_page'));
        $this->output($this->_setRoles('sys_pages_blocks'));
        $this->output($this->_setRoles('sys_menu_items'));
        $this->output($this->_setRoles('sys_form_display_inputs'));
        $this->output($this->_setRoles('sys_objects_grid'));

        $this->finish(1);
    }

    protected function getHelp()
    {
        $n = 20;
        $s = "Usage: php acl_copy.php [options]\n";

        $s .= str_pad("\t -h", $n) . "Print this help\n";
        $s .= str_pad("\t -f <input_id>", $n) . "Input level ID to copy from\n";
        $s .= str_pad("\t -t <input_id>", $n) . "Input level ID to copy to\n";        
        $s .= "\n";

        return $s;
    }

    protected function _setAclMatrix()
    {
        $sResult = '';

        $sQuery = $this->_oDb->prepareAsString("DELETE FROM `sys_acl_matrix` WHERE `IDLevel` = ?", $this->_LevelIdTo);
        $this->_oDb->query($sQuery); 

        $sResult .= $sQuery . "\n";
        
        $sQuery = $this->_oDb->prepareAsString("INSERT INTO `sys_acl_matrix` (`IDLevel`, `IDAction`, `AllowedCount`, `AllowedPeriodLen`, `AllowedPeriodStart`, `AllowedPeriodEnd`, `AdditionalParamValue`) SELECT " . $this->_LevelIdTo . ", `IDAction`, `AllowedCount`, `AllowedPeriodLen`, `AllowedPeriodStart`, `AllowedPeriodEnd`, `AdditionalParamValue` FROM `sys_acl_matrix` WHERE `IDLevel` = ?", $this->_LevelIdFrom);                
        $this->_oDb->query($sQuery);

        $sResult .= $sQuery . "\n";

        return $sResult;
    }
    
    protected function _setRoles($sTable)
    {
        $sResult = '';

        $aItems = $this->_oDb->getAll("SELECT `id`, `visible_for_levels` FROM `" . $sTable . "` ORDER BY `id` ASC"); 
        foreach($aItems as $aItem) {
            if (($iValue = (int)$aItem['visible_for_levels']) && $iValue < 2147483647) {
                if (($iValue & $this->_LevelMaskTo) == $this->_LevelMaskTo){
                    $iValue -= $this->_LevelMaskTo;
                }

                if (($iValue & $this->_LevelMaskFrom) == $this->_LevelMaskFrom){
                    $iValue += $this->_LevelMaskTo;
                }

                if ($iValue != (int)$aItem['visible_for_levels']){
                    $sQuery = "UPDATE `" . $sTable . "` SET `visible_for_levels` = " . $iValue . " WHERE `id` = ". $aItem['id'];
                    $this->_oDb->query($sQuery);

                    $sResult .= $sQuery . "\n";
                }
            }
        }
        
        return $sResult;
    }
    
    protected function finish ($iCode, $sMsg = null, $bAddLn = true)
    {
        if (!$this->_bQuiet && null !== $sMsg)
            echo $sMsg . ($bAddLn ? "\n" : '');
        exit($iCode);
    }

    protected function output ($sMsg, $bAddLn = true)
    {
        if (!$this->_bQuiet)
            echo $sMsg . ($bAddLn ? "\n" : '');
    }
}

$o = new BxDolAclCopyCmd();
$o->main();

/** @} */
