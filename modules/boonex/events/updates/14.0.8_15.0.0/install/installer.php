<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxEventsUpdater extends BxDolStudioUpdater
{
    function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }

    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_events_data', 'date_max'))
                $this->oDb->query("ALTER TABLE `bx_events_data` ADD `date_max` int(11) DEFAULT NULL AFTER `date_end`");
            if(!$this->oDb->isFieldExists('bx_events_data', 'members'))
                $this->oDb->query("ALTER TABLE `bx_events_data` ADD `members` int(11) NOT NULL default '0' AFTER `threshold`");
            if(!$this->oDb->isFieldExists('bx_events_data', 'rrate'))
                $this->oDb->query("ALTER TABLE `bx_events_data` ADD `rrate` float NOT NULL default '0' AFTER `votes`");
            if(!$this->oDb->isFieldExists('bx_events_data', 'rvotes'))
                $this->oDb->query("ALTER TABLE `bx_events_data` ADD `rvotes` int(11) NOT NULL default '0' AFTER `rrate`");

            if(!$this->oDb->isFieldExists('bx_events_prices', 'caption'))
                $this->oDb->query("ALTER TABLE `bx_events_prices` ADD `caption` varchar(128) NOT NULL default '' AFTER `name`");
            if(!$this->oDb->isFieldExists('bx_events_prices', 'added'))
                $this->oDb->query("ALTER TABLE `bx_events_prices` ADD `added` int(11) NOT NULL default '0' AFTER `price`");
            if(!$this->oDb->isFieldExists('bx_events_prices', 'default'))
                $this->oDb->query("ALTER TABLE `bx_events_prices` ADD `default` tinyint(4) NOT NULL default '0' AFTER `votes`");
            if(!$this->oDb->isFieldExists('bx_events_prices', 'active'))
                $this->oDb->query("ALTER TABLE `bx_events_prices` ADD `active` tinyint(4) NOT NULL default '1' AFTER `default`");
        }

        return parent::actionExecuteSql($sOperation);
    }

}
