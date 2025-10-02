<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxTasksUpdater extends BxDolStudioUpdater
{
    public function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }
    
    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_tasks_tasks', 'type'))
                $this->oDb->query("ALTER TABLE `bx_tasks_tasks` ADD `type` int(11) NOT NULL default '0' AFTER `title`");
            if(!$this->oDb->isFieldExists('bx_tasks_tasks', 'priority'))
                $this->oDb->query("ALTER TABLE `bx_tasks_tasks` ADD `priority` int(11) NOT NULL default '0' AFTER `type`");
            if(!$this->oDb->isFieldExists('bx_tasks_tasks', 'state'))
                $this->oDb->query("ALTER TABLE `bx_tasks_tasks` ADD `state` int(11) NOT NULL default '0' AFTER `priority`");
        }

        return parent::actionExecuteSql($sOperation);
    }

}
