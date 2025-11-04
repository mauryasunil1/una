<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Posts Posts
 * @ingroup     UnaModules
 *
 * @{
 */

/**
 * Create/Edit entry form
 */
class BxPostsFormEntry extends BxBaseModTextFormEntry
{
    protected $_sGhostTemplateCover = 'form_ghost_template_cover.html';
	
    public function __construct($aInfo, $oTemplate = false)
    {
        $this->MODULE = 'bx_posts';

        parent::__construct($aInfo, $oTemplate);
    }

    function initChecker ($aValues = array (), $aSpecificValues = array())
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $bValues = $aValues && !empty($aValues['id']);
        $aContentInfo = $bValues ? $this->_oModule->_oDb->getContentInfoById($aValues['id']) : false;

        if($this->aParams['display'] == $CNF['OBJECT_FORM_ENTRY_DISPLAY_EDIT'] && isset($CNF['FIELD_PUBLISHED']) && isset($this->aInputs[$CNF['FIELD_PUBLISHED']]))
            if($bValues && in_array($aValues[$CNF['FIELD_STATUS']], array('active', 'hidden')))
                unset($this->aInputs[$CNF['FIELD_PUBLISHED']]);

        if (isset($CNF['FIELD_COVER']) && isset($this->aInputs[$CNF['FIELD_COVER']])) {
            if($bValues)
                $this->aInputs[$CNF['FIELD_COVER']]['content_id'] = $aValues['id'];

            $this->aInputs[$CNF['FIELD_COVER']]['ghost_template'] = $this->_oModule->_oTemplate->parseHtmlByName($this->_sGhostTemplateCover, $this->_getCoverGhostTmplVars($aContentInfo));
        }

        parent::initChecker ($aValues, $aSpecificValues);
    }

    public function insert ($aValsToAdd = array(), $isIgnore = false)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        if(isset($CNF['FIELD_ADDED']) && empty($aValsToAdd[$CNF['FIELD_ADDED']])) {
            $iAdded = 0;
            if(isset($this->aInputs[$CNF['FIELD_ADDED']]))
                $iAdded = $this->getCleanValue($CNF['FIELD_ADDED']);

            if(empty($iAdded))
                 $iAdded = time();

            $aValsToAdd[$CNF['FIELD_ADDED']] = $iAdded;
        }

        if(empty($aValsToAdd[$CNF['FIELD_PUBLISHED']])) {
            $iPublished = 0;
            if(isset($this->aInputs[$CNF['FIELD_PUBLISHED']]))
                $iPublished = $this->getCleanValue($CNF['FIELD_PUBLISHED']);
                
             if(empty($iPublished))
                 $iPublished = time();

             $aValsToAdd[$CNF['FIELD_PUBLISHED']] = $iPublished;
        }

        $aValsToAdd[$CNF['FIELD_STATUS']] = $aValsToAdd[$CNF['FIELD_PUBLISHED']] > $aValsToAdd[$CNF['FIELD_ADDED']] ? 'awaiting' : 'active';

        $iContentId = parent::insert ($aValsToAdd, $isIgnore);
        if(!empty($iContentId)){
            $this->processFiles($CNF['FIELD_COVER'], $iContentId, true);
        }
        return $iContentId;
    }

    function update ($iContentId, $aValsToAdd = array(), &$aTrackTextFieldsChanges = null)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        if(empty($aValsToAdd[$CNF['FIELD_PUBLISHED']]) && isset($this->aInputs[$CNF['FIELD_PUBLISHED']])) {
            $iPublished = $this->getCleanValue($CNF['FIELD_PUBLISHED']);
            if(empty($iPublished))
                $iPublished = time();

            $aValsToAdd[$CNF['FIELD_PUBLISHED']] = $iPublished;
        }

        $iResult = parent::update ($iContentId, $aValsToAdd, $aTrackTextFieldsChanges);
        $this->processFiles($CNF['FIELD_COVER'], $iContentId, false);   
        return $iResult;
    }

    protected function _getCoverGhostTmplVars($aContentInfo = array())
    {
    	$CNF = &$this->_oModule->_oConfig->CNF;

    	return array (
            'name' => $this->aInputs[$CNF['FIELD_COVER']]['name'],
            'content_id' => $this->aInputs[$CNF['FIELD_COVER']]['content_id'],
            'editor_id' => isset($CNF['FIELD_TEXT_ID']) ? $CNF['FIELD_TEXT_ID'] : '',
            'thumb_id' => isset($CNF['FIELD_THUMB']) && isset($aContentInfo[$CNF['FIELD_THUMB']]) ? $aContentInfo[$CNF['FIELD_THUMB']] : 0,
            'name_thumb' => isset($CNF['FIELD_THUMB']) ? $CNF['FIELD_THUMB'] : '',
        );
    }

    protected function _getPhotoGhostTmplVars($aContentInfo = array())
    {
    	$CNF = &$this->_oModule->_oConfig->CNF;

    	return array (
            'name' => $this->aInputs[$CNF['FIELD_PHOTO']]['name'],
            'content_id' => (int)$this->aInputs[$CNF['FIELD_PHOTO']]['content_id'],
            'editor_id' => isset($CNF['FIELD_TEXT_ID']) ? $CNF['FIELD_TEXT_ID'] : '',
            'bx_if:set_thumb' => [
				'condition' => false,
				'content' => []
			],
    	);
    }
}

/** @} */
