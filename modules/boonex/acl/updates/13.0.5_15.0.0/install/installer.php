<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxAclUpdater extends BxDolStudioUpdater
{
    function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }

    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_acl_level_prices', 'caption'))
                $this->oDb->query("ALTER TABLE `bx_acl_level_prices` ADD `caption` varchar(128) NOT NULL default '' AFTER `name`");
            if(!$this->oDb->isFieldExists('bx_acl_level_prices', 'description'))
                $this->oDb->query("ALTER TABLE `bx_acl_level_prices` ADD `description` text NOT NULL AFTER `caption`");
            if(!$this->oDb->isFieldExists('bx_acl_level_prices', 'details'))
                $this->oDb->query("ALTER TABLE `bx_acl_level_prices` ADD `details` text NOT NULL AFTER `description`");
            if(!$this->oDb->isFieldExists('bx_acl_level_prices', 'added'))
                $this->oDb->query("ALTER TABLE `bx_acl_level_prices` ADD `added` int(11) NOT NULL default '0' AFTER `immediate`");
            if(!$this->oDb->isFieldExists('bx_acl_level_prices', 'active'))
                $this->oDb->query("ALTER TABLE `bx_acl_level_prices` ADD `active` tinyint(4) NOT NULL default '1' AFTER `added`");

            if($this->oDb->isIndexExists('bx_acl_level_prices', 'type'))
                $this->oDb->query("ALTER TABLE `bx_acl_level_prices` DROP KEY `type`");
        }

        return parent::actionExecuteSql($sOperation);
    }
}
