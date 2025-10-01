SET @sName = 'bx_persons';


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`='bx_persons' LIMIT 1);
DELETE FROM `sys_options` WHERE `name`='bx_persons_friends';
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
('bx_persons_friends', 'on', @iCategId, '_bx_persons_option_friends', 'checkbox', '', '', '', 30);


-- PAGES
DELETE FROM `sys_objects_page` WHERE `object`='bx_persons_edit_badge';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_persons_edit_badge', 'edit-persons-badge', '_bx_persons_page_title_sys_edit_profile_badge', '_bx_persons_page_title_edit_profile_badge', 'bx_persons', 5, 2147483647, 1, 'page.php?i=edit-persons-badge', '', '', '', 0, 1, 0, 'BxPersonsPageEntry', 'modules/boonex/persons/classes/BxPersonsPageEntry.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_persons_edit_badge';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('bx_persons_edit_badge', 1, 'bx_persons', '_bx_persons_page_block_title_edit_profile_badge', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:10:"bx_persons";s:6:"method";s:17:"entity_edit_badge";}', 0, 0, 0);


-- MENUS
DELETE FROM `sys_menu_items` WHERE `set_name`='bx_persons_view_actions_more' AND `name`='edit-persons-badge';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_persons_view_actions_more', 'bx_persons', 'edit-persons-badge', '_bx_persons_menu_item_title_system_edit_badge', '_bx_persons_menu_item_title_edit_badge', 'page.php?i=edit-persons-badge&id={content_id}', '', '', 'fa-certificate', '', 2147483647, 1, 0, 32);





DELETE FROM `sys_menu_items` WHERE `set_name`= 'bx_persons_view_actions_all' AND `name` IN ('profile-friends', 'profile-relations', 'profile-subscriptions', 'reaction');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_persons_view_actions_all', 'bx_persons', 'profile-friends', '_bx_persons_menu_item_title_system_friends', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 10),
('bx_persons_view_actions_all', 'bx_persons', 'profile-relations', '_bx_persons_menu_item_title_system_relations', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 20),
('bx_persons_view_actions_all', 'bx_persons', 'profile-subscriptions', '_bx_persons_menu_item_title_system_subscriptions', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 30),
('bx_persons_view_actions_all', 'bx_persons', 'reaction', '_sys_menu_item_title_system_va_reaction', '', '', '', '', '', '', '', 0, 2147483647, '', 0, 0, 217);

UPDATE `sys_menu_items` SET `order`='12', `active`='0' WHERE `set_name`='bx_persons_view_actions_all' AND `name`='profile-friend-add';
UPDATE `sys_menu_items` SET `order`='14', `active`='0' WHERE `set_name`='bx_persons_view_actions_all' AND `name`='profile-friend-remove';
UPDATE `sys_menu_items` SET `order`='22', `active`='0' WHERE `set_name`='bx_persons_view_actions_all' AND `name`='profile-relation-add';
UPDATE `sys_menu_items` SET `order`='24', `active`='0' WHERE `set_name`='bx_persons_view_actions_all' AND `name`='profile-relation-remove';
UPDATE `sys_menu_items` SET `order`='32', `active`='0' WHERE `set_name`='bx_persons_view_actions_all' AND `name`='profile-subscribe-add';
UPDATE `sys_menu_items` SET `order`='34', `active`='0' WHERE `set_name`='bx_persons_view_actions_all' AND `name`='profile-subscribe-remove';
UPDATE `sys_menu_items` SET `active`='0' WHERE `set_name`='bx_persons_view_actions_all' AND `name`='score';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_persons_view_meta' AND `name` IN ('reactions', 'scores');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_persons_view_meta', 'bx_persons', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 0, 2147483647, '', 0, 0, 43),
('bx_persons_view_meta', 'bx_persons', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 0, 2147483647, '', 0, 0, 46);

UPDATE `sys_objects_menu` SET `title_public`='_bx_persons_menu_title_public_submenu' WHERE `object`='bx_persons_submenu';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_persons_snippet_meta' AND `name` IN ('votes', 'reactions', 'scores', 'obj-friends', 'obj-subscriptions');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `hidden_on_cxt`, `active`, `copyable`, `editable`, `order`) VALUES
('bx_persons_snippet_meta', 'bx_persons', 'votes', '_sys_menu_item_title_system_sm_votes', '_sys_menu_item_title_sm_votes', '', '', '', '', '', 2147483647, '', 0, 0, 1, 16),
('bx_persons_snippet_meta', 'bx_persons', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 2147483647, '', 0, 0, 1, 17),
('bx_persons_snippet_meta', 'bx_persons', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 2147483647, '', 0, 0, 1, 18),
('bx_persons_snippet_meta', 'bx_persons', 'obj-friends', '_sys_menu_item_title_system_sm_friends', '', '', '', '', '', '', 2147483647, 'recom_friends,recom_subscriptions', 1, 0, 1, 60),
('bx_persons_snippet_meta', 'bx_persons', 'obj-subscriptions', '_sys_menu_item_title_system_sm_subscriptions', '', '', '', '', '', '', 2147483647, 'recom_friends,recom_subscriptions', 1, 0, 1, 70);

UPDATE `sys_menu_items` SET `hidden_on_cxt`='all!recom_friends', `order`='62' WHERE `set_name`='bx_persons_snippet_meta' AND `name`='befriend';
UPDATE `sys_menu_items` SET `order`='64', `active`='0' WHERE `set_name`='bx_persons_snippet_meta' AND `name`='unfriend';
UPDATE `sys_menu_items` set `hidden_on_cxt`='all!recom_subscriptions', `order`='72' WHERE `set_name`='bx_persons_snippet_meta' AND `name`='subscribe';
UPDATE `sys_menu_items` SET `order`='74', `active`='0' WHERE `set_name`='bx_persons_snippet_meta' AND `name`='unsubscribe';

UPDATE `sys_menu_items` SET `visibility_custom`='a:2:{s:6:"module";s:10:"bx_persons";s:6:"method";s:17:"is_enable_friends";}' WHERE `set_name`='sys_account_notifications' AND `module`='bx_persons' AND `name`='notifications-friend-requests';

UPDATE `sys_menu_items` SET `visibility_custom`='a:2:{s:6:"module";s:10:"bx_persons";s:6:"method";s:17:"is_enable_friends";}' WHERE `set_name`='sys_profile_stats' AND `module`='bx_persons' AND `name`='profile-stats-friend-requests';


-- ACL
SET @iIdActionChangeBadge = (SELECT `ID` FROM `sys_acl_actions` WHERE `Module`='bx_persons' AND `Name`='change badge' LIMIT 1);
DELETE FROM `sys_acl_actions` WHERE `ID`=@iIdActionChangeBadge;
DELETE FROM `sys_acl_matrix` WHERE `IDAction`=@iIdActionChangeBadge;

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_persons', 'change badge', NULL, '_bx_persons_acl_action_change_badge', '', 1, 3);
SET @iIdActionChangeBadge = LAST_INSERT_ID();

SET @iModerator = 7;
SET @iAdministrator = 8;
SET @iPremium = 9;

INSERT INTO `sys_acl_matrix` (`IDLevel`, `IDAction`) VALUES
(@iModerator, @iIdActionChangeBadge),
(@iAdministrator, @iIdActionChangeBadge),
(@iPremium, @iIdActionChangeBadge);


-- UPLOADERS
DELETE FROM `sys_objects_uploader` WHERE `object`='bx_persons_badge_crop';
INSERT INTO `sys_objects_uploader` (`object`, `active`, `override_class_name`, `override_class_file`) VALUES
('bx_persons_badge_crop', 1, 'BxPersonsUploaderBadgeCrop', 'modules/boonex/persons/classes/BxPersonsUploaderBadgeCrop.php');
