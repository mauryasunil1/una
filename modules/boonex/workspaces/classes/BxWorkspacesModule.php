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

/**
 * Workspace profiles module.
 */
class BxWorkspacesModule extends BxBaseModProfileModule
{
    function __construct(&$aModule)
    {
        parent::__construct($aModule);

        $this->_aSearchableNamesExcept[] = $this->_oConfig->CNF['FIELD_AUTHOR'];
    }
    
    /**
     * @page service Service Calls
     * @section bx_workspaces Workspaces 
     * @subsection bx_workspaces-other Other
     * @subsubsection bx_workspaces-get_search_options
     * 
     * @code bx_srv('bx_workspaces', 'get_search_options', [...]); @endcode
     * 
     * Get options for searchable fields
     * 
     * @return array - params or false.
     * 
     * @see BxWorkspacesModule::serviceGetSearchOptions
     */
    /** 
     * @ref bx_workspaces-get_search_options "get_search_options"
     */
    public function serviceGetSearchOptions ($sField, $sFieldType, $sSearchType)
    {
        $CNF = $this->_oConfig->CNF;
        if (isset($CNF['OBJECT_FORM_ENTRY']) && isset($CNF['OBJECT_FORM_ENTRY_DISPLAY_ADD'])){
            $oForm = BxDolForm::getObjectInstance($CNF['OBJECT_FORM_ENTRY'], $CNF['OBJECT_FORM_ENTRY_DISPLAY_ADD'], $this->_oTemplate);
            foreach ($oForm->aInputs as $aFld) {
                if ($aFld['name'] == $sField && $aFld['type'] == $sFieldType && isset($aFld['checker']) && isset($aFld['checker']['params'])){
                    return $aFld['checker']['params'];
                }
            }
        }
        
        if (isset($CNF['OBJECT_FORM_ENTRY']) && isset($CNF['OBJECT_FORM_ENTRY_DISPLAY_EDIT'])){
            $oForm = BxDolForm::getObjectInstance($CNF['OBJECT_FORM_ENTRY'], $CNF['OBJECT_FORM_ENTRY_DISPLAY_EDIT'], $this->_oTemplate);
            foreach ($oForm->aInputs as $aFld) {
                if ($aFld['name'] == $sField && $aFld['type'] == $sFieldType && isset($aFld['checker']) && isset($aFld['checker']['params'])){
                    return $aFld['checker']['params'];
                }
            }
        }
        
        return false;
    }

    public function serviceGetContextModules ()
    {
        $a = bx_srv('system', 'get_modules_by_subtype_simple', ['context']);
        return array_merge(['' => _t('_sys_please_select')], $a);
    }

    public function getSubtypes()
    {
        return pow(2, BX_DOL_MODULE_SUBTYPE_PROFILE);
    }

    public function getProfileName ($aContentInfo)
    {
        return bx_process_output('User' . $aContentInfo[$this->_oConfig->CNF['FIELD_ID']]);
    }

    // autoswitch currently active user profiule to the ws profile if user already has ws profile in given group context
    public function autoSwitchProfile($oProfileGroup)
    {
        $oAccount = BxDolAccount::getInstance();
        $aProfiles = $oAccount->getProfilesIds();
        $aFans = bx_srv($oProfileGroup->getModule(), 'fans', [$oProfileGroup->getContentId(), true]);
        $a = array_intersect($aProfiles, $aFans);
        if ($a) {
            foreach ($a as $iProfileId) {
                $oProfile = BxDolProfile::getInstance($iProfileId);
                if ($oProfile->getModule() == $this->getName()) {
                    $oAccount->updateProfileContext($iProfileId);
                    return true;
                }
            }
        }
        return false;
    }

    public function addConnection($sContextModule, $oAlert)
    {
        $iProfileIdSubstituteInAlert = 0;
        $iProfileIdCreated = 0;

        // identify group profile and workspace profile
        [$oProfileGroup, $oProfileWs] = $this->_identifyGroupAndWorkspaceProfiles($sContextModule, $oAlert);

        // check for existing connection switch to ws profile if exising connection is found
        // TODO: call this method on any group view page, also update global context is needed
        if ($this->autoSwitchProfile($oProfileGroup)) {
            $oAlert->aExtras['override_result'] = true;
            return;
        }

        // check for old connection with this group id, if old ws profile which was associated with this group is found then switch to this old ws profile id
        if (null === $oProfileWs) {
            $a = BxDolAccount::getInstance()->getProfiles();
            foreach ($a as $iProfileId => $aProfile) {
                if ($aProfile['type'] == $this->getName()) {
                    $iAllowViewTo = bx_srv($aProfile['type'], 'get_privacy_view', [$aProfile['content_id']]);
                    if (abs($iAllowViewTo) == $oProfileGroup->id()) {
                        $iProfileIdSubstituteInAlert = $iProfileId;
                        break;
                    }
                }
            }
        }

        // create new workspace profile if needed, context is automatically siwtched to newly created profile
        if (!$iProfileIdSubstituteInAlert && null === $oProfileWs) {
            $aInfo = [
                'allow_view_to' => -$oProfileGroup->id(),
                'allow_post_to' => 5,
                'allow_contact_to' => -$oProfileGroup->id(),
            ];
            $a = bx_srv('system', 'add', ['bx_workspaces', $aInfo], 'TemplServiceContent');
            if (0 === $a['code']) {
                $iProfileIdSubstituteInAlert = $a['content']['profile_id'];
                $iProfileIdCreated = $a['content']['profile_id'];
            }
        }

        // substitute profile id with ws profile id in alert
        if (null === $oProfileWs) {
            $oAlert->aExtras['initiator'] = $iProfileIdSubstituteInAlert;
        }

        // switch context to the profile in context (context is already automatically switched when new profile is created)
        if (!$iProfileIdCreated && $iProfileIdSubstituteInAlert) {
            BxDolAccount::getInstance()->updateProfileContext($iProfileIdSubstituteInAlert);
        }
    }

    public function removeConnection($sContextModule, $oAlert)
    {
        $oAccount = BxDolAccount::getInstance();

        // identify group profile and workspace profile
        [$oProfileGroup, $oProfileWs] = $this->_identifyGroupAndWorkspaceProfiles($sContextModule, $oAlert);    
        if (!$oProfileWs) // no need to switch context if no workspace profile was used 
            return;


        // switch profile id from ws profile id to real profile id, if previous profile was ws profile and if colled in proper context module
        $iProfileIdReal = null;
        $a = $oAccount->getProfilesIds();
        foreach ($a as $iProfileId) {
            $oProfile = BxDolProfile::getInstance($iProfileId);
            if ($oProfile->getModule() != $this->getName()) {
                $iProfileIdReal = $oProfile->id();
            }
        }
        
        // TODO: if no profile was found - use account profile id
        if (!$iProfileIdReal) {

        }

        // switch current context
        if ($iProfileIdReal)
            $oAccount->updateProfileContext($iProfileIdReal);
    }

    // identify group profile and workspace profile
    protected function _identifyGroupAndWorkspaceProfiles($sContextModule, $oAlert)
    {        
        $oProfileGroup = null;
        $oProfileWs = null;

        $oProfileInitiator = BxDolProfile::getInstance($oAlert->aExtras['initiator']);
        $oProfileContent = BxDolProfile::getInstance($oAlert->aExtras['content']);

        $a = [$oProfileInitiator, $oProfileContent];
        foreach ($a as $o) {
            if ($sContextModule == $o->getModule()) // detect group based profile
                $oProfileGroup = $o;
            elseif ($this->getName() == $o->getModule()) // detect workspace profile
                $oProfileWs = $o;
        }
        return [$oProfileGroup, $oProfileWs];
    }
}

/** @} */
