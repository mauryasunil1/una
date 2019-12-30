<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    UnaCore UNA Core
 * @{
 */

bx_import('BxDolAcl');

define('BX_DOL_CMT_TYPE_COMMENT', 'comment');
define('BX_DOL_CMT_TYPE_REVIEW', 'review');

define('BX_CMT_OLD_VOTES', 365*86400); ///< comment votes older than this number of seconds will be deleted automatically

define('BX_CMT_ACTION_POST', 'post');
define('BX_CMT_ACTION_EDIT', 'edit');

define('BX_CMT_DISPLAY_FLAT', 'flat');
define('BX_CMT_DISPLAY_THREADED', 'threaded');

define('BX_CMT_BROWSE_HEAD', 'head');
define('BX_CMT_BROWSE_TAIL', 'tail');
define('BX_CMT_BROWSE_POPULAR', 'popular');
define('BX_CMT_BROWSE_CONNECTION', 'connection');

define('BX_CMT_ORDER_BY_DATE', 'date');
define('BX_CMT_ORDER_BY_POPULAR', 'popular');

define('BX_CMT_FILTER_ALL', 'all');
define('BX_CMT_FILTER_OTHERS', 'others');
define('BX_CMT_FILTER_FRIENDS', 'friends');
define('BX_CMT_FILTER_SUBSCRIPTIONS', 'subscriptions');

define('BX_CMT_ORDER_WAY_ASC', 'asc');
define('BX_CMT_ORDER_WAY_DESC', 'desc');

define('BX_CMT_PFP_TOP', 'top');
define('BX_CMT_PFP_BOTTOM', 'bottom');

define('BX_CMT_RATE_VALUE_PLUS', 1);
define('BX_CMT_RATE_VALUE_MINUS', -1);

define('BX_CMT_USAGE_BLOCK', 'block');
define('BX_CMT_USAGE_INLINE', 'inline');
define('BX_CMT_USAGE_DEFAULT', BX_CMT_USAGE_BLOCK);

/**
 * Comments for any content
 *
 * Related classes:
 * - BxDolCmtsQuery - comments database queries
 * - BxBaseCmts - comments base representation
 * - BxTemplCmts - custom template representation
 *
 * AJAX comments for any content.
 * Self moderated - users rate all comments, and if comment is
 * below viewing treshold it is hidden by default.
 *
 * To add comments section to your module you need to add a record to 'sys_objects_cmts' table:
 *
 * - ID - autoincremented id for internal usage
 * - ObjectName - your unique module name, with vendor prefix, lowercase and spaces are underscored
 * - TableCmts - table name where comments are stored
 * - Html - 0 - convert new lines to <br /> on saving, 1 - standard(default) visual editor, 2 - full visual editor, 3 - mini visual editor.
 * - PerView - number of comments on a page
 * - IsRatable - 0 or 1 allow to rate comments or not
 * - ViewingThreshold - comment viewing treshost, if comment is below this number it is hidden by default
 * - IsOn - is this comment object enabled
 * - RootStylePrefix - toot comments style prefix, if you need root comments look different\
 * - ObjectVote - Vote object name to process comments' votes. May be empty if Comment Vote is not needed.
 * - TriggerTable - table to be updated upon each comment
 * - TriggerFieldId - TriggerTable table field with unique record id of
 * - TriggerFieldComments - TriggerTable table field with comments count, it will be updated automatically upon eaech comment
 * - ClassName - your custom class name if you need to override default class, this class must have the same constructor arguments
 * - ClassFile - file where your ClassName is stored.
 *
 * You can refer to BoonEx modules for sample record in this table.
 *
 *
 *
 * @section example Example of usage:
 * After filling in the table you can show comments section in any place, using the following code:
 *
 * @code
 * $o = new BxTemplCmts('value of ObjectName field', $iYourEntryId);
 * if ($o->isEnabled())
 *     echo $o->getCommentsFirst ();
 * @endcode
 *
 * Please note that you never need to use BxDolCmts class directly, use BxTemplCmts instead.
 * Also if you override comments class with your own then make it child of BxTemplCmts class.
 *
 *
 *
 * @section acl Memberships/ACL:
 * - comments post
 * - comments edit own
 * - comments remove own
 * - comments edit all
 *
 *
 *
 * @section alerts Alerts:
 * Alerts type/unit - every module has own type/unit, it equals to ObjectName.
 *
 * The following alerts are rised
 *
 * - commentPost - comment was posted
 *      - $iObjectId - entry id
 *      - $iSenderId - author of comment
 *      - $aExtra['comment_id'] - just added comment id
 *
 * - commentRemoved - comments was removed
 *      - $iObjectId - entry id
 *      - $iSenderId - comment deleter id
 *      - $aExtra['comment_id'] - removed comment id
 *
 * - commentUpdated - comments was updated
 *      - $iObjectId - entry id
 *      - $iSenderId - comment deleter id
 *      - $aExtra['comment_id'] - updated comment id
 *
 * - commentRated - comments was rated
 *      - $iObjectId - entry id
 *      - $iSenderId - comment rater id
 *      - $aExtra['comment_id'] - rated comment id
 *      - $aExtra['rate'] - comment rate 1 or -1
 *
 */
class BxDolCmts extends BxDolFactory implements iBxDolReplaceable, iBxDolContentInfoService
{
    /**
     * System tables which are UNITED for all 
     * comment systems and cannot be overwritten.
     */
    public static $sTableSystems = 'sys_objects_cmts';
    public static $sTableIds = 'sys_cmts_ids';

    /**
     * System tables which are used by default and
     * can be overwritten in comment systems.
     * @see BxDolCmts::getTableNameImages and BxDolCmts::getTableNameImages2Entries
     */
    protected $_sTableImages = 'sys_cmts_images';
    protected $_sTableImages2Entries = 'sys_cmts_images2entries';

    protected $_sType;
    protected $_oQuery = null;
    protected $_oTemplate = null;

    protected $_bPostQuote;
    protected $_bMinPostForm;
    protected $_sFormObject;
    protected $_sFormDisplayPost;
    protected $_sFormDisplayEdit;

    protected $_sConnObjFriends;
    protected $_sConnObjSubscriptions;

    protected $_sMenuObjManage;
    protected $_sMenuObjActions;
    protected $_sMenuObjMeta;

    protected $_sMetatagsObj;

    protected $_sViewUrl = '';
    protected $_sBaseUrl = '';
    protected $_sListAnchor = '';
    protected $_sItemAnchor = '';

    protected $_sSystem = 'profile'; ///< current comment system name
    protected $_aSystem = array (); ///< current comments system array
    protected $_iId = 0; ///< obect id to be commented

    protected $_aT = array (); ///< an array of lang keys
    protected $_aMarkers = array ();

    protected $_sDisplayType = '';
    protected $_sDpSessionKey = '';
    protected $_iDpMaxLevel = 0;

    protected $_sBrowseType = '';
    protected $_bBrowseFilter = false;
    protected $_sBrowseFilter = '';
    protected $_sBpSessionKeyType = '';
    protected $_sBpSessionKeyFilter = '';
    protected $_aOrder = array();

    protected $_sSnippetLenthLiveSearch = 50;

    protected $_iRememberTime = 2592000;

    /**
     * Constructor
     * $sSystem - comments system name
     * $iId - obect id to be commented
     */
    protected function __construct($sSystem, $iId, $iInit = true, $oTemplate = false)
    {
        parent::__construct();

        $this->_sType = BX_DOL_CMT_TYPE_COMMENT;

        $this->_aSystems = $this->getSystems();
        if(!isset($this->_aSystems[$sSystem]))
            return;

        $this->_sSystem = $sSystem;
        $this->_aSystem = $this->_aSystems[$sSystem];

        $this->_aSystem['is_browse_filter'] = (int)$this->_bBrowseFilter;

        $this->_iDpMaxLevel = (int)$this->_aSystem['number_of_levels'];
        $this->_sDisplayType = $this->_iDpMaxLevel == 0 ? BX_CMT_DISPLAY_FLAT : BX_CMT_DISPLAY_THREADED;
        $this->_sDpSessionKey = 'bx_' . $this->_sSystem . '_dp_';

        $this->_sBrowseType = $this->_aSystem['browse_type'];
        $this->_sBrowseFilter = BX_CMT_FILTER_ALL;
        $this->_sBpSessionKeyType = 'bx_' . $this->_sSystem . '_bpt_';
        $this->_sBpSessionKeyFilter = 'bx_' . $this->_sSystem . '_bpf_';
        $this->_aOrder = array(
            'by' => BX_CMT_ORDER_BY_DATE,
            'way' => BX_CMT_ORDER_WAY_ASC
        );

        list($mixedUserDp, $mixedUserBpType, $mixedUserBpFilter) = $this->_getUserChoice();
        if(!empty($mixedUserDp))
            $this->_sDisplayType = $mixedUserDp;
        if(!empty($mixedUserBpType))
            $this->_sBrowseType = $mixedUserBpType;
        if(!empty($mixedUserBpFilter))
            $this->_sBrowseFilter = $mixedUserBpFilter;

        $this->_sViewUrl = BX_DOL_URL_ROOT . 'page.php?i=cmts-view';
        $this->_sBaseUrl = BxDolPermalinks::getInstance()->permalink($this->_aSystem['base_url']);
        if(get_mb_substr($this->_sBaseUrl, 0, 4) != 'http')
            $this->_sBaseUrl = BX_DOL_URL_ROOT . $this->_sBaseUrl;
        $this->_sListAnchor = "cmts-anchor-%s-%d";
        $this->_sItemAnchor = "cmt-anchor-%s-%d-%d";

        $this->_oQuery = new BxDolCmtsQuery($this);

        $this->_bPostQuote = false;
        $this->_bMinPostForm = true;
        $this->_sFormObject = 'sys_comment';
        $this->_sFormDisplayPost = 'sys_comment_post';
        $this->_sFormDisplayEdit = 'sys_comment_edit';

        $this->_sConnObjFriends = 'sys_profiles_friends';
        $this->_sConnObjSubscriptions = 'sys_profiles_subscriptions';

        $this->_sMenuObjManage = 'sys_cmts_item_manage';
        $this->_sMenuObjActions = 'sys_cmts_item_actions';
        $this->_sMenuObjMeta = 'sys_cmts_item_meta';

        $this->_sMetatagsObj = 'sys_cmts';

        $this->_aT = array(
            'block_comments_title' => '_cmt_block_comments_title',
            'txt_sample_single' => '_cmt_txt_sample_comment_single',
            'txt_sample_vote_single' => '_cmt_txt_sample_vote_single',
            'txt_sample_reaction_single' => '_cmt_txt_sample_reaction_single',
            'txt_sample_score_up_single' => '_cmt_txt_sample_score_up_single',
            'txt_sample_score_down_single' => '_cmt_txt_sample_score_down_single',
            'txt_min_form_placeholder' => '_cmt_txt_min_form_placeholder'
        );

        if ($iInit)
            $this->init($iId);

        if ($oTemplate)
            $this->_oTemplate = $oTemplate;
        else
            $this->_oTemplate = BxDolTemplate::getInstance();
    }

    /**
     * get comments object instanse
     * @param $sSys comments object name
     * @param $iId associated content id, where comments are postred in
     * @param $iInit perform initialization
     * @return null on error, or ready to use class instance
     */
    public static function getObjectInstance($sSys, $iId, $iInit = true, $oTemplate = false)
    {
        if(isset($GLOBALS['bxDolClasses']['BxDolCmts!' . $sSys . $iId]))
            return $GLOBALS['bxDolClasses']['BxDolCmts!' . $sSys . $iId];

        $aSystems = self::getSystems();
        if (!isset($aSystems[$sSys]))
            return null;

        $sClassName = 'BxTemplCmts';
        if(!empty($aSystems[$sSys]['class_name'])) {
            $sClassName = $aSystems[$sSys]['class_name'];
            if(!empty($aSystems[$sSys]['class_file']))
                require_once(BX_DIRECTORY_PATH_ROOT . $aSystems[$sSys]['class_file']);
        }

        $o = new $sClassName($sSys, $iId, $iInit, $oTemplate);
        return ($GLOBALS['bxDolClasses']['BxDolCmts!' . $sSys . $iId] = $o);
    }

    public static function &getSystems ()
    {
        $sKey = 'bx_dol_cache_memory_cmts_systems';

        if (!isset($GLOBALS[$sKey])) {
            $GLOBALS[$sKey] = BxDolDb::getInstance()->fromCache('sys_objects_cmts', 'getAllWithKey', '
                SELECT
                    `ID` as `system_id`,
                    `Name` AS `name`,
                    `Module` AS `module`,
                    `Table` AS `table`,
                    `CharsPostMin` AS `chars_post_min`,
                    `CharsPostMax` AS `chars_post_max`,
                    `CharsDisplayMax` AS `chars_display_max`,
                    `Html` AS `html`,
                    `PerView` AS `per_view`,
                    `PerViewReplies` AS `per_view_replies`,
                    `BrowseType` AS `browse_type`,
                    `IsBrowseSwitch` AS `is_browse_switch`,
                    `PostFormPosition` AS `post_form_position`,
                    `NumberOfLevels` AS `number_of_levels`,
                    `IsDisplaySwitch` AS `is_display_switch`,
                    `IsRatable` AS `is_ratable`,
                    `ViewingThreshold` AS `viewing_threshold`,
                    `IsOn` AS `is_on`,
                    `RootStylePrefix` AS `root_style_prefix`,
                    `BaseUrl` AS `base_url`,
                    `ObjectVote` AS `object_vote`,
                    `ObjectReaction` AS `object_reaction`,
                    `ObjectScore` AS `object_score`,
                    `ObjectReport` AS `object_report`,
                    `TriggerTable` AS `trigger_table`,
                    `TriggerFieldId` AS `trigger_field_id`,
                    `TriggerFieldAuthor` AS `trigger_field_author`,
                    `TriggerFieldTitle` AS `trigger_field_title`,
                    `TriggerFieldComments` AS `trigger_field_comments`,
                    `ClassName` AS `class_name`,
                    `ClassFile` AS `class_file`
                FROM `' . self::$sTableSystems . '`', 'name');
        }
        return $GLOBALS[$sKey];
    }

    public static function getGlobalInfo ($iUniqueId)
    {
        return BxDolDb::getInstance()->getRow("SELECT `ti`.*, `ts`.`Name` AS `system_name` FROM `" . self::$sTableIds . "` AS `ti` LEFT JOIN `" . self::$sTableSystems . "` AS `ts` ON `ti`.`system_id`=`ts`.`ID` WHERE `ti`.`id`=:id LIMIT 1", array(
            'id' => (int)$iUniqueId
        ));
    }

    public function init ($iId)
    {
        if (empty($this->iId) && $iId)
            $this->setId($iId);

        $this->addMarkers(array(
            'object_id' => $this->getId(),
            'user_id' => $this->_getAuthorId()
        ));
    }

    public function getId ()
    {
        return $this->_iId;
    }

    public function isEnabled ()
    {
        return isset($this->_aSystem['is_on']) && $this->_aSystem['is_on'];
    }

    public function getSystemId()
    {
        return $this->_aSystem['system_id'];
    }

    public function getSystemName()
    {
        return $this->_sSystem;
    }

    public function getSystemInfo()
    {
        return $this->_aSystem;
    }

    public function getStorageObjectName()
    {
    	return $this->_getFormObject()->getStorageObjectName();
    }

    public function getTranscoderPreviewName()
    {
    	return $this->_getFormObject()->getTranscoderPreviewName();
    }

    public function getTableNameImages()
    {
        return $this->_sTableImages;
    }

    public function getTableNameImages2Entries()
    {
        return $this->_sTableImages2Entries;
    }

    public function getLanguageKey($sIndex)
    {
        return isset($this->_aT[$sIndex]) ? $this->_aT[$sIndex] : '';
    }

    public function getMaxLevel()
    {
        return $this->_iDpMaxLevel;
    }

    public function getOrder ()
    {
        return $this->_sOrder;
    }

    public function getPerView ($iCmtParentId = 0)
    {
        return $iCmtParentId == 0 ? $this->_aSystem['per_view'] : $this->_aSystem['per_view_replies'];
    }

    public function getViewUrl($iCmtId)
    {
    	if(empty($this->_aSystem['trigger_field_title']))
            return '';

    	return BxDolPermalinks::getInstance()->permalink($this->_sViewUrl, array(
            'sys' => $this->_sSystem,
            'id' => $this->_iId,
            'cmt_id' => $iCmtId
        ));
    }

    public function getBaseUrl()
    {
        return $this->_replaceMarkers($this->_sBaseUrl);
    }

    public function getListUrl()
    {
        $sBaseUrl = $this->getBaseUrl();
        if(empty($sBaseUrl))
            return '';

        return $sBaseUrl . $this->getListAnchor(true);
    }

    public function getItemUrl($iItemId)
    {
        $sBaseUrl = $this->getBaseUrl();
        if(empty($sBaseUrl))
            return '';

        return $sBaseUrl . $this->getItemAnchor($iItemId, true);
    }

    public function getListAnchor($bWithHash = false)
    {
        return ($bWithHash ? '#' : '') . sprintf($this->_sListAnchor, str_replace('_', '-', $this->getSystemName()), $this->getId());
    }

    public function getItemAnchor($iItemId, $bWithHash = false)
    {
        return ($bWithHash ? '#' : '') . sprintf($this->_sItemAnchor, str_replace('_', '-', $this->getSystemName()), $this->getId(), $iItemId);
    }

    public function getConnectionObject($sType)
    {
        $sResult = '';

        switch($sType) {
            case BX_CMT_FILTER_FRIENDS:
                $sResult = $this->_sConnObjFriends;
                break;
            case BX_CMT_FILTER_SUBSCRIPTIONS:
                $sResult = $this->_sConnObjSubscriptions;
                break;
        }

        return $sResult;
    }

    public function getVoteObject($iId)
    {
        if(empty($this->_aSystem['object_vote']))
            $this->_aSystem['object_vote'] = 'sys_cmts';

        $oVote = BxDolVote::getObjectInstance($this->_aSystem['object_vote'], $iId, true, $this->_oTemplate);
        if(!$oVote || !$oVote->isEnabled())
            return false;

        return $oVote;
    }

    public function getReactionObject($iId)
    {
        if(empty($this->_aSystem['object_reaction']))
            $this->_aSystem['object_reaction'] = 'sys_cmts_reactions';

        $oReaction = BxDolVote::getObjectInstance($this->_aSystem['object_reaction'], $iId, true, $this->_oTemplate);
        if(!$oReaction || !$oReaction->isEnabled())
            return false;

        return $oReaction;
    }

    public function getScoreObject($iId)
    {
        if(empty($this->_aSystem['object_score']))
        	$this->_aSystem['object_score'] = 'sys_cmts';

        $oScore = BxDolScore::getObjectInstance($this->_aSystem['object_score'], $iId, true, $this->_oTemplate);
        if(!$oScore || !$oScore->isEnabled())
            return false;

        return $oScore;
    }

    public function getReportObject($iId)
    {
        if(empty($this->_aSystem['object_report']))
        	$this->_aSystem['object_report'] = 'sys_cmts';

        $oReport = BxDolReport::getObjectInstance($this->_aSystem['object_report'], $iId, true, $this->_oTemplate);
        if(!$oReport || !$oReport->isEnabled())
            return false;

        return $oReport;
    }

    public function getNotificationId()
    {
        return 'cmts-notification-' . $this->_sSystem . '-' . $this->_iId;
    }

    /**
     * @deprecated since version 10.0.0-B3 and can be removed in later versions.
     */
    public function setTableNameFiles($sTable)
    {
        $this->_sTableImages = $sTable;
    	$this->_oQuery->setTableNameFiles($sTable);
    }

    /**
     * @deprecated since version 10.0.0-B3 and can be removed in later versions.
     */
    public function setTableNameFiles2Entries($sTable)
    {
    	$this->_sTableImages2Entries = $sTable;
    	$this->_oQuery->setTableNameFiles2Entries($sTable);
    }

    public function isHtml ()
    {
        return $this->_aSystem['html'] > 0;
    }

    public function isRatable ()
    {
        return $this->_aSystem['is_ratable'];
    }

    public function isAttachImageEnabled()
    {
        return true;
    }

    /**
     * set id to operate with votes
     */
    public function setId ($iId)
    {
        if ($iId == $this->getId()) return;
        $this->_iId = $iId;
    }

    /**
     * Add replace markers.
     * @param $a array of markers as key => value
     * @return true on success or false on error
     */
    public function addMarkers ($a)
    {
        if (empty($a) || !is_array($a))
            return false;
        $this->_aMarkers = array_merge ($this->_aMarkers, $a);
        return true;
    }

    /**
     * Database functions
     */
    public function getQueryObject ()
    {
        return $this->_oQuery;
    }

    public function getCommentsTableName ()
    {
        return $this->_oQuery->getTableName ();
    }

    public function getObjectAuthorId ($iObjectId = 0)
    {
    	if(empty($this->_aSystem['trigger_field_author']))
    		return 0;

        return $this->_oQuery->getObjectAuthorId ($iObjectId ? $iObjectId : $this->getId());
    }

    public function getObjectTitle ($iObjectId = 0)
    {
        if(empty($this->_aSystem['trigger_field_title']))
            return '';

        $sTitle = $this->_oQuery->getObjectTitle ($iObjectId ? $iObjectId : $this->getId());
        if(get_mb_substr($sTitle, 0, 1) == '_')
            $sTitle = _t($sTitle);

        return $sTitle;
    }

    public function getCommentsCountAll ($iObjectId = 0)
    {
        return $this->_oQuery->getCommentsCountAll ($iObjectId ? $iObjectId : $this->getId());
    }

    public function getCommentsCount ($iObjectId = 0, $iCmtVParentId = -1, $sFilter = '')
    {
        return $this->_oQuery->getCommentsCount ($iObjectId ? $iObjectId : $this->getId(), $iCmtVParentId, $this->_getAuthorId(), $sFilter);
    }

    public function getCommentsArray ($iVParentId, $sFilter, $aOrder, $iStart = 0, $iCount = -1)
    {
        return $this->_oQuery->getComments ($this->getId(), $iVParentId, $this->_getAuthorId(), $sFilter, $aOrder, $iStart, $iCount);
    }

    /**
     * Get comment's unique id.
     */
    public function getCommentUniqId($iCmtId, $iAuthorId = 0)
    {
        return $this->_oQuery->getUniqId($this->getSystemId(), $iCmtId, $iAuthorId);
    }

    /**
     * Get comment's short info.
     */
    public function getCommentSimple ($iCmtId)
    {
        return $this->_oQuery->getCommentSimple ($this->getId(), $iCmtId);
    }

    /**
     * Get comment's full info.
     */
    public function getCommentRow ($iCmtId)
    {
        return $this->_oQuery->getComment ($this->getId(), $iCmtId);
    }

    public function onObjectDelete ($iObjectId = 0)
    {
        // delete comments
        $aFiles = $aCmtIds = array();
        $this->_oQuery->deleteObjectComments ($iObjectId ? $iObjectId : $this->getId(), $aFiles, $aCmtIds);

        // delete meta info
        $this->deleteMetaInfo($aCmtIds);

        // delete files
        if ($aFiles) {
            $oStorage = BxDolStorage::getObjectInstance($this->getStorageObjectName());
            if ($oStorage)
                $oStorage->queueFilesForDeletion($aFiles);
        }
    }

    public static function onAuthorDelete ($iAuthorId)
    {
        $aSystems = self::getSystems();
        foreach($aSystems as $sSystem => $aSystem) {
            $o = self::getObjectInstance($sSystem, 0);
            $oQuery = $o->getQueryObject();

            // delete comments
            $aFiles = $aCmtIds = array ();
            $oQuery->deleteAuthorComments($iAuthorId, $aFiles, $aCmtIds);

            // delete meta info
            $o->deleteMetaInfo($aCmtIds);
    
            // delete files
            $oStorage = BxDolStorage::getObjectInstance($o->getStorageObjectName());
            if ($oStorage)
                $oStorage->queueFilesForDeletion($aFiles);
        }
        return true;
    }

    public static function onModuleEnable ($sModuleName)
    {
        $aSystems = self::getSystems();
        foreach($aSystems as $sSystem => $aSystem) {
            if ($sModuleName !== $aSystem['module'])
                continue;

            $o = self::getObjectInstance($sSystem, 0);
            $o->registerTranscoders();
        }

        return true;
    }

    public static function onModuleDisable ($sModuleName)
    {
        $aSystems = self::getSystems();
        foreach($aSystems as $sSystem => $aSystem) {
            if ($sModuleName !== $aSystem['module'])
                continue;

            $o = self::getObjectInstance($sSystem, 0);
            $o->unregisterTranscoders();
        }

        return true;
    }

    public static function onModuleUninstall ($sModuleName, &$iFiles = null)
    {
        $aSystems = self::getSystems();
        foreach($aSystems as $sSystem => $aSystem) {
            if ($sModuleName !== $aSystem['module'])
                continue;

            $o = self::getObjectInstance($sSystem, 0);
            $oQuery = $o->getQueryObject();

            // delete comments
            $aFiles = $aCmtIds = array ();
            $oQuery->deleteAll($aSystem['system_id'], $aFiles, $aCmtIds);

            // delete meta info
            $o->deleteMetaInfo($aCmtIds);

            // delete files
            $oStorage = BxDolStorage::getObjectInstance($o->getStorageObjectName());
            if ($oStorage && $aFiles)
                $oStorage->queueFilesForDeletion($aFiles);

            if (null !== $iFiles)
                $iFiles += count($aFiles);
        }

        return true;
    }

    public function deleteMetaInfo ($mixedCmtId)
    {
        if(!is_array($mixedCmtId))
            $mixedCmtId = array($mixedCmtId);

        $oMetatags = false;
        if(!empty($this->_sMetatagsObj))
            $oMetatags = BxDolMetatags::getObjectInstance($this->_sMetatagsObj);

        foreach($mixedCmtId as $iCmtId) {
            if($oMetatags)
                $oMetatags->onDeleteContent($this->_oQuery->getUniqId($this->_aSystem['system_id'], $iCmtId));

            $this->_oQuery->deleteCmtIds($this->_aSystem['system_id'], $iCmtId);
        }
    }

    /**
     * Permissions functions
     */
    public function isAdmin($iCmtAuthorId)
    {
        return BxDolAcl::getInstance()->isMemberLevelInSet(array(MEMBERSHIP_ID_MODERATOR, MEMBERSHIP_ID_ADMINISTRATOR), $iCmtAuthorId);
    }

    public function checkAction ($sAction, $isPerformAction = false)
    {
        $iId = $this->_getAuthorId();
        $a = checkActionModule($iId, $sAction, 'system', $isPerformAction);
        return $a[CHECK_ACTION_RESULT] === CHECK_ACTION_RESULT_ALLOWED;
    }

    public function checkActionErrorMsg ($sAction)
    {
        $iId = $this->_getAuthorId();
        $a = checkActionModule($iId, $sAction, 'system');
        return $a[CHECK_ACTION_RESULT] !== CHECK_ACTION_RESULT_ALLOWED ? $a[CHECK_ACTION_MESSAGE] : '';
    }

    public function isViewAllowed ($isPerformAction = false)
    {
        $mixedResult = BxDolService::call($this->_aSystem['module'], 'check_allowed_comments_view', array($this->getId(), $this->getSystemName()));
        if($mixedResult !== CHECK_ACTION_RESULT_ALLOWED)
            return $mixedResult;

        return CHECK_ACTION_RESULT_ALLOWED;
    }

    public function isVoteAllowed ($aCmt, $isPerformAction = false)
    {
        if(!$this->isRatable())
            return false;

        $oVote = $this->getVoteObject($aCmt['cmt_id']);
        if($oVote === false)
            return false;

        $iUserId = (int)$this->_getAuthorId();
        if($iUserId == 0)
            return false;

        if(isAdmin())
            return true;

        return $oVote->isAllowedVote($isPerformAction);
    }

    public function isScoreAllowed ($aCmt, $isPerformAction = false)
    {
        if(!$this->isRatable())
            return false;

        $oScore = $this->getScoreObject($aCmt['cmt_id']);
        if($oScore === false)
            return false;

        $iUserId = (int)$this->_getAuthorId();
        if($iUserId == 0)
            return false;

        if(isAdmin())
            return true;

        return $oScore->isAllowedVote($isPerformAction);
    }

    public function isReportAllowed ($aCmt, $isPerformAction = false)
    {
        $oReport = $this->getReportObject($aCmt['cmt_id']);
        if($oReport === false)
            return false;

        $iUserId = (int)$this->_getAuthorId();
        if($iUserId == 0)
            return false;

        if(isAdmin())
            return true;

        return $oReport->isAllowedReport($isPerformAction);
    }

    public function isPostAllowed ($isPerformAction = false)
    {
        $mixedResult = BxDolService::call($this->_aSystem['module'], 'check_allowed_comments_post', array($this->getId(), $this->getSystemName()));
        if($mixedResult !== CHECK_ACTION_RESULT_ALLOWED)
            return false;

        return $this->checkAction ('comments post', $isPerformAction);
    }

    public function msgErrPostAllowed ()
    {
        return $this->checkActionErrorMsg('comments post');
    }

    /**
     * Determines whether a 'reply' action allowed or not.
     * @param integer or array $mixedCmt - ID or an array which describes the comment to be replied
     * @param boolean $isPerformAction
     * @return boolean
     */
    public function isReplyAllowed ($mixedCmt, $isPerformAction = false)
    {
        return $this->isPostAllowed($isPerformAction);
    }

    public function msgErrReplyAllowed ()
    {
        return $this->msgErrPostAllowed ();
    }

    public function isQuoteAllowed ($mixedCmt, $isPerformAction = false)
    {
        return $this->_bPostQuote && $this->isReplyAllowed ($mixedCmt, $isPerformAction);
    }

    public function msgErrQuoteAllowed ()
    {
        return $this->msgErrReplyAllowed ();
    }

    public function isEditAllowed ($aCmt, $isPerformAction = false)
    {
        if(isAdmin())
            return true;

        if($this->isEditAllowedAll($isPerformAction))
            return true;

        $mixedResult = BxDolService::call($this->_aSystem['module'], 'check_allowed_comments_post', array($this->getId(), $this->getSystemName()));
        if($mixedResult !== CHECK_ACTION_RESULT_ALLOWED)
            return false;

        return abs($aCmt['cmt_author_id']) == $this->_getAuthorId() && $this->checkAction ('comments edit own', $isPerformAction);
    }

    public function msgErrEditAllowed ()
    {
        return $this->checkActionErrorMsg ('comments edit own');
    }

    public function isEditAllowedAll ($isPerformAction = false)
    {
        return $this->checkAction('comments edit all', $isPerformAction);
    }

    public function isRemoveAllowed ($aCmt, $isPerformAction = false)
    {
        if(isAdmin())
            return true;

        if($this->isRemoveAllowedAll($isPerformAction))
            return true;

        return abs($aCmt['cmt_author_id']) == $this->_getAuthorId() && $this->checkAction ('comments remove own', $isPerformAction);
    }

    public function isRemoveAllowedAll ($isPerformAction = false)
    {
        return $this->checkAction ('comments remove all', $isPerformAction);
    }

    public function msgErrRemoveAllowed ()
    {
        return $this->checkActionErrorMsg('comments remove own');
    }

    public function isMoreAllowed ($aCmt, $isPerformAction = false)
    {
        $oMenuManage = BxDolMenu::getObjectInstance($this->_sMenuObjManage);
	    $oMenuManage->setCmtsData($this, $aCmt['cmt_id']);
    	return $oMenuManage->isVisible();
    }

    public function isModerator()
    {
        return $this->isEditAllowedAll() || $this->isRemoveAllowedAll();
    }

    /**
     * Actions functions
     */
    public function actionGetFormPost ()
    {
        if (!$this->isEnabled())
            return '';

        $iCmtParentId = bx_get('CmtParent');
        $iCmtParentId = $iCmtParentId !== false ? bx_process_input($iCmtParentId, BX_DATA_INT) : 0;
        
        $sCmtBrowse = bx_get('CmtBrowse');
        $sCmtBrowse = $sCmtBrowse !== false ? bx_process_input($sCmtBrowse, BX_DATA_TEXT) : '';

        $sCmtDisplay = bx_get('CmtDisplay');
        $sCmtDisplay = $sCmtDisplay !== false ? bx_process_input($sCmtDisplay, BX_DATA_TEXT) : '';

        $bQuote = bx_get('CmtQuote');
        $bQuote = $bQuote !== false ? bx_process_input($bQuote, BX_DATA_INT) == 1 : false;

        $bMinPostForm = bx_get('CmtMinPostForm');
        $bMinPostForm = $bMinPostForm !== false ? bx_process_input($bMinPostForm, BX_DATA_INT) == 1 : $this->_bMinPostForm;

        return $this->getFormBoxPost(array('parent_id' => $iCmtParentId, 'type' => $sCmtBrowse), array('type' => $sCmtDisplay, 'dynamic_mode' => true, 'quote' => $bQuote, 'min_post_form' => $bMinPostForm));
    }

    public function actionGetFormEdit ()
    {
        if (!$this->isEnabled())
            return echoJson(array());

        $iCmtId = bx_process_input(bx_get('Cmt'), BX_DATA_INT);
        echoJson($this->getFormEdit($iCmtId, array('dynamic_mode' => true)));
    }

    public function actionGetCmt ()
    {
        if (!$this->isEnabled())
            return '';

        if($this->isViewAllowed() !== CHECK_ACTION_RESULT_ALLOWED)
            return '';

        $iCmtId = bx_process_input($_REQUEST['Cmt'], BX_DATA_INT);
        $sCmtBrowse = isset($_REQUEST['CmtBrowse']) ? bx_process_input($_REQUEST['CmtBrowse'], BX_DATA_TEXT) : '';
        $sCmtDisplay = isset($_REQUEST['CmtDisplay']) ? bx_process_input($_REQUEST['CmtDisplay'], BX_DATA_TEXT) : '';

        $aCmt = $this->getCommentRow($iCmtId);
        echoJson(array(
            'parent_id' => $aCmt['cmt_parent_id'],
            'vparent_id' => $aCmt['cmt_parent_id'],
            'content' => $this->getComment($aCmt, array('type' => $sCmtBrowse), array('type' => $sCmtDisplay, 'dynamic_mode' => true))
        ));
    }

    public function actionGetCmts ()
    {
        if (!$this->isEnabled())
            return '';

        if($this->isViewAllowed() !== CHECK_ACTION_RESULT_ALLOWED)
            return '';

        $aBp = $aDp = array();
        $this->_getParams($aBp, $aDp);

        $aDp['dynamic_mode'] = true;
        return $this->getComments($aBp, $aDp);
    }

    public function actionSubmitPostForm()
    {
        if(!$this->isEnabled())
            return echoJson(array());

        $iCmtParentId = 0;
        if(bx_get('cmt_parent_id') !== false)
            $iCmtParentId = bx_process_input(bx_get('cmt_parent_id'), BX_DATA_INT);

        echoJson($this->getFormPost($iCmtParentId, array('dynamic_mode' => true)));
    }

    public function actionSubmitEditForm()
    {
        if (!$this->isEnabled()) {
            echoJson(array());
            return;
        };

        $iCmtId = 0;
        if(bx_get('cmt_id') !== false)
            $iCmtId = bx_process_input(bx_get('cmt_id'), BX_DATA_INT);

        echoJson($this->getFormEdit($iCmtId, array('dynamic_mode' => true)));
    }

    public function actionRemove()
    {
        if (!$this->isEnabled()) {
            echoJson(array());
            return;
        };

        $iCmtId = 0;
        if(bx_get('Cmt') !== false)
            $iCmtId = bx_process_input(bx_get('Cmt'), BX_DATA_INT);
        echoJson($this->remove($iCmtId));
    }
    
    public function remove($iCmtId)
    {
        $aCmt = $this->_oQuery->getCommentsBy(array('type' => 'id', 'id' => $iCmtId));
        if(!$aCmt)
            return array('msg' => _t('_No such comment'));
        
        $iObjId = $this->getId();
        if(!$iObjId){
            $this->setId($aCmt['cmt_object_id']);
            $iObjId = $aCmt['cmt_object_id'];
        }
        $iObjAthrId = $this->getObjectAuthorId($iObjId);
        
        if($aCmt['cmt_replies'] > 0) {
            if(!$this->isModerator())
                return array('msg' => _t('_Can not delete comments with replies'));

            $aReplies = $this->_oQuery->getCommentsBy(array('type' => 'parent_id', 'parent_id' => $iCmtId));
            foreach($aReplies as $aReply)
                $this->remove($aReply['cmt_id']);
        }

        $iPerformerId = $this->_getAuthorId();
        if(!$this->isRemoveAllowed($aCmt))
            return array('msg' => $aCmt['cmt_author_id'] == $iPerformerId ? strip_tags($this->msgErrRemoveAllowed()) : _t('_Access denied'));

        if($this->_oQuery->removeComment($iObjId, $iCmtId, $aCmt['cmt_parent_id'])) {
            $this->_triggerComment();

            $oStorage = BxDolStorage::getObjectInstance($this->getStorageObjectName());

            $aImages = $this->_oQuery->getFiles($this->_aSystem['system_id'], $iCmtId);
            foreach($aImages as $aImage)
                $oStorage->deleteFile($aImage['image_id']);

            $this->_oQuery->deleteImages($this->_aSystem['system_id'], $iCmtId);

            $this->isRemoveAllowed($aCmt, true);

            $this->deleteMetaInfo ($iCmtId);
            
            bx_audit(
               $this->getId(), 
               $this->_aSystem['module'], 
               '_sys_audit_action_delete_comment',  
               $this->_prepareAuditParams($iCmtId, array('comment_author_id' => $aCmt['cmt_author_id'], 'comment_text' => $aCmt['cmt_text']))
           );

            bx_alert($this->_sSystem, 'commentRemoved', $iObjId, $iPerformerId, array(
                'object_author_id' => $iObjAthrId,

                'comment_id' => $iCmtId, 
                'comment_author_id' => $aCmt['cmt_author_id']
            ));

            bx_alert('comment', 'deleted', $iCmtId, $iPerformerId, array(
                'object_system' => $this->_sSystem, 
                'object_id' => $iObjId, 
                'object_author_id' => $iObjAthrId,
                
                'comment_author_id' => $aCmt['cmt_author_id']
            ));

            if(!empty($aCmt['cmt_parent_id'])) {
                $iCmtPrntId = (int)$aCmt['cmt_parent_id'];
                $aCmtPrnt = $this->_oQuery->getCommentSimple($iObjId, $iCmtPrntId);
                if(!empty($aCmtPrnt) && is_array($aCmtPrnt)) {
                    bx_alert($this->_sSystem, 'replyRemoved', $iCmtPrntId, $iPerformerId, array(
                        'object_id' => $iObjId, 
                        'object_author_id' => $iObjAthrId,
                        
                        'parent_author_id' => $aCmtPrnt['cmt_author_id'],
                        
                        'comment_id' => $iCmtId, 
                        'comment_author_id' => $aCmt['cmt_author_id'],
                    ));

                    bx_alert('reply', 'deleted', $iCmtId, $iPerformerId, array(
                        'object_system' => $this->_sSystem, 
                        'object_id' => $iObjId, 
                        'object_author_id' => $iObjAthrId,

                        'parent_id' => $iCmtPrntId,
                        'parent_author_id' => $aCmtPrnt['cmt_author_id'],

                        'comment_author_id' => $aCmt['cmt_author_id'], 
                    ));
                }
            }
            return array('id' => $iCmtId);
        }
        return array('msg' => _t('_cmt_err_cannot_perform_action'));
    }

    public function actionResumeLiveUpdate()
    {
    	$sKey = $this->getNotificationId();

    	bx_import('BxDolSession');
    	BxDolSession::getInstance()->unsetValue($sKey);
    }

	public function actionPauseLiveUpdate()
    {
    	$sKey = $this->getNotificationId();

    	bx_import('BxDolSession');
    	BxDolSession::getInstance()->setValue($sKey, 1);
    }

    public function onPostAfter($iCmtId)
    {
        $iObjId = (int)$this->getId();
        $iObjAthrId = $this->getObjectAuthorId($iObjId);

        $aCmt = $this->_oQuery->getCommentSimple($iObjId, $iCmtId);
        if(empty($aCmt) || !is_array($aCmt))
            return false;

        $iCmtPrntId = (int)$aCmt['cmt_parent_id'];
        $iPerformerId = (int)$aCmt['cmt_author_id'];
        bx_alert($this->_sSystem, 'commentPost', $iObjId, $iPerformerId, array(
            'object_author_id' => $iObjAthrId,

            'comment_id' => $iCmtId, 
            'comment_author_id' => $aCmt['cmt_author_id'], 
            'comment_text' => $aCmt['cmt_text']
        ));
        
        bx_audit(
           $this->getId(), 
           $this->_aSystem['module'], 
           '_sys_audit_action_add_comment',  
           $this->_prepareAuditParams($iCmtId, array('comment_author_id' => $aCmt['cmt_author_id'], 'comment_text' => $aCmt['cmt_text']))
       );

        bx_alert('comment', 'added', $iCmtId, $iPerformerId, array(
            'object_system' => $this->_sSystem, 
            'object_id' => $iObjId, 
            'object_author_id' => $iObjAthrId,

            'comment_author_id' => $aCmt['cmt_author_id'], 
            'comment_text' => $aCmt['cmt_text']
        ));

        if(!empty($iCmtPrntId)) {
            $aCmtPrnt = $this->_oQuery->getCommentSimple($iObjId, $iCmtPrntId);
            if(!empty($aCmtPrnt) && is_array($aCmtPrnt)) {
                bx_alert($this->_sSystem, 'replyPost', $iCmtPrntId, $iPerformerId, array(
                    'object_id' => $iObjId, 
                    'object_author_id' => $iObjAthrId,

                    'parent_author_id' => $aCmtPrnt['cmt_author_id'],

                    'comment_id' => $iCmtId,
                    'comment_author_id' => $aCmt['cmt_author_id'], 
                    'comment_text' => $aCmt['cmt_text']
                ));

                bx_alert('comment', 'replied', $iCmtId, $iPerformerId, array(
                    'object_system' => $this->_sSystem, 
                    'object_id' => $iObjId, 
                    'object_author_id' => $iObjAthrId,

                    'parent_id' => $iCmtPrntId,
                    'parent_author_id' => $aCmtPrnt['cmt_author_id'],

                    'comment_author_id' => $aCmt['cmt_author_id'],  
                    'comment_text' => $aCmt['cmt_text']
                ));
            }
        }

        return array('id' => $iCmtId, 'parent_id' => $iCmtPrntId);
    }

    public function onEditAfter($iCmtId)
    {
        $iObjId = (int)$this->getId();
    	$iObjAthrId = $this->getObjectAuthorId($iObjId);

    	$aCmt = $this->getCommentRow($iCmtId);
        if(empty($aCmt) || !is_array($aCmt))
            return false;

        $iPerformerId = $this->_getAuthorId();
        bx_alert($this->_sSystem, 'commentUpdated', $iObjId, $iPerformerId, array(
            'object_author_id' => $iObjAthrId,

            'comment_id' => $iCmtId, 
            'comment_author_id' => $aCmt['cmt_author_id'], 
            'comment_text' => $aCmt['cmt_text']        	
        ));
        
        bx_audit(
           $this->getId(), 
           $this->_aSystem['module'], 
           '_sys_audit_action_edit_comment',  
           $this->_prepareAuditParams($iCmtId, array('comment_author_id' => $aCmt['cmt_author_id'], 'comment_text' => $aCmt['cmt_text']))
       );

        bx_alert('comment', 'edited', $iCmtId, $iPerformerId, array(
            'object_system' => $this->_sSystem, 
            'object_id' => $iObjId, 
            'object_author_id' => $iObjAthrId,

            'comment_author_id' => $aCmt['cmt_author_id'],
            'comment_text' => $aCmt['cmt_text']
        ));

        return array('id' => $iCmtId, 'content' => $this->_getContent($aCmt));
    }

    public function serviceGetAuthor ($iContentId)
    {
        $aComment = $this->_oQuery->getCommentsBy(array('type' => 'id', 'id' => $iContentId));
        $this->setId($aComment['cmt_object_id']);

        return $aComment['cmt_author_id'];
    }

    public function serviceGetDateAdded ($iContentId)
    {
        $aComment = $this->_oQuery->getCommentsBy(array('type' => 'id', 'id' => $iContentId));
        $this->setId($aComment['cmt_object_id']);

        return $aComment['cmt_time'];
    }

    public function serviceGetDateChanged ($iContentId)
    {
        return 0;
    }
    public function serviceGetLink ($iContentId)
    {
        $aComment = $this->_oQuery->getCommentsBy(array('type' => 'id', 'id' => $iContentId));
        $this->setId($aComment['cmt_object_id']);

        return $this->getViewUrl($iContentId);
    }

    public function serviceGetTitle ($iContentId)
    {
        return '';
    }

    public function serviceGetText ($iContentId)
    {
        $aComment = $this->_oQuery->getCommentsBy(array('type' => 'id', 'id' => $iContentId));
        $this->setId($aComment['cmt_object_id']);

        return $aComment['cmt_text'];
    }

    public function serviceGetThumb ($iContentId)
    {
        return '';
    }

    public function serviceGetInfo ($iContentId, $bSearchableFieldsOnly = true)
    {
        $aComment = $this->_oQuery->getCommentsBy(array('type' => 'id', 'id' => $iContentId));
        $this->setId($aComment['cmt_object_id']);

        return BxDolContentInfo::formatFields($aComment);
    }

    public function serviceGetSearchResultUnit ($iContentId, $sUnitTemplate = '')
    {
        $aComment = $this->_oQuery->getCommentsBy(array('type' => 'id', 'id' => $iContentId));
        if(empty($aComment) || !is_array($aComment))
            return '';

        $this->setId($aComment['cmt_object_id']);

        return $this->getComment($aComment, array(), array('type' => BX_CMT_DISPLAY_FLAT, 'view_only' => true));
    }

    public function serviceGetAll ($aParams = array())
    {
        if(empty($aParams) || !is_array($aParams))
            $aParams = array('type' => 'all');

        return $this->_oQuery->getCommentsBy($aParams);
    }

    public function serviceGetSearchableFieldsExtended($aInputsAdd = array())
    {
        $oForm = BxDolForm::getObjectInstance('sys_comment', 'sys_comment_post', $this->_oTemplate);
        if(!$oForm)
            return array();

        $aSrchNamesExcept = array();
        $aSrchCaptionsSystem = array(
            'cmt_author_id' => '_sys_form_comment_input_caption_system_cmt_author_id',
            'cmt_text' => '_sys_form_comment_input_caption_system_cmt_text'
        );
        $aSrchCaptions = array(
            'cmt_author_id' => '_sys_form_comment_input_caption_cmt_author_id',
            'cmt_text' => '_sys_form_comment_input_caption_cmt_text'
        );

        $aResult = array(
            'cmt_author_id' => array(
                'type' => 'text_auto', 
                'caption_system' => $aSrchCaptionsSystem['cmt_author_id'],
                'caption' => $aSrchCaptions['cmt_author_id'],
                'info' => '',
                'value' => '',
                'values' => '',
                'pass' => ''
            )
        );

        $aInputs = $oForm->aInputs;
        if(!empty($aInputsAdd) && is_array($aInputsAdd))
            $aInputs = array_merge($aInputs, $aInputsAdd);

        foreach($aInputs as $aInput)
            if(in_array($aInput['type'], BxDolSearchExtended::$SEARCHABLE_TYPES) && !in_array($aInput['name'], $aSrchNamesExcept))
                $aResult[$aInput['name']] = array(
                    'type' => $aInput['type'], 
                    'caption_system' => !empty($aInput['caption_system_src']) ? $aInput['caption_system_src'] : '',
                    'caption' => !empty($aInput['caption_src']) ? $aInput['caption_src'] : (!empty($aSrchCaptions[$aInput['name']]) ? $aSrchCaptions[$aInput['name']] : ''),
                    'info' => !empty($aInput['info_src']) ? $aInput['info_src'] : '',
                    'value' => !empty($aInput['value']) ? $aInput['value'] : '',
                    'values' => !empty($aInput['values_src']) ? $aInput['values_src'] : '',
                    'pass' => !empty($aInput['db']['pass']) ? $aInput['db']['pass'] : ''
                );

        return $aResult;
    }

    /**
     * Overwrite this method and register transcoder(s) if comments object uses custom transcoder(s), 
     * which differs from default one 'sys_cmts_images_preview'
     */
    public function registerTranscoders()
    {}

	/**
     * Overwrite this method and unregister transcoder(s) if comments object uses custom transcoder(s), 
     * which differs from default one 'sys_cmts_images_preview'
     */
    public function unregisterTranscoders()
    {}

    public function serviceGetSearchResultExtended($aParams, $iStart = 0, $iPerPage = 0)
    {
        if(empty($aParams) || !is_array($aParams))
            return array();

        return $this->_oQuery->getCommentsBy(array('type' => 'search_ids', 'search_params' => $aParams, 'start' => $iStart, 'per_page' => $iPerPage));
    }

    public function getAuthorInfo($iAuthorId = 0)
    {
        return $this->_getAuthorInfo($iAuthorId);
    }

    /**
     * Internal functions
     */
    protected function _getAuthorId ()
    {
        return isMember() ? bx_get_logged_profile_id() : 0;
    }

    protected function _getAuthorPassword ()
    {
        return isMember() ? $_COOKIE['memberPassword'] : "";
    }

    protected function _getAuthorIp ()
    {
        return getVisitorIP();
    }

    protected function _getAuthorInfo($iAuthorId = 0)
    {
        $iUserId = $this->_getAuthorId();
        $iAuthorId = (int)$iAuthorId;
        $oProfile = $this->_getAuthorObject($iAuthorId);

        return array(
            $oProfile->getDisplayName(),
            $oProfile->getUrl(),
            $oProfile->getThumb(),
            $oProfile->getUnit(0, array('template' => 'unit_wo_info'))
        );
    }

    protected function _getAuthorObject($iAuthorId = 0)
    {
        return BxDolProfile::getInstanceMagic($iAuthorId);
    }

	protected function _getFormObject($sAction = BX_CMT_ACTION_POST)
    {
        $sDisplayName = '_sFormDisplay' . ucfirst($sAction);

        return BxDolForm::getObjectInstance($this->_sFormObject, $this->$sDisplayName, false, $this->_sSystem);
    }

    protected function _getParams(&$aBp, &$aDp)
    {
        //--- Process 'Browse' params. 
        $aBp['parent_id'] = isset($aBp['parent_id']) ? (int)$aBp['parent_id'] : 0;

        $aBp['vparent_id'] = isset($aBp['vparent_id']) ? (int)$aBp['vparent_id'] : 0;
        if(bx_get('CmtParent') !== false)
            $aBp['vparent_id'] = bx_process_input(bx_get('CmtParent'), BX_DATA_INT);

    	$aBp['type'] = isset($aBp['type']) ? $aBp['type'] : '';
    	if(bx_get('CmtBrowse') !== false) 
        	$aBp['type'] = bx_process_input(bx_get('CmtBrowse'), BX_DATA_TEXT);

    	$aBp['filter'] = isset($aBp['filter']) ? $aBp['filter'] : '';
    	if(bx_get('CmtFilter') !== false) 
    	    $aBp['filter'] = bx_process_input(bx_get('CmtFilter'), BX_DATA_TEXT);

        $aBp['start'] = isset($aBp['start']) ? (int)$aBp['start'] : -1;
        if(bx_get('CmtStart') !== false) 
            $aBp['start'] = bx_process_input($_REQUEST['CmtStart'], BX_DATA_INT);

        $aBp['per_view'] = isset($aBp['per_view']) ? (int)$aBp['per_view'] : -1;
        if(bx_get('CmtPerView') !== false) 
            $aBp['per_view'] = bx_process_input($_REQUEST['CmtPerView'], BX_DATA_INT);

        //--- Process 'Display' params.
        $aDp['type'] = isset($aDp['type']) ? $aDp['type'] : '';
        if(bx_get('CmtDisplay') !== false) 
            $aDp['type'] = bx_process_input($_REQUEST['CmtDisplay'], BX_DATA_TEXT);

        $aDp['blink'] = isset($aDp['blink']) ? $aDp['blink'] : '';
        if(bx_get('CmtBlink') !== false) 
            $aDp['blink'] = bx_process_input($_REQUEST['CmtBlink'], BX_DATA_TEXT);

        $aDp['quote'] = isset($aDp['quote']) ? (int)$aDp['quote'] : 0;
        if(bx_get('CmtQuote') !== false) 
            $aDp['quote'] = bx_process_input($_REQUEST['CmtQuote'], BX_DATA_INT);

        $aDp['min_post_form'] = isset($aDp['min_post_form']) ? (bool)$aDp['min_post_form'] : $this->_bMinPostForm;
        if(bx_get('CmtMinPostForm') !== false)
            $aDp['min_post_form'] = bx_process_input(bx_get('CmtMinPostForm'), BX_DATA_INT) == 1;

        $aDp['in_designbox'] = isset($aDp['in_designbox']) ? (bool)$aDp['in_designbox'] : true;
        $aDp['dynamic_mode'] = isset($aDp['dynamic_mode']) ? (bool)$aDp['dynamic_mode'] : false;
        $aDp['show_empty'] = isset($aDp['show_empty']) ? (bool)$aDp['show_empty'] : false;
    }
    
    protected function _prepareAuditParams($iId, $aData)
    {
        $sModule = $this->_aSystem['module'];
        $oModule = BxDolModule::getInstance($sModule);
        $CNF = $oModule->_oConfig->CNF;

        $aContentInfo = BxDolRequest::serviceExists($sModule, 'get_all') ? BxDolService::call($sModule, 'get_all', array(array('type' => 'id', 'id' => $this->getId()))) : array();
        $iContextId = 0;
        if (!empty($aContentInfo)){
            $iContextId = isset($CNF['FIELD_ALLOW_VIEW_TO']) && (!empty($aContentInfo[$CNF['FIELD_ALLOW_VIEW_TO']]) && (int)$aContentInfo[$CNF['FIELD_ALLOW_VIEW_TO']] < 0) ? - $aContentInfo[$CNF['FIELD_ALLOW_VIEW_TO']] : 0; 
        }
        
        $AuditParams = array(
            'content_title' => $this->getObjectTitle() ,
            'context_profile_id' => $iContextId,
            'content_info_object' =>  isset($CNF['OBJECT_CMTS_CONTENT_INFO']) ? $CNF['OBJECT_CMTS_CONTENT_INFO'] : '',
            'data' => array_merge(array('comment_id' => $iId), $aData)
        );
        if ($iContextId > 0)
            $AuditParams['context_profile_title'] = BxDolProfile::getInstance($iContextId)->getDisplayName();
        
        return $AuditParams;
    }

    protected function _prepareTextForOutput ($s, $iCmtId = 0)
    {
    	$iDataAction = !$this->isHtml() ? BX_DATA_TEXT_MULTILINE : BX_DATA_HTML;
    	$s = bx_process_output($s, $iDataAction);
    	$s = bx_linkify_html($s, 'class="' . BX_DOL_LINK_CLASS . '"');

        if($iCmtId && $this->_sMetatagsObj && ($oMetatags = BxDolMetatags::getObjectInstance($this->_sMetatagsObj)) !== false)
            $s = $oMetatags->metaParse($this->_oQuery->getUniqId($this->_aSystem['system_id'], $iCmtId), $s);

        return $s;
    }

    protected function _prepareParams(&$aBp, &$aDp)
    {
        $aBp['type'] = !empty($aBp['type']) ? $aBp['type'] : $this->_sBrowseType;
        $aBp['filter'] = !empty($aBp['filter']) ? $aBp['filter'] : $this->_sBrowseFilter;
        $aBp['parent_id'] = isset($aBp['parent_id']) ? $aBp['parent_id'] : 0;
        $aBp['start'] = isset($aBp['start']) ? $aBp['start'] : -1;
        $aBp['per_view'] = isset($aBp['per_view']) ? $aBp['per_view'] : -1;
        $aBp['order']['by'] = isset($aBp['order_by']) ? $aBp['order_by'] : $this->_aOrder['by'];
        $aBp['order']['way'] = isset($aBp['order_way']) ? $aBp['order_way'] : $this->_aOrder['way'];

        $aDp['type'] = !empty($aDp['type']) ? $aDp['type'] : $this->_sDisplayType;
        $aDp['blink'] = !empty($aDp['blink']) ? $aDp['blink'] : array();
        if(!is_array($aDp['blink']))
            $aDp['blink'] = explode(',', $aDp['blink']);
        $aDp['quote'] = !empty($aDp['quote']) ? (int)$aDp['quote'] : 0;
        if(!isset($aDp['min_post_form']))
            $aDp['min_post_form'] = $this->_bMinPostForm;

        switch($aDp['type']) {
            case BX_CMT_DISPLAY_FLAT:
                $aBp['vparent_id'] = -1;
                $aBp['per_view'] = $aBp['per_view'] != -1 ? $aBp['per_view'] : $this->getPerView(0);
                break;

            case BX_CMT_DISPLAY_THREADED:
                $aBp['per_view'] = $aBp['per_view'] != -1 ? $aBp['per_view'] : $this->getPerView($aBp['vparent_id']);
                break;
        }

        switch ($aBp['type']) {
            case BX_CMT_BROWSE_POPULAR:
                $aBp['order'] = array(
                    'by' => BX_CMT_ORDER_BY_POPULAR,
                    'way' => BX_CMT_ORDER_WAY_DESC
                );
                break;
        }

        $aBp['count'] = $this->getCommentsCount($this->_iId, $aBp['vparent_id'], $aBp['filter']);
        if($aBp['start'] != -1)
            return;

        $aBp['start'] = 0;
        if($aBp['type'] == BX_CMT_BROWSE_TAIL) {
            $aBp['start'] = $aBp['count'] - $aBp['per_view'];
            if($aBp['start'] < 0) {
                $aBp['per_view'] += $aBp['start'];
                $aBp['start'] = 0;
            }
        }

        $this->_setUserChoice($aDp['type'], $aBp['type'], $aBp['filter']);
    }

    protected function _triggerComment()
    {
        if(!$this->_aSystem['trigger_table'])
            return false;

        $iId = $this->getId();
        if(!$iId)
            return false;

        $iCount = $this->getCommentsCount($iId);
        return $this->_oQuery->updateTriggerTable($iId, $iCount);
    }

    /**
     * Replace provided markers in a string
     * @param $mixed string or array to replace markers in
     * @return string where all occured markers are replaced
     */
    protected function _replaceMarkers ($mixed)
    {
        return bx_replace_markers($mixed, $this->_aMarkers);
    }

    protected function _getUserChoice()
    {
        $mixedDp = $mixedBpType = $mixedBpFilter = false;
        if(!isLogged())
            return array($mixedDp, $mixedBpType, $mixedBpFilter);

        $iUserId = $this->_getAuthorId();

        $oSession = BxDolSession::getInstance();

        $mixedDp = $oSession->getValue($this->_sDpSessionKey . $iUserId);
        $mixedBpType = $oSession->getValue($this->_sBpSessionKeyType . $iUserId);
        $mixedBpFilter = $oSession->getValue($this->_sBpSessionKeyFilter . $iUserId);

        return array($mixedDp, $mixedBpType, $mixedBpFilter);
    }

    protected function _setUserChoice($sDp, $sBpType, $sBpFilter)
    {
        if(!isLogged())
            return;

        $iUserId = $this->_getAuthorId();

        $oSession = BxDolSession::getInstance();

        if(!empty($sDp))
            $oSession->setValue($this->_sDpSessionKey . $iUserId, $sDp);

        if(!empty($sBpType))
            $oSession->setValue($this->_sBpSessionKeyType . $iUserId, $sBpType);

        if(!empty($sBpFilter))
            $oSession->setValue($this->_sBpSessionKeyFilter . $iUserId, $sBpFilter);
    }

    protected function _sendNotificationEmail($iCmtId, $iCmtParentId)
    {
        $aCmt = $this->getCommentRow($iCmtId);
        $aCmtParent = $this->getCommentRow($iCmtParentId);
        if(empty($aCmt) || !is_array($aCmt) || empty($aCmtParent) || !is_array($aCmtParent) || (int)$aCmt['cmt_author_id'] == (int)$aCmtParent['cmt_author_id'])
            return;

        $oProfile = $this->_getAuthorObject($aCmtParent['cmt_author_id']);

        if($oProfile instanceof BxDolProfileUndefined)
        	return;

        $iAccount = $oProfile->getAccountId();
        $aAccount = BxDolAccount::getInstance($iAccount)->getInfo();

        $aPlus = array();
        $aPlus['sender_display_name'] = $oProfile->getDisplayName();
        $aPlus['reply_text'] = $this->_prepareTextForOutput($aCmt['cmt_text'], $iCmtId);

        $sPageUrl = $this->getBaseUrl();
        if(empty($sPageUrl))
            $sPageUrl = $this->getViewUrl($iCmtParentId);
        else 
            $sPageUrl .= $this->getItemAnchor($iCmtParentId, true);
        $aPlus['page_url'] = $sPageUrl;

        $sPageTitle = $this->getObjectTitle();
        if(empty($sPageTitle))
            $sPageTitle = _t('_Content');
        $aPlus['page_title'] = $sPageTitle;

        $aTemplate = BxDolEmailTemplates::getInstance()->parseTemplate('t_CommentReplied', $aPlus);
        return $aTemplate && sendMail($aAccount['email'], $aTemplate['Subject'], $aTemplate['Body']);
    }

    protected function _isShowDoComment($aParams, $isAllowedComment, $bCount)
    {
        $bShowDoComment = !isset($aParams['show_do_comment']) || $aParams['show_do_comment'] == true;

        return $bShowDoComment && ($isAllowedComment || $bCount);
    }

    protected function _isShowCounter($aParams, $isAllowedComment, $bCount)
    {
        $bShowCounter = isset($aParams['show_counter']) && $aParams['show_counter'] === true;

        return $bShowCounter && ($isAllowedComment || $bCount);
    }

    /**
     * Note. By default image based controls aren't used.
     * Therefore it can be overwritten in custom template.
     */
    protected function _getImageDo()
    {
    	return '';
    }

    protected function _getIconDo()
    {
    	return 'far comment';
    }

    protected function _getTitleDo()
    {
    	return '_cmt_txt_do';
    }
}

/** @} */
