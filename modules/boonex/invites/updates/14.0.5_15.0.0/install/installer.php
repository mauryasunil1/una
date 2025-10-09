<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

class BxInvUpdater extends BxDolStudioUpdater
{
    function __construct($aConfig)
    {
        parent::__construct($aConfig);
    }

    public function actionExecuteSql($sOperation)
    {
        if($sOperation == 'install') {
            if(!$this->oDb->isFieldExists('bx_inv_invites', 'multi'))
                $this->oDb->query("ALTER TABLE `bx_inv_invites` ADD `multi` tinyint(4) DEFAULT '0' AFTER `key`");
            if(!$this->oDb->isFieldExists('bx_inv_invites', 'email_use'))
                $this->oDb->query("ALTER TABLE `bx_inv_invites` ADD `email_use` tinyint(4) DEFAULT '0' AFTER `email`");
            if(!$this->oDb->isFieldExists('bx_inv_invites', 'aj_action'))
                $this->oDb->query("ALTER TABLE `bx_inv_invites` ADD `aj_action` varchar(32) NOT NULL default '' AFTER `email_use`");
            if(!$this->oDb->isFieldExists('bx_inv_invites', 'aj_params'))
                $this->oDb->query("ALTER TABLE `bx_inv_invites` ADD `aj_params` varchar(255) NOT NULL default '' AFTER `aj_action`");

            if($this->oDb->isFieldExists('bx_inv_invites', 'redirect')) {
                $this->oDb->query("UPDATE `bx_inv_invites` SET `aj_action`='redirect', `aj_params`=`redirect` WHERE `redirect`<>''");

                $this->oDb->query("ALTER TABLE `bx_inv_invites` DROP COLUMN `redirect`");
            }
        }

        return parent::actionExecuteSql($sOperation);
    }

}
