SET @sStorageEngine = (SELECT `value` FROM `sys_options` WHERE `name` = 'sys_storage_default');

-- Iconset

CREATE TABLE IF NOT EXISTS `sys_objects_iconset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object` varchar(64) NOT NULL,
  `title` varchar(255) NOT NULL,
  `override_class_name` varchar(255) NOT NULL,
  `override_class_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `object` (`object`)
);

TRUNCATE TABLE `sys_objects_iconset`;
INSERT INTO `sys_objects_iconset` (`object`, `title`, `override_class_name`, `override_class_file`) VALUES
('sys_fontawesome', 'Font Awesome', 'BxTemplIconsetFontAwesome', ''),
('sys_lucide', 'Lucide', 'BxTemplIconsetLucide', '');

-- SMS providers

DELETE FROM `sys_objects_sms` WHERE `object` = 'sys_smsru';
INSERT INTO `sys_objects_sms` (`object`, `title`, `override_class_name`, `override_class_file`) VALUES
('sys_smsru', 'SMS.RU', 'BxDolSmsSmsRu', '');

-- Settings

UPDATE `sys_options` SET `value` = 'on' WHERE `name` = 'sys_session_auth';

DELETE FROM `sys_options` WHERE `name` = 'sys_css_icons_default';

SET @iCategoryId = (SELECT `id` FROM `sys_options_categories` WHERE `name` = 'hidden');
INSERT IGNORE INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_params`, `check_error`, `order`) VALUES
(@iCategoryId, 'sys_logs_level', '_adm_stg_cpt_option_sys_logs_level', 'DEBUG', 'select', 'ERROR,WARNING,INFO,DEBUG', '', '', '', 132),
(@iCategoryId, 'sys_iconset_default', '_adm_stg_cpt_option_sys_iconset_default', 'sys_fontawesome', 'digit', '', '', '', '', 185),
(@iCategoryId, 'sys_maintenance_mode', '_adm_stg_cpt_option_sys_maintenance_mode', '', 'checkbox', '', '', '', '', 400),
(@iCategoryId, 'sys_maintenance_mode_html', '_adm_stg_cpt_option_sys_maintenance_mode_html', '', 'code', '', '', '', '', 402);


SET @iCategoryIdSiteSettings = (SELECT `id` FROM `sys_options_categories` WHERE `name` = 'site_settings');
INSERT IGNORE INTO `sys_options`(`category_id`, `name`, `caption`, `info`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryIdSiteSettings, 'site_description', '_adm_stg_cpt_option_site_description', '_adm_stg_inf_option_site_description', 'Community powered by UNA Platform', 'digit', '', '', '', 2);

UPDATE `sys_options` SET `order` = 3 WHERE `name` = 'site_email';
UPDATE `sys_options` SET `order` = 4 WHERE `name` = 'site_email_notify';


SET @iCategoryIdCache = (SELECT `id` FROM `sys_options_categories` WHERE `name` = 'cache');
INSERT IGNORE INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryIdCache, 'sys_content_cache_enable', '_adm_stg_cpt_option_sys_content_cache_enable', 'on', 'checkbox', '', '', '', 5),
(@iCategoryIdCache, 'sys_content_cache_engine', '_adm_stg_cpt_option_sys_content_cache_engine', 'File', 'select', 'File,Memcache,APC,XCache', '', '', 6);


SET @iCategoryIdSms = (SELECT `id` FROM `sys_options_categories` WHERE `name` = 'sms');
INSERT IGNORE INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryIdSms, 'sys_sms_smsru_api_id', '_adm_stg_cpt_option_sys_sms_smsru_api_id', '', 'digit', '', '', '', 21),
(@iCategoryIdSms, 'sys_sms_smsru_from_number', '_adm_stg_cpt_option_sys_sms_smsru_from_number', '', 'digit', '', '', '', 22);


SET @iCategoryIdApi = (SELECT `id` FROM `sys_options_categories` WHERE `name` = 'api_layout');
INSERT IGNORE INTO `sys_options`(`category_id`, `name`, `caption`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryIdApi, 'sys_api_context_switcher', '_adm_stg_cpt_option_sys_api_context_switcher', '', 'select', 'a:3:{s:6:"module";s:6:"system";s:6:"method";s:32:"get_options_api_context_switcher";s:5:"class";s:13:"TemplServices";}', '', '', 2),
(@iCategoryIdApi, 'sys_api_context_connection', '_adm_stg_cpt_option_sys_api_context_connection', '', 'select', 'a:3:{s:6:"module";s:6:"system";s:6:"method";s:34:"get_options_api_context_connection";s:5:"class";s:13:"TemplServices";}', '', '', 3);


-- Accounts pics

CREATE TABLE IF NOT EXISTS `sys_accounts_pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `remote_id` varchar(128) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `ext` varchar(32) NOT NULL,
  `size` bigint(20) NOT NULL,
  `dimensions` varchar(12) NOT NULL,
  `added` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `private` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_id` (`remote_id`)
);

CREATE TABLE IF NOT EXISTS `sys_accounts_pictures_resized` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `remote_id` varchar(128) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `ext` varchar(32) NOT NULL,
  `size` bigint(20) NOT NULL,
  `added` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `private` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_id` (`remote_id`)
);


-- Injections

DELETE FROM `sys_injections` WHERE `name` = 'sys_footer' AND `key` = 'injection_footer';
INSERT INTO `sys_injections`(`name`, `page_index`, `key`, `type`, `data`, `replace`, `active`) VALUES
('sys_footer', 0, 'injection_footer', 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:13:"get_injection";s:6:"params";a:1:{i:0;s:6:"footer";}s:5:"class";s:21:"TemplTemplateServices";}', 0, 1);

DELETE FROM `sys_injections_admin` WHERE `name` = 'sys_footer' AND `key` = 'injection_footer';
INSERT INTO `sys_injections_admin`(`name`, `page_index`, `key`, `type`, `data`, `replace`, `active`) VALUES
('sys_footer', 0, 'injection_footer', 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:20:"get_injection_studio";s:6:"params";a:1:{i:0;s:6:"footer";}s:5:"class";s:21:"TemplTemplateServices";}', 0, 1);


-- Storage

INSERT IGNORE INTO `sys_objects_storage` (`object`, `engine`, `params`, `token_life`, `cache_control`, `levels`, `table_files`, `ext_mode`, `ext_allow`, `ext_deny`, `quota_size`, `current_size`, `quota_number`, `current_number`, `max_file_size`, `ts`) VALUES
('sys_agents_assistants_chats_files', @sStorageEngine, '', 360, 2592000, 3, 'sys_agents_assistants_chats_files', 'deny-allow', '', '{dangerous}', 0, 0, 0, 0, 0, 0),
('sys_accounts_pictures', @sStorageEngine, '', 360, 2592000, 3, 'sys_accounts_pictures', 'allow-deny', '{image}', '', 0, 0, 0, 0, 0, 0),
('sys_accounts_pictures_resized', @sStorageEngine, '', 360, 2592000, 3, 'sys_accounts_pictures_resized', 'allow-deny', '{image}', '', 0, 0, 0, 0, 0, 0);


-- Forms

DELETE FROM `sys_form_inputs` WHERE `object` = 'sys_account' AND `name` = 'picture';
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('sys_account', 'system', 'picture', 'a:1:{i:0;s:8:"sys_crop";}', 'a:1:{s:8:"sys_crop";s:24:"_sys_uploader_crop_title";}', 0, 'files', '_sys_form_account_input_caption_system_picture', '_sys_form_account_input_picture', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0);

UPDATE `sys_form_inputs` SET `required` = 1, `checker_func` = 'Avail', `checker_error` = '_sys_form_agents_comment_input_caption_cmt_text_error' WHERE `object` = 'sys_agents_comment' AND `name` = 'cmt_text';


-- Menu

INSERT IGNORE INTO `sys_menu_sets` (`set_name`, `module`, `title`, `deletable`) VALUES
('sys_create_post', 'system', '_sys_menu_set_title_create_post', 0),
('sys_ntfs_submenu', 'system', '_sys_menu_set_title_ntfs_submenu', 0);

DELETE FROM `sys_menu_items` WHERE `set_name` = 'sys_ntfs_submenu' AND `name` = 'context-invitations';
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES
('sys_ntfs_submenu', 'system', 'context-invitations', '_sys_menu_item_title_system_ntfs_context_invitations', '_sys_menu_item_title_ntfs_context_invitations', 'page.php?i=context-invitations', '', '', 'ticket', '', '', 2147483647, '', 1, 1, 1);


-- Grid

ALTER TABLE `sys_grid_actions` CHANGE `icon` `icon` TEXT NOT NULL;


-- Connection

UPDATE `sys_objects_connection` SET `override_class_name` = 'BxTemplConnectionFriend' WHERE `object` = 'sys_profiles_friends';
UPDATE `sys_objects_connection` SET `override_class_name` = 'BxTemplConnectionSubscription' WHERE `object` = 'sys_profiles_subscriptions';
UPDATE `sys_objects_connection` SET `override_class_name` = 'BxTemplConnectionRelation' WHERE `object` = 'sys_profiles_relations';
UPDATE `sys_objects_connection` SET `override_class_name` = 'BxDolConnectionBan' WHERE `object` = 'sys_profiles_bans';


-- Transcoder

INSERT IGNORE INTO `sys_objects_transcoder` (`object`, `storage_object`, `source_type`, `source_params`, `private`, `atime_tracking`, `atime_pruning`, `ts`, `override_class_name`, `override_class_file`) VALUES
('sys_agents_assistants_chats_files_preview', 'sys_cmts_images_preview', 'Storage', 'a:1:{s:6:"object";s:33:"sys_agents_assistants_chats_files";}', 'no', '1', '2592000', '0', '', ''),
('sys_accounts_icon', 'sys_accounts_pictures_resized', 'Storage', 'a:1:{s:6:"object";s:21:"sys_accounts_pictures";}', 'no', '1', '2592000', '0', '', ''),
('sys_accounts_thumb', 'sys_accounts_pictures_resized', 'Storage', 'a:1:{s:6:"object";s:21:"sys_accounts_pictures";}', 'no', '1', '2592000', '0', '', ''),
('sys_accounts_avatar', 'sys_accounts_pictures_resized', 'Storage', 'a:1:{s:6:"object";s:21:"sys_accounts_pictures";}', 'no', '1', '2592000', '0', '', ''),
('sys_accounts_avatar_big', 'sys_accounts_pictures_resized', 'Storage', 'a:1:{s:6:"object";s:21:"sys_accounts_pictures";}', 'no', '1', '2592000', '0', '', ''),
('sys_accounts_picture', 'sys_accounts_pictures_resized', 'Storage', 'a:1:{s:6:"object";s:21:"sys_accounts_pictures";}', 'no', '1', '2592000', '0', '', '');

DELETE FROM `sys_transcoder_filters` WHERE `transcoder_object` IN('sys_agents_assistants_chats_files_preview', 'sys_accounts_icon', 'sys_accounts_thumb', 'sys_accounts_avatar', 'sys_accounts_avatar_big', 'sys_accounts_picture');
INSERT INTO `sys_transcoder_filters` (`transcoder_object`, `filter`, `filter_params`, `order`) VALUES
('sys_agents_assistants_chats_files_preview', 'Resize', 'a:4:{s:1:"w";s:3:"100";s:1:"h";s:3:"100";s:13:"square_resize";s:1:"1";s:10:"force_type";s:3:"jpg";}', '0'),
('sys_accounts_icon', 'Resize', 'a:3:{s:1:"w";s:2:"30";s:1:"h";s:2:"30";s:13:"square_resize";s:1:"1";}', '0'),
('sys_accounts_thumb', 'Resize', 'a:3:{s:1:"w";s:2:"50";s:1:"h";s:2:"50";s:13:"square_resize";s:1:"1";}', '0'),
('sys_accounts_avatar', 'Resize', 'a:3:{s:1:"w";s:3:"100";s:1:"h";s:3:"100";s:13:"square_resize";s:1:"1";}', '0'),
('sys_accounts_avatar_big', 'Resize', 'a:3:{s:1:"w";s:3:"200";s:1:"h";s:3:"200";s:13:"square_resize";s:1:"1";}', '0'),
('sys_accounts_picture', 'Resize', 'a:3:{s:1:"w";s:4:"1024";s:1:"h";s:4:"1024";s:13:"square_resize";s:1:"0";}', '0');


-- Pages

INSERT IGNORE INTO `sys_objects_page` (`object`, `uri`, `title_system`, `title`, `module`, `cover`, `layout_id`, `submenu`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`, `sticky_columns`) VALUES
('sys_ntfs_context_invitations', 'context-invitations', '_sys_page_title_system_ntfs_context_invitations', '_sys_page_title_ntfs_context_invitations', 'system', 1, 5, '', 2147483646, 1, 'page.php?i=context-invitations', '', '', '', 0, 1, 0, 'BxTemplPageNotifications', '', 0);

SET @iBlockOrder = IFNULL((SELECT `order` FROM `sys_pages_blocks` WHERE `object` = '' AND `cell_id` = 0 ORDER BY `order` DESC LIMIT 1), 0);

DELETE FROM `sys_pages_blocks` WHERE `object` = '' AND `title_system` = '_sys_page_block_title_sys_invitations';
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `tabs`, `async`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('', 0, 'system', '_sys_page_block_title_sys_invitations', '_sys_page_block_title_invitations', 11, 1, 0, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:18:"browse_invitations";s:6:"params";a:0:{}s:5:"class";s:20:"TemplServiceProfiles";}', 0, 1, 1, @iBlockOrder + 1);


DELETE FROM `sys_pages_blocks` WHERE `object` = 'sys_ntfs_context_invitations' AND `title` = '_sys_page_block_title_ntfs_context_invitations';
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `tabs`, `async`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('sys_ntfs_context_invitations', 1, 'system', '', '_sys_page_block_title_ntfs_context_invitations', 11, 0, 0, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:18:"browse_invitations";s:6:"params";a:2:{i:0;s:19:"{logged_profile_id}";i:1;a:1:{s:13:"empty_message";b:1;}}s:5:"class";s:20:"TemplServiceProfiles";}', 0, 1, 1, 1);


-- Agents

CREATE TABLE IF NOT EXISTS `sys_agents_assistants_chats_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(10) unsigned NOT NULL,
  `remote_id` varchar(128) NOT NULL,
  `path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(128) NOT NULL,
  `ext` varchar(32) NOT NULL,
  `size` bigint(20) NOT NULL,
  `dimensions` varchar(24) NOT NULL,
  `added` int(11) NOT NULL,
  `modified` int(11) NOT NULL,
  `private` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_id` (`remote_id`)
);


-- Preloader

DELETE FROM `sys_preloader` WHERE `module` = 'system' AND `content` = 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:21:"get_preloader_content";s:6:"params";a:1:{i:0;s:5:"icons";}s:5:"class";s:12:"BaseServices";}';
DELETE FROM `sys_preloader` WHERE `module` = 'system' AND `content` = 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:21:"get_preloader_content";s:6:"params";a:1:{i:0;s:9:"icons_css";}s:5:"class";s:12:"BaseServices";}';
INSERT INTO `sys_preloader`(`module`, `type`, `content`, `active`, `order`) VALUES
('system', 'css_system', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:21:"get_preloader_content";s:6:"params";a:1:{i:0;s:9:"icons_css";}s:5:"class";s:12:"BaseServices";}', 1, 13);


DELETE FROM `sys_preloader` WHERE `module` = 'system' AND `content` = 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:21:"get_preloader_content";s:6:"params";a:1:{i:0;s:8:"icons_js";}s:5:"class";s:12:"BaseServices";}';
INSERT INTO `sys_preloader`(`module`, `type`, `content`, `active`, `order`) VALUES
('system', 'js_system', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:21:"get_preloader_content";s:6:"params";a:1:{i:0;s:8:"icons_js";}s:5:"class";s:12:"BaseServices";}', 1, 20);




-- Last step is to update current version

UPDATE `sys_modules` SET `version` = '15.0.0-A1' WHERE `version` = '14.0.0' AND `name` = 'system';

