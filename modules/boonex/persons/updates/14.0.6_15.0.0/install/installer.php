<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxPersonsUpdater extends BxDolStudioUpdater
{
    function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }

    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_persons_data', 'badge'))
                $this->oDb->query("ALTER TABLE `bx_persons_data` ADD `badge` int(11) NOT NULL default '0' AFTER `cover_data`");
            if(!$this->oDb->isFieldExists('bx_persons_data', 'badge_link'))
                $this->oDb->query("ALTER TABLE `bx_persons_data` ADD `badge_link` varchar(255) NOT NULL default '' AFTER `badge`");
            if(!$this->oDb->isFieldExists('bx_persons_data', 'rrate'))
                $this->oDb->query("ALTER TABLE `bx_persons_data` ADD `rrate` float NOT NULL default '0' AFTER `votes`");
            if(!$this->oDb->isFieldExists('bx_persons_data', 'rvotes'))
                $this->oDb->query("ALTER TABLE `bx_persons_data` ADD `rvotes` int(11) NOT NULL default '0' AFTER `rrate`");
        }

        return parent::actionExecuteSql($sOperation);
    }

}
