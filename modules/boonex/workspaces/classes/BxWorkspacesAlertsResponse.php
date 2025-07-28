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

        // logo URL is refferring to the context when in workspace
        if ('system' == $oAlert->sUnit && 'get_logo' == $oAlert->sAction && bx_get_context_workspace()) {
            $o = BxDolProfile::getInstance(bx_get_context_workspace());
            if ($o) {
                $oAlert->aExtras['tmpl_vars']['attrs'] = preg_replace('/href="([^"]+)" title="([^"]+)"/', 'href="' . $o->getUrl() . '" title="' . $o->getDisplayName() . '"', $oAlert->aExtras['tmpl_vars']['attrs']);
            }
        }

        // site menu is off when in workspace
        if ($sContextModule && 'menu' == $oAlert->sUnit && 'get_code_before' == $oAlert->sAction && isset($oAlert->aExtras['object_name']) && $oAlert->aExtras['object_name'] == 'sys_site' && bx_get_context_workspace()) {
            $oAlert->aExtras['override_result'] = "site menu is off when in workspace (" . bx_get_context_workspace() . ")";
        }

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
