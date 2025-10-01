<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxGroupsUpdater extends BxDolStudioUpdater
{
    function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }

    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_groups_data', 'members'))
                $this->oDb->query("ALTER TABLE `bx_groups_data` ADD `members` int(11) NOT NULL default '0' AFTER `location`");
            if(!$this->oDb->isFieldExists('bx_groups_data', 'rrate'))
                $this->oDb->query("ALTER TABLE `bx_groups_data` ADD `rrate` float NOT NULL default '0' AFTER `votes`");
            if(!$this->oDb->isFieldExists('bx_groups_data', 'rvotes'))
                $this->oDb->query("ALTER TABLE `bx_groups_data` ADD `rvotes` int(11) NOT NULL default '0' AFTER `rrate`");

            if(!$this->oDb->isFieldExists('bx_groups_prices', 'caption'))
                $this->oDb->query("ALTER TABLE `bx_groups_prices` ADD `caption` varchar(128) NOT NULL default '' AFTER `name`");
            if(!$this->oDb->isFieldExists('bx_groups_prices', 'added'))
                $this->oDb->query("ALTER TABLE `bx_groups_prices` ADD `added` int(11) NOT NULL default '0' AFTER `price`");
            if(!$this->oDb->isFieldExists('bx_groups_prices', 'default'))
                $this->oDb->query("ALTER TABLE `bx_groups_prices` ADD `default` tinyint(4) NOT NULL default '0' AFTER `order`");
            if(!$this->oDb->isFieldExists('bx_groups_prices', 'active'))
                $this->oDb->query("ALTER TABLE `bx_groups_prices` ADD `active` tinyint(4) NOT NULL default '1' AFTER `default`");
        }

        return parent::actionExecuteSql($sOperation);
    }

}
