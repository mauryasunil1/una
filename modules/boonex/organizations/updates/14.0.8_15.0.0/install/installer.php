<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxOrgsUpdater extends BxDolStudioUpdater
{
    function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }

    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_organizations_data', 'badge'))
                $this->oDb->query("ALTER TABLE `bx_organizations_data` ADD `badge` int(11) NOT NULL default '0' AFTER `cover_data`");
            if(!$this->oDb->isFieldExists('bx_organizations_data', 'badge_link'))
                $this->oDb->query("ALTER TABLE `bx_organizations_data` ADD `badge_link` varchar(255) NOT NULL default '' AFTER `badge`");
            if(!$this->oDb->isFieldExists('bx_organizations_data', 'members'))
                $this->oDb->query("ALTER TABLE `bx_organizations_data` ADD `members` int(11) NOT NULL default '0' AFTER `location`");
            if(!$this->oDb->isFieldExists('bx_organizations_data', 'rrate'))
                $this->oDb->query("ALTER TABLE `bx_organizations_data` ADD `rrate` float NOT NULL default '0' AFTER `votes`");
            if(!$this->oDb->isFieldExists('bx_organizations_data', 'rvotes'))
                $this->oDb->query("ALTER TABLE `bx_organizations_data` ADD `rvotes` int(11) NOT NULL default '0' AFTER `rrate`");

            if(!$this->oDb->isFieldExists('bx_organizations_prices', 'caption'))
                $this->oDb->query("ALTER TABLE `bx_organizations_prices` ADD `caption` varchar(128) NOT NULL default '' AFTER `name`");
            if(!$this->oDb->isFieldExists('bx_organizations_prices', 'added'))
                $this->oDb->query("ALTER TABLE `bx_organizations_prices` ADD `added` int(11) NOT NULL default '0' AFTER `price`");
            if(!$this->oDb->isFieldExists('bx_organizations_prices', 'default'))
                $this->oDb->query("ALTER TABLE `bx_organizations_prices` ADD `default` tinyint(4) NOT NULL default '0' AFTER `order`");
            if(!$this->oDb->isFieldExists('bx_organizations_prices', 'active'))
                $this->oDb->query("ALTER TABLE `bx_organizations_prices` ADD `active` tinyint(4) NOT NULL default '1' AFTER `default`");
        }

        return parent::actionExecuteSql($sOperation);
    }

}
