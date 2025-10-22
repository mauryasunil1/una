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
            if(!$this->oDb->isFieldExists('bx_tasks_tasks', 'time'))
                $this->oDb->query("ALTER TABLE `bx_tasks_tasks` ADD `time` int(11) NOT NULL default '0' AFTER `labels`");
            if(!$this->oDb->isFieldExists('bx_tasks_tasks', 'estimate'))
                $this->oDb->query("ALTER TABLE `bx_tasks_tasks` ADD `estimate` int(11) NOT NULL default '0' AFTER `priority`");
        }

        return parent::actionExecuteSql($sOperation);
    }

}
