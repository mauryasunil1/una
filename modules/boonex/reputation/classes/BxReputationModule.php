<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Reputation Reputation
 * @ingroup     UnaModules
 *
 * @{
 */

class BxReputationModule extends BxBaseModNotificationsModule
{
    public function __construct($aModule)
    {
        parent::__construct($aModule);

        $this->_oConfig->init($this->_oDb);
    }

    /**
     * ACTION METHODS
     */
    public function actionCheckName()
    {
        $CNF = &$this->_oConfig->CNF;

    	$sName = bx_process_input(bx_get('name'));
    	if(empty($sName))
            return echoJson([]);

        $sResult = '';
        if(($iId = (int)bx_get('id')) != 0) {
            $aLevel = $this->_oDb->getLevels(['sample' => 'id', 'id' => $iId]);
            if(strcmp($sName, $aLevel[$CNF['FIELD_LEVEL_NAME']]) == 0) 
                $sResult = $sName;
        }

    	echoJson([
            'name' => !empty($sResult) ? $sResult : $this->_oConfig->getLevelName($sName)
    	]);
    }

    /**
     * SERVICE METHODS
     */
    public function serviceAssignPoints($iProfileId, $iPoints, $iContextId = 0)
    {
        return $this->assignPoints($iProfileId, $iContextId, $iPoints);
    }

    public function serviceGetLevels($iProfileId)
    {
        return $this->_oDb->getLevels([
            'sample' => 'profile_id', 
            'profile_id' => $iProfileId
        ]);
    }

    public function serviceGetBlockActions($iStart = 0, $iLimit = 0)
    {
        if(($iGetStart = bx_get('start')) !== false)
            $iStart = (int)$iGetStart;
        if(($iGetPerPage = bx_get('per_page')) !== false)
            $iLimit = (int)$iGetPerPage;

        $mixedResult = $this->_oTemplate->getBlockActions($iStart, $iLimit);

        return !$this->_bIsApi ? $mixedResult : [
            bx_api_get_block('reputation_actions', $mixedResult)
        ];
    }

    public function serviceGetBlockLevels()
    {
        $mixedResult = $this->_oTemplate->getBlockLevels();

        return !$this->_bIsApi ? $mixedResult : [
            bx_api_get_block('reputation_levels', $mixedResult)
        ];
    }

    public function serviceGetBlockSummary($iProfileId = 0, $iContextId = 0)
    {
        if(!$iProfileId && ($iLoggedId = bx_get_logged_profile_id()))
            $iProfileId = $iLoggedId;
        if(!$iProfileId)
            return false;

        $mixedResult = $this->_oTemplate->getBlockSummary($iProfileId, $iContextId);

        return !$this->_bIsApi ? $mixedResult : [
            bx_api_get_block('reputation_summary', array_merge($mixedResult, [
                'actions_list' => $this->_oTemplate->getBlockActions(),
                'levels_list' => $this->_oTemplate->getBlockLevels()
            ]))
        ];
    }

    public function serviceGetBlockHistory($iProfileId = 0, $iContextId = 0, $iStart = 0, $iLimit = 0)
    {
        if(!$iProfileId && ($iLoggedId = bx_get_logged_profile_id()))
            $iProfileId = $iLoggedId;
        if(!$iProfileId)
            return false;

        if(($iGetStart = bx_get('start')) !== false)
            $iStart = (int)$iGetStart;
        if(($iGetPerPage = bx_get('per_page')) !== false)
            $iLimit = (int)$iGetPerPage;

        return $this->_oTemplate->getBlockHistory($iProfileId, $iContextId, $iStart, $iLimit);
    }

    public function serviceGetBlockLeaderboard($iContextId = 0, $iDays = 0)
    {
        return $this->_oTemplate->getBlockLeaderboard($iContextId, $iDays);
    }

    public function serviceGetBlockWidget($iProfileId = 0, $iContextId = 0)
    {
        if(!$iProfileId && ($iLoggedId = bx_get_logged_profile_id()))
            $iProfileId = $iLoggedId;
        if(!$iProfileId)
            return false;

        if(!$this->_bIsApi)
            return false;

        $sModule = $this->getName();
        $sLangKey = '_bx_reputation_page_block_title_';

        $sParamProfile = '&params[]=' . $iProfileId;
        $sParamContext = ($iContextId = (int)$iContextId) ? '&params[]=' . $iContextId : '';

        return [
            bx_api_get_block('reputation_widget', [
                'tabs'=> [
                    ['url' => '/api.php?r=' . $sModule . '/get_block_summary' . $sParamProfile . $sParamContext, 'title' => _t($sLangKey . 'summary')],
                    ['url' => '/api.php?r=' . $sModule . '/get_block_leaderboard' . $sParamContext . '&params[]=7', 'title' => _t($sLangKey . 'leaderboard_week')],
                    ['url' => '/api.php?r=' . $sModule . '/get_block_leaderboard' . $sParamContext . '&params[]=30', 'title' => _t($sLangKey . 'leaderboard_month')],
                    ['url' => '/api.php?r=' . $sModule . '/get_block_leaderboard' . $sParamContext . '', 'title' => _t($sLangKey . 'leaderboard_all_time')]
                ]
            ])
        ];
    }

    /**
     * COMMON METHODS
     */
    public function assignPoints($iProfileId, $iContextId, $iPoints)
    {
        if(!$this->_oDb->insertProfile($iProfileId, $iContextId, $iPoints))
            return false; 

        $this->assignLevels($iProfileId, $iContextId);

        return true; 
    }
    
    public function assignLevels($iProfileId, $iContextId)
    {
        $iProfilePoints = $this->_oDb->getProfilePoints($iProfileId, $iContextId);

        $aLevels = $this->_oDb->getLevels([
            'sample' => 'points', 
            'points' => $iProfilePoints
        ]);

        $bMultilevel = $this->_oConfig->isMultilevel();
        if($bMultilevel)
            $this->_oDb->deleteProfilesLevelsByPoints($iProfileId, $iContextId, $iProfilePoints);

        foreach($aLevels as $aLevel) {
            $iLevelId = (int)$aLevel['id'];
            if($this->hasLevel($iProfileId, $iContextId, $iLevelId))
                continue;

            if(!$bMultilevel)
                $this->_oDb->deleteProfilesLevels([
                    'sample' => 'profile_id', 
                    'profile_id' => $iProfileId, 
                    'context_id' => $iContextId
                ]);

            $this->_oDb->insertProfilesLevels([
                'profile_id' => $iProfileId, 
                'context_id' => $iContextId,
                'level_id' => $iLevelId
            ]);
        }
    }

    public function hasLevel($iProfileId, $iContextId, $iLevelId)
    {
        $aProfileLevels = $this->_oDb->getLevels([
            'sample' => 'profile_id', 
            'profile_id' => $iProfileId,
            'context_id' => $iContextId
        ]);

        foreach($aProfileLevels as $aProfileLevel)
            if($aProfileLevel['id'] == $iLevelId)
                return true;

        return false;
    }

    public function  getUnitTitle($sUnit)
    {
        if(($sKey = '_' . $sUnit) && ($_sKey = _t($sKey)) && strcmp($sKey, $_sKey) != 0)
            return $_sKey;

        if(($sKey = '_bx_reputation_txt_au_' . $sUnit) && ($_sKey = _t($sKey)) && strcmp($sKey, $_sKey) != 0)
            return $_sKey;

        if(($iPosition = strpos($sUnit, '_fans')) !== false)
            return _t('_bx_reputation_txt_au_module_fans', _t('_' . substr($sUnit, 0, $iPosition)));

        return $sUnit;
    }

    public function  getActionTitle($sAction)
    {
        return _t('_bx_reputation_txt_aa_' . $sAction);
    }
}

/** @} */
