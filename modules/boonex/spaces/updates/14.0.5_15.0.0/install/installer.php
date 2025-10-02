<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxSpacesUpdater extends BxDolStudioUpdater
{
    public function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }

    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_spaces_data', 'multicat'))
                $this->oDb->query("ALTER TABLE `bx_spaces_data` ADD `multicat` text NOT NULL AFTER `space_desc`");
            if(!$this->oDb->isFieldExists('bx_spaces_data', 'members'))
                $this->oDb->query("ALTER TABLE `bx_spaces_data` ADD `members` int(11) NOT NULL default '0' AFTER `location`");
            if(!$this->oDb->isFieldExists('bx_spaces_data', 'rrate'))
                $this->oDb->query("ALTER TABLE `bx_spaces_data` ADD `rrate` float NOT NULL default '0' AFTER `votes`");
            if(!$this->oDb->isFieldExists('bx_spaces_data', 'rvotes'))
                $this->oDb->query("ALTER TABLE `bx_spaces_data` ADD `rvotes` int(11) NOT NULL default '0' AFTER `rrate`");
            if(!$this->oDb->isFieldExists('bx_spaces_data', 'srate'))
                $this->oDb->query("ALTER TABLE `bx_spaces_data` ADD `srate` float NOT NULL default '0' AFTER `rvotes`");
            if(!$this->oDb->isFieldExists('bx_spaces_data', 'svotes'))
                $this->oDb->query("ALTER TABLE `bx_spaces_data` ADD `svotes` int(11) NOT NULL default '0' AFTER `srate`");

            if(!$this->oDb->isFieldExists('bx_spaces_prices', 'caption'))
                $this->oDb->query("ALTER TABLE `bx_spaces_prices` ADD `caption` varchar(128) NOT NULL default '' AFTER `name`");
            if(!$this->oDb->isFieldExists('bx_spaces_prices', 'added'))
                $this->oDb->query("ALTER TABLE `bx_spaces_prices` ADD `added` int(11) NOT NULL default '0' AFTER `price`");
            if(!$this->oDb->isFieldExists('bx_spaces_prices', 'default'))
                $this->oDb->query("ALTER TABLE `bx_spaces_prices` ADD `default` tinyint(4) NOT NULL default '0' AFTER `order`");
            if(!$this->oDb->isFieldExists('bx_spaces_prices', 'active'))
                $this->oDb->query("ALTER TABLE `bx_spaces_prices` ADD `active` tinyint(4) NOT NULL default '1' AFTER `default`");
        }

        return parent::actionExecuteSql($sOperation);
    }
}
