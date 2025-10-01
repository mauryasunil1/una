SET @sName = 'bx_organizations';


-- TABLES
UPDATE `bx_organizations_prices` SET `added` = (SELECT `td`.`added` FROM `bx_organizations_data` AS `td` INNER JOIN `sys_profiles` AS `tp` ON `td`.`id`=`tp`.`content_id` AND `tp`.`type`='bx_organizations' WHERE `tp`.`id`=`profile_id` LIMIT 1);


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`='bx_organizations' LIMIT 1);
DELETE FROM `sys_options` WHERE `name`='bx_organizations_friends';
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
('bx_organizations_friends', 'on', @iCategId, '_bx_orgs_option_friends', 'checkbox', '', '', '', 30);


-- PAGES
DELETE FROM `sys_objects_page` WHERE `object`='bx_organizations_edit_badge';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_organizations_edit_badge', 'edit-organization-badge', '_bx_orgs_page_title_sys_edit_profile_badge', '_bx_orgs_page_title_edit_profile_badge', 'bx_organizations', 5, 2147483647, 1, 'page.php?i=edit-persons-badge', '', '', '', 0, 1, 0, 'BxOrgsPageEntry', 'modules/boonex/organizations/classes/BxOrgsPageEntry.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_organizations_edit_badge';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('bx_organizations_edit_badge', 1, 'bx_organizations', '_bx_orgs_page_block_title_edit_profile_badge', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:16:"bx_organizations";s:6:"method";s:17:"entity_edit_badge";}', 0, 0, 0);


-- MENUS
UPDATE `sys_menu_items` set `title`='{title_pay_and_join}' WHERE `set_name`='bx_organizations_view_actions' AND `name`='join-organization-profile';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_organizations_view_actions_more' AND `name`='edit-organization-badge';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES
('bx_organizations_view_actions_more', 'bx_organizations', 'edit-organization-badge', '_bx_orgs_menu_item_title_system_edit_badge', '_bx_orgs_menu_item_title_edit_badge', 'page.php?i=edit-organization-badge&id={content_id}', '', '', 'fa-certificate', '', 2147483647, '', 1, 0, 42);

DELETE FROM `sys_menu_items` WHERE `set_name`= 'bx_organizations_view_actions_all' AND `name` IN ('profile-fans', 'profile-friends', 'profile-relations', 'profile-subscriptions', 'reaction');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_organizations_view_actions_all', 'bx_organizations', 'profile-fans', '_bx_orgs_menu_item_title_system_fans', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 10),
('bx_organizations_view_actions_all', 'bx_organizations', 'profile-friends', '_bx_orgs_menu_item_title_system_friends', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 30),
('bx_organizations_view_actions_all', 'bx_organizations', 'profile-relations', '_bx_orgs_menu_item_title_system_relations', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 40),
('bx_organizations_view_actions_all', 'bx_organizations', 'profile-subscriptions', '_bx_orgs_menu_item_title_system_subscriptions', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 50),
('bx_organizations_view_actions_all', 'bx_organizations', 'reaction', '_sys_menu_item_title_system_va_reaction', '', '', '', '', '', '', '', 0, 2147483647, '', 0, 0, 217);

UPDATE `sys_menu_items` SET `visibility_custom`='a:3:{s:6:"module";s:16:"bx_organizations";s:6:"method";s:22:"is_free_join_avaliable";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-fans';
UPDATE `sys_menu_items` SET `order`='12', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-fan-add';
UPDATE `sys_menu_items` SET `order`='14', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-fan-remove';
UPDATE `sys_menu_items` SET `order`='32', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-friend-add';
UPDATE `sys_menu_items` SET `order`='34', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-friend-remove';
UPDATE `sys_menu_items` SET `order`='42', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-relation-add';
UPDATE `sys_menu_items` SET `order`='44', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-relation-remove';
UPDATE `sys_menu_items` SET `order`='52', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-subscribe-add';
UPDATE `sys_menu_items` SET `order`='54', `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='profile-subscribe-remove';
UPDATE `sys_menu_items` SET `active`='0' WHERE `set_name`='bx_organizations_view_actions_all' AND `name`='score';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_organizations_view_meta' AND `name` IN ('reactions', 'scores');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_organizations_view_meta', 'bx_organizations', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 0, 2147483647, '', 0, 0, 63),
('bx_organizations_view_meta', 'bx_organizations', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 0, 2147483647, '', 0, 0, 66);

UPDATE `sys_objects_menu` SET `title_public`='_bx_orgs_menu_title_public_submenu' WHERE `object`='bx_organizations_submenu';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_organizations_snippet_meta' AND `name` IN ('votes', 'reactions', 'scores', 'obj-friends', 'obj-subscriptions');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `hidden_on_cxt`, `active`, `copyable`, `editable`, `order`) VALUES
('bx_organizations_snippet_meta', 'bx_organizations', 'votes', '_sys_menu_item_title_system_sm_votes', '_sys_menu_item_title_sm_votes', '', '', '', '', '', 2147483647, '', '', 0, 0, 1, 16),
('bx_organizations_snippet_meta', 'bx_organizations', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 2147483647, '', '', 0, 0, 1, 17),
('bx_organizations_snippet_meta', 'bx_organizations', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 2147483647, '', '', 0, 0, 1, 18),
('bx_organizations_snippet_meta', 'bx_organizations', 'obj-friends', '_sys_menu_item_title_system_sm_friends', '', '', '', '', '', '', 2147483647, '', 'recom_friends,recom_subscriptions', 1, 0, 1, 65),
('bx_organizations_snippet_meta', 'bx_organizations', 'obj-subscriptions', '_sys_menu_item_title_system_sm_subscriptions', '', '', '', '', '', '', 2147483647, '', 'recom_friends,recom_subscriptions', 1, 0, 1, 75);

UPDATE `sys_menu_items` SET `hidden_on_cxt`='all!recom_friends', `order`='70' WHERE `set_name`='bx_organizations_snippet_meta' AND `name`='befriend';
UPDATE `sys_menu_items` SET `order`='72', `active`='0' WHERE `set_name`='bx_organizations_snippet_meta' AND `name`='unfriend';
UPDATE `sys_menu_items` set `hidden_on_cxt`='all!recom_subscriptions', `order`='80' WHERE `set_name`='bx_organizations_snippet_meta' AND `name`='subscribe';
UPDATE `sys_menu_items` SET `order`='82', `active`='0' WHERE `set_name`='bx_organizations_snippet_meta' AND `name`='unsubscribe';

UPDATE `sys_menu_items` SET `visibility_custom`='a:2:{s:6:"module";s:16:"bx_organizations";s:6:"method";s:17:"is_enable_friends";}' WHERE `set_name`='sys_account_notifications' AND `module`='bx_organizations' AND `name`='notifications-friend-requests';

UPDATE `sys_menu_items` SET `visibility_custom`='a:2:{s:6:"module";s:16:"bx_organizations";s:6:"method";s:17:"is_enable_friends";}' WHERE `set_name`='sys_profile_stats' AND `module`='bx_organizations' AND `name`='profile-stats-friend-requests';


-- ACL
SET @iIdActionChangeBadge = (SELECT `ID` FROM `sys_acl_actions` WHERE `Module`='bx_organizations' AND `Name`='change badge' LIMIT 1);
DELETE FROM `sys_acl_actions` WHERE `ID`=@iIdActionChangeBadge;
DELETE FROM `sys_acl_matrix` WHERE `IDAction`=@iIdActionChangeBadge;

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_organizations', 'change badge', NULL, '_bx_orgs_acl_action_change_badge', '', 1, 3);
SET @iIdActionChangeBadge = LAST_INSERT_ID();

SET @iModerator = 7;
SET @iAdministrator = 8;
SET @iPremium = 9;

INSERT INTO `sys_acl_matrix` (`IDLevel`, `IDAction`) VALUES
(@iModerator, @iIdActionChangeBadge),
(@iAdministrator, @iIdActionChangeBadge),
(@iPremium, @iIdActionChangeBadge);


-- CONNECTIONS
UPDATE `sys_objects_connection` SET `tt_content`='bx_organizations_data', `tf_id_content`='id', `tf_count_content`='members' WHERE `object`='bx_organizations_fans';

UPDATE `bx_organizations_data` SET `members`=(SELECT COUNT(`tf`.`initiator`) FROM `bx_organizations_fans` AS `tf` INNER JOIN `sys_profiles` AS `tp` ON `tf`.`content`=`tp`.`id` AND `tp`.`type`='bx_organizations' AND  `tf`.`mutual`='1' WHERE `tp`.`content_id`=`bx_organizations_data`.`id` GROUP BY `tf`.`content` LIMIT 1);


-- GRIDS
UPDATE `sys_objects_grid` SET `source`='SELECT *, `default` AS `default_price` FROM `bx_organizations_prices` WHERE 1 ', `field_active`='active' WHERE `object`='bx_organizations_prices_manage';
UPDATE `sys_objects_grid` SET `source`='SELECT * FROM `bx_organizations_prices` WHERE `active`<>''0'' ' WHERE `object`='bx_organizations_prices_view';

DELETE FROM `sys_grid_fields` WHERE `object`='bx_organizations_prices_manage';
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_organizations_prices_manage', 'checkbox', '_sys_select', '2%', 0, 0, '', 1),
('bx_organizations_prices_manage', 'order', '', '2%', 0, 0, '', 2),
('bx_organizations_prices_manage', 'switcher', '', '6%', 0, 0, '', 3),
('bx_organizations_prices_manage', 'name', '_bx_orgs_grid_column_title_name', '15%', 0, 16, '', 4),
('bx_organizations_prices_manage', 'caption', '_bx_orgs_grid_column_title_caption', '20%', 0, 32, '', 5),
('bx_organizations_prices_manage', 'price', '_bx_orgs_grid_column_title_price', '15%', 0, 16, '', 6),
('bx_organizations_prices_manage', 'period', '_bx_orgs_grid_column_title_period', '15%', 0, 16, '', 7),
('bx_organizations_prices_manage', 'default_price', '_bx_orgs_grid_column_title_default_price', '5%', 0, 0, '', 8),
('bx_organizations_prices_manage', 'actions', '', '20%', 0, 0, '', 9);


-- UPLOADERS
DELETE FROM `sys_objects_uploader` WHERE `object`='bx_organizations_badge_crop';
INSERT INTO `sys_objects_uploader` (`object`, `active`, `override_class_name`, `override_class_file`) VALUES
('bx_organizations_badge_crop', 1, 'BxOrgsUploaderBadgeCrop', 'modules/boonex/organizations/classes/BxOrgsUploaderBadgeCrop.php');
