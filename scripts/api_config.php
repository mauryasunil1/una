<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    UnaCoreScripts Scripts
 * @{
 */

$aPathInfo = pathinfo(__FILE__);
require_once ($aPathInfo['dirname'] . '/../inc/header.inc.php');
require_once(BX_DIRECTORY_PATH_INC . 'design.inc.php');

class BxDolApiConfig
{
    protected $_oDb;

    public function __construct() 
    {
        $this->_oDb = BxDolDb::getInstance();
    }

    public function getQueries()
    {
        $sResult = "";

        $sResult .= "-- \n-- To copy 'Config API':\n-- ";
        $sResult .= $this->_getQueriesPagesConfigApi();
        $sResult .= $this->_getQueriesMenusConfigApi();
        
        $sResult .= "\n\n\n";

        /*
         * TODO: Don't include active_api for triggers (menu items, page blocks)
         */
        $sResult .= "-- \n-- To copy 'Active API':\n-- ";
        $sResult .= $this->_getQueriesPagesActiveApi();
        $sResult .= $this->_getQueriesMenusActiveApi();

        echo "<pre>" . $sResult . "</pre>";
    }

    protected function _getQueriesPagesConfigApi()
    {
        $aPages = $this->_oDb->getAll("SELECT `object`, `config_api` FROM `sys_objects_page` WHERE `config_api` <> '' ORDER BY `id` ASC");

        $sResult = "\n\n-- PAGES:\n";
        foreach($aPages as $aPage)
            $sResult .= $this->_oDb->prepareAsString("UPDATE `sys_objects_page` SET `config_api`=? WHERE `object`=?;\n", $aPage['config_api'], $aPage['object']);

        $aBlocks = $this->_oDb->getAll("SELECT `object`, `module`, `title_system`, `title`, `config_api` FROM `sys_pages_blocks` WHERE `config_api` <> '' ORDER BY `id` ASC");
        
        $sResult .= "\n\n-- PAGE BLOCKS:\n";
        foreach($aBlocks as $aBlock)
            $sResult .= $this->_oDb->prepareAsString("UPDATE `sys_pages_blocks` SET `config_api`=? WHERE `object`=? AND `module`=? AND `title_system`=? AND `title`=?;\n", $aBlock['config_api'], $aBlock['object'], $aBlock['module'], $aBlock['title_system'], $aBlock['title']);

        return $sResult;
    }

    protected function _getQueriesPagesActiveApi()
    {
        $aBlocks = $this->_oDb->getAll("SELECT `object`, `module`, `title_system`, `title`, `active_api` FROM `sys_pages_blocks` WHERE `active_api` <> '0' ORDER BY `id` ASC");
        
        $sResult = "\n\n-- PAGE BLOCKS:\n";
        foreach($aBlocks as $aBlock)
            $sResult .= $this->_oDb->prepareAsString("UPDATE `sys_pages_blocks` SET `active_api`=? WHERE `object`=? AND `module`=? AND `title_system`=? AND `title`=?;\n", $aBlock['active_api'], $aBlock['object'], $aBlock['module'], $aBlock['title_system'], $aBlock['title']);

        return $sResult;
    }

    protected function _getQueriesMenusConfigApi()
    {
        $aMenus = $this->_oDb->getAll("SELECT `object`, `config_api` FROM `sys_objects_menu` WHERE `config_api` <> '' ORDER BY `id` ASC");

        $sResult = "\n\n-- MENUS:\n";
        foreach($aMenus as $aMenu)
            $sResult .= $this->_oDb->prepareAsString("UPDATE `sys_objects_menu` SET `config_api`=? WHERE `object`=?;\n", $aMenu['config_api'], $aMenu['object']);

        $aItems = $this->_oDb->getAll("SELECT `set_name`, `module`, `name`, `config_api` FROM `sys_menu_items` WHERE `config_api` <> '' ORDER BY `id` ASC");

        $sResult .= "\n\n-- MENU ITEMS:\n";
        foreach($aItems as $aItem)
            $sResult .= $this->_oDb->prepareAsString("UPDATE `sys_menu_items` SET `config_api`=? WHERE `set_name`=? AND `module`=? AND `name`=?;\n", $aItem['config_api'], $aItem['set_name'], $aItem['module'], $aItem['name']);

        return $sResult;
    }

    protected function _getQueriesMenusActiveApi()
    {
        $aItems = $this->_oDb->getAll("SELECT `set_name`, `module`, `name`, `active_api` FROM `sys_menu_items` WHERE `active_api` <> '0' ORDER BY `id` ASC");

        $sResult = "\n\n-- MENU ITEMS:\n";
        foreach($aItems as $aItem)
            $sResult .= $this->_oDb->prepareAsString("UPDATE `sys_menu_items` SET `active_api`=? WHERE `set_name`=? AND `module`=? AND `name`=?;\n", $aItem['active_api'], $aItem['set_name'], $aItem['module'], $aItem['name']);

        return $sResult;
    }
}

$o = new BxDolApiConfig();
$o->getQueries();

/** @} */
