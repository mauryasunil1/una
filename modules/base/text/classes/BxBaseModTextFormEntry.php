<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    BaseText Base classes for text modules
 * @ingroup     UnaModules
 *
 * @{
 */

/**
 * Create/Edit entry form
 */
class BxBaseModTextFormEntry extends BxBaseModGeneralFormEntry
{
    protected $_sGhostTemplateVideo = 'form_ghost_template_video.html';
    protected $_sGhostTemplateSound = 'form_ghost_template_sound.html';
    protected $_sGhostTemplateFile = 'form_ghost_template_file.html';

    public function __construct($aInfo, $oTemplate = false)
    {
        parent::__construct($aInfo, $oTemplate);

        $CNF = &$this->_oModule->_oConfig->CNF;

        if(($sKf = 'FIELD_COVER') && ($sKs = 'OBJECT_STORAGE') && isset($CNF[$sKf], $CNF[$sKs]) && isset($this->aInputs[$CNF[$sKf]])) {
            if($this->_oModule->checkAllowedSetThumb() === CHECK_ACTION_RESULT_ALLOWED) {
                $this->aInputs[$CNF[$sKf]]['storage_object'] = $CNF[$sKs];
                $this->aInputs[$CNF[$sKf]]['uploaders'] = !empty($this->aInputs[$CNF[$sKf]]['value']) ? unserialize($this->aInputs[$CNF[$sKf]]['value']) : $CNF['OBJECT_UPLOADERS'];
                $this->aInputs[$CNF[$sKf]]['upload_buttons_titles'] = array(
                    'Simple' => _t($CNF['T']['form_field_covers_uploader_simple']), 
                    'HTML5' => _t($CNF['T']['form_field_covers_uploader_html5'])
                );
                $this->aInputs[$CNF[$sKf]]['images_transcoder'] = $CNF['OBJECT_IMAGES_TRANSCODER_PREVIEW'];
                $this->aInputs[$CNF[$sKf]]['storage_private'] = 0;
                $this->aInputs[$CNF[$sKf]]['multiple'] = false;
                $this->aInputs[$CNF[$sKf]]['content_id'] = 0;
                $this->aInputs[$CNF[$sKf]]['ghost_template'] = '';
            }
            else
                unset($this->aInputs[$CNF[$sKf]]);
        }

        if(($sKf = 'FIELD_PHOTO') && ($sKs = 'OBJECT_STORAGE_PHOTOS') && isset($CNF[$sKf], $CNF[$sKs]) && isset($this->aInputs[$CNF[$sKf]])) {
            $this->aInputs[$CNF[$sKf]]['storage_object'] = $CNF[$sKs];
            $this->aInputs[$CNF[$sKf]]['uploaders'] = !empty($this->aInputs[$CNF[$sKf]]['value']) ? unserialize($this->aInputs[$CNF[$sKf]]['value']) : $CNF['OBJECT_UPLOADERS'];
            $this->aInputs[$CNF[$sKf]]['images_transcoder'] = $CNF['OBJECT_IMAGES_TRANSCODER_PREVIEW_PHOTOS'];
            $this->aInputs[$CNF[$sKf]]['storage_private'] = 0;
            $this->aInputs[$CNF[$sKf]]['multiple'] = true;
            $this->aInputs[$CNF[$sKf]]['content_id'] = 0;
            $this->aInputs[$CNF[$sKf]]['ghost_template'] = '';
            $this->aInputs[$CNF[$sKf]]['tr_attrs'] = array('class'=> 'bx-base-text-attachment-item');
        }

        if(($sKf = 'FIELD_SOUND') && ($sKs = 'OBJECT_STORAGE_SOUNDS')  && isset($CNF[$sKf], $CNF[$sKs]) && isset($this->aInputs[$CNF[$sKf]])) {
            $this->aInputs[$CNF[$sKf]]['storage_object'] = $CNF[$sKs];
            $this->aInputs[$CNF[$sKf]]['uploaders'] = !empty($this->aInputs[$CNF[$sKf]]['value']) ? unserialize($this->aInputs[$CNF[$sKf]]['value']) : $CNF['OBJECT_UPLOADERS'];
            $this->aInputs[$CNF[$sKf]]['images_transcoder'] = $CNF['OBJECT_IMAGES_TRANSCODER_PREVIEW_FILES'];
            $this->aInputs[$CNF[$sKf]]['storage_private'] = 0;
            $this->aInputs[$CNF[$sKf]]['multiple'] = true;
            $this->aInputs[$CNF[$sKf]]['content_id'] = 0;
            $this->aInputs[$CNF[$sKf]]['ghost_template'] = '';
            $this->aInputs[$CNF[$sKf]]['tr_attrs'] = array('class'=> 'bx-base-text-attachment-item');
        }

        if(($sKf = 'FIELD_VIDEO') && ($sKs = 'OBJECT_STORAGE_VIDEOS') && isset($CNF[$sKf], $CNF[$sKs]) && isset($this->aInputs[$CNF[$sKf]])) {
            $this->aInputs[$CNF[$sKf]]['storage_object'] = $CNF[$sKs];
            $this->aInputs[$CNF[$sKf]]['uploaders'] = !empty($this->aInputs[$CNF[$sKf]]['value']) ? unserialize($this->aInputs[$CNF[$sKf]]['value']) : $CNF['OBJECT_UPLOADERS'];
            $this->aInputs[$CNF[$sKf]]['images_transcoder'] = $CNF['OBJECT_VIDEOS_TRANSCODERS']['poster_preview'];
            $this->aInputs[$CNF[$sKf]]['storage_private'] = 0;
            $this->aInputs[$CNF[$sKf]]['multiple'] = true;
            $this->aInputs[$CNF[$sKf]]['content_id'] = 0;
            $this->aInputs[$CNF[$sKf]]['ghost_template'] = '';
            $this->aInputs[$CNF[$sKf]]['tr_attrs'] = array('class'=> 'bx-base-text-attachment-item');
        }
        
        if(($sKf = 'FIELD_FILE') && ($sKs = 'OBJECT_STORAGE_FILES') && isset($CNF[$sKf], $CNF[$sKs]) && isset($this->aInputs[$CNF[$sKf]])) {
            $this->aInputs[$CNF[$sKf]]['storage_object'] = $CNF[$sKs];
            $this->aInputs[$CNF[$sKf]]['uploaders'] = !empty($this->aInputs[$CNF[$sKf]]['value']) ? unserialize($this->aInputs[$CNF[$sKf]]['value']) : $CNF['OBJECT_UPLOADERS'];
            $this->aInputs[$CNF[$sKf]]['images_transcoder'] = $CNF['OBJECT_IMAGES_TRANSCODER_PREVIEW_FILES'];
            $this->aInputs[$CNF[$sKf]]['storage_private'] = 0;
            $this->aInputs[$CNF[$sKf]]['multiple'] = true;
            $this->aInputs[$CNF[$sKf]]['content_id'] = 0;
            $this->aInputs[$CNF[$sKf]]['ghost_template'] = '';
            $this->aInputs[$CNF[$sKf]]['tr_attrs'] = array('class'=> 'bx-base-text-attachment-item');
        }

        if(($sKf = 'FIELD_POLL') && isset($CNF[$sKf]) && isset($this->aInputs[$CNF[$sKf]])) {
            $this->aInputs[$CNF[$sKf]]['tr_attrs'] = array('class'=> 'bx-base-text-attachment-item');
        }
    }

    function addCssJsPolls($bDynamicMode = false)
    {
        $sInclude = parent::addCssJsPolls($bDynamicMode);
        $sInclude .= $this->_oModule->_oTemplate->addJs(['modules/base/text/js/|polls.js', 'polls.js'], $bDynamicMode);
        return $bDynamicMode ? $sInclude : '';
    }

    function getCode($bDynamicMode = false)
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $sResult = parent::getCode($bDynamicMode);
        if(!empty($CNF['OBJECT_MENU_ENTRY_ATTACHMENTS'])){
            $oMenu = BxDolMenu::getObjectInstance($CNF['OBJECT_MENU_ENTRY_ATTACHMENTS']);
            $oMenu->setContentId((int)$this->_iContentId);
            $sResult = $this->_oModule->_oTemplate->parseHtmlByContent($sResult, array(
                'attachments_menu' =>  $oMenu->getCode()
            ));
        }
        
        if(isset($CNF['PARAM_LINKS_ENABLED']) && $CNF['PARAM_LINKS_ENABLED'] === true) {
            $sInclude = '';
            $sInclude .= $this->_oModule->_oTemplate->addCss(array('links.css'), $bDynamicMode);
            $sInclude .= $this->_oModule->_oTemplate->addJs(array('modules/base/text/js/|links.js', 'links.js'), $bDynamicMode);

            $sResult .= ($bDynamicMode ? $sInclude : '') . $this->_oModule->_oTemplate->getJsCode('links', [
                'sFormId' => $this->getId(), 
                'iContentId' => (int)$this->_iContentId,
                'iLimitAttachLinks' => (int)getParam($CNF['PARAM_LINKS_LIMIT']),
                'sLimitAttachLinksErr' => bx_js_string(_t('_sys_txt_err_attach_links')),
                'oAttachedLinks' => []
            ]);
        }  

    	return $sResult;
    }

    function initChecker ($aValues = array (), $aSpecificValues = array())
    {
        $CNF = &$this->_oModule->_oConfig->CNF;

        $bValues = $aValues && !empty($aValues['id']);
        $iValueId = $bValues ? (int)$aValues['id'] : 0;
        $iUserId = $this->_oModule->getUserId();
        $aContentInfo = $bValues ? $this->_oModule->_oDb->getContentInfoById($aValues['id']) : false;
            
        if (isset($CNF['FIELD_VIDEO']) && isset($this->aInputs[$CNF['FIELD_VIDEO']])) {
            if ($bValues)
                $this->aInputs[$CNF['FIELD_VIDEO']]['content_id'] = $aValues['id'];

            $this->aInputs[$CNF['FIELD_VIDEO']]['ghost_template'] = $this->_oModule->_oTemplate->parseHtmlByName($this->_sGhostTemplateVideo, $this->_getVideoGhostTmplVars($aContentInfo));
        }
        
        if (isset($CNF['FIELD_SOUND']) && isset($this->aInputs[$CNF['FIELD_SOUND']])) {
            if ($bValues)
                $this->aInputs[$CNF['FIELD_SOUND']]['content_id'] = $aValues['id'];

            $this->aInputs[$CNF['FIELD_SOUND']]['ghost_template'] = $this->_oModule->_oTemplate->parseHtmlByName($this->_sGhostTemplateSound, $this->_getSoundGhostTmplVars($aContentInfo));
        }

        if (isset($CNF['FIELD_FILE']) && isset($this->aInputs[$CNF['FIELD_FILE']])) {
            if ($bValues)
                $this->aInputs[$CNF['FIELD_FILE']]['content_id'] = $aValues['id'];

            $this->aInputs[$CNF['FIELD_FILE']]['ghost_template'] = $this->_oModule->_oTemplate->parseHtmlByName($this->_sGhostTemplateFile, $this->_getFileGhostTmplVars($aContentInfo));
        }
        
        parent::initChecker ($aValues, $aSpecificValues);

        if(isset($CNF['FIELD_LINK']) && isset($this->aInputs[$CNF['FIELD_LINK']])) {
            if(!$iValueId && !$this->isSubmitted())
                $this->_oModule->deleteAttachLinksUnused($iUserId);

            $this->aInputs[$CNF['FIELD_LINK']]['content'] = $this->_oModule->_oTemplate->getAttachLinkField($iUserId, $iValueId);
        }
    }

    function update ($iContentId, $aValsToAdd = array(), &$aTrackTextFieldsChanges = null)
    {
       return parent::update ($iContentId, $aValsToAdd, $aTrackTextFieldsChanges);
    }
    
    protected function genCustomInputAttachments ($aInput)
    {
        return '__attachments_menu__' . $this->_oModule->_oTemplate->parseHtmlByName('uploader_progress.html', []);
    }
    
    public function processLinks ($sFieldLink, $iContentId = 0)
    {
        
        if (!isset($this->aInputs[$sFieldLink]))
            return true;

        $aLinkIds = $this->getCleanValue($sFieldLink);
        if(empty($aLinkIds) || !is_array($aLinkIds))
            return true;
        
        foreach($aLinkIds as $iLinkId)
            $this->_oModule->_oDb->saveLink($iContentId, $iLinkId);
    }
    

    protected function _getVideoGhostTmplVars($aContentInfo = array())
    {
    	$CNF = &$this->_oModule->_oConfig->CNF;

    	return array (
            'name' => $this->aInputs[$CNF['FIELD_VIDEO']]['name'],
            'content_id' => (int)$this->aInputs[$CNF['FIELD_VIDEO']]['content_id'],
            'editor_id' => isset($CNF['FIELD_TEXT_ID']) ? $CNF['FIELD_TEXT_ID'] : '',
            'embed_url' => BX_DOL_URL_ROOT . $this->_oModule->_oConfig->getBaseUri() . 'file_embed_video/',
    	);
    }

    protected function _getSoundGhostTmplVars($aContentInfo = array())
    {
    	$CNF = &$this->_oModule->_oConfig->CNF;

    	return array (
            'name' => $this->aInputs[$CNF['FIELD_SOUND']]['name'],
            'content_id' => (int)$this->aInputs[$CNF['FIELD_SOUND']]['content_id'],
            'editor_id' => isset($CNF['FIELD_TEXT_ID']) ? $CNF['FIELD_TEXT_ID'] : '',
            'embed_url' => BX_DOL_URL_ROOT . $this->_oModule->_oConfig->getBaseUri() . 'file_embed_sound/',
    	);
    }

    protected function _getFileGhostTmplVars($aContentInfo = array())
    {
    	$CNF = &$this->_oModule->_oConfig->CNF;

    	return array (
            'name' => $this->aInputs[$CNF['FIELD_FILE']]['name'],
            'content_id' => (int)$this->aInputs[$CNF['FIELD_FILE']]['content_id'],
            'editor_id' => isset($CNF['FIELD_TEXT_ID']) ? $CNF['FIELD_TEXT_ID'] : ''
    	);
    }
}

/** @} */
