<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Workspaces Workspaces
 * @ingroup     UnaModules
 *
 * @{
 */

class BxWorkspacesAlertsResponse extends BxBaseModProfileAlertsResponse
{
    public function __construct()
    {
    	$this->MODULE = 'bx_workspaces';
        parent::__construct();
    }

    public function response($oAlert)
    {
        $sContextModule = getParam('bx_workspaces_context_module');

        // TODO: replace 'bx_groups_fans' with proper connection object from $sContextModule

        if ($sContextModule && 'system' == $oAlert->sUnit && 'connection_before_add' == $oAlert->sAction && isset($oAlert->aExtras['object_name']) && $oAlert->aExtras['object_name'] == 'bx_groups_fans') {
            $this->_oModule->addConnection($sContextModule, $oAlert);
        } 

        if ($sContextModule && 'system' == $oAlert->sUnit && 'connection_removed' == $oAlert->sAction && isset($oAlert->aExtras['object_name']) && $oAlert->aExtras['object_name'] == 'bx_groups_fans') {
            $this->_oModule->removeConnection($sContextModule, $oAlert);
        }
    }
}

/** @} */
