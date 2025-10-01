SET @sName = 'bx_channels';


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`='bx_channels' LIMIT 1); 
DELETE FROM `sys_options` WHERE `name`='bx_channels_use_cover_as_thumb';
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `info`, `type`, `extra`, `check`, `check_params`, `check_error`, `order`) VALUES
('bx_channels_use_cover_as_thumb', 'on', @iCategId, '_bx_channels_option_use_cover_as_thumb', '_bx_channels_option_use_cover_as_thumb_inf', 'checkbox', '', '', '', '', 5);


-- MENUS
DELETE FROM `sys_menu_items` WHERE `set_name`='bx_channels_view_actions_all' AND `name` IN ('profile-subscriptions', 'reaction');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_channels_view_actions_all', 'bx_channels', 'profile-subscriptions', '_bx_channels_menu_item_title_system_subscriptions', '', '', '', '', '', '', '', 0, 2147483647, 1, 0, 10),
('bx_channels_view_actions_all', 'bx_channels', 'reaction', '_sys_menu_item_title_system_va_reaction', '', '', '', '', '', '', '', 0, 2147483647, 0, 0, 225);

UPDATE `sys_menu_items` SET `order`='12', `active`='0' WHERE `set_name`='bx_channels_view_actions_all' AND `name`='profile-subscribe-add';
UPDATE `sys_menu_items` SET `order`='14', `active`='0' WHERE `set_name`='bx_channels_view_actions_all' AND `name`='profile-subscribe-remove';
UPDATE `sys_menu_items` SET `active`='0' WHERE `set_name`='bx_channels_view_actions_all' AND `name`='score';

DELETE FROM `sys_objects_menu` WHERE `object`='bx_channels_view_meta';
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_channels_view_meta', '_bx_channels_menu_title_view_profile_meta', 'bx_channels_view_meta', 'bx_channels', 15, 0, 1, 'BxCnlMenuViewMeta', 'modules/boonex/channels/classes/BxCnlMenuViewMeta.php');

DELETE FROM `sys_menu_sets` WHERE `set_name`='bx_channels_view_meta';
INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_channels_view_meta', 'bx_channels', '_bx_channels_menu_set_title_view_profile_meta', 0);

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_channels_view_meta';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_channels_view_meta', 'bx_channels', 'subscribers', '_sys_menu_item_title_system_sm_subscribers', '_sys_menu_item_title_sm_subscribers', '', '', '', '', '', 0, 2147483647, '', 1, 0, 20),
('bx_channels_view_meta', 'bx_channels', 'views', '_sys_menu_item_title_system_sm_views', '_sys_menu_item_title_sm_views', '', '', '', '', '', 0, 2147483647, '', 1, 0, 30),
('bx_channels_view_meta', 'bx_channels', 'votes', '_sys_menu_item_title_system_sm_votes', '_sys_menu_item_title_sm_votes', '', '', '', '', '', 0, 2147483647, '', 1, 0, 40),
('bx_channels_view_meta', 'bx_channels', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 0, 2147483647, '', 0, 0, 43),
('bx_channels_view_meta', 'bx_channels', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 0, 2147483647, '', 0, 0, 46),
('bx_channels_view_meta', 'bx_channels', 'comments', '_sys_menu_item_title_system_sm_comments', '_sys_menu_item_title_sm_comments', '', '', '', '', '', 0, 2147483647, '', 1, 0, 50);

UPDATE `sys_objects_menu` SET `title_public`='_bx_channels_menu_title_public_submenu' WHERE `object`='bx_channels_submenu';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_channels_snippet_meta' AND `name` IN ('votes', 'reactions', 'scores');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `editable`, `order`) VALUES
('bx_channels_snippet_meta', 'bx_channels', 'votes', '_sys_menu_item_title_system_sm_votes', '_sys_menu_item_title_sm_votes', '', '', '', '', '', 2147483647, 0, 0, 1, 16),
('bx_channels_snippet_meta', 'bx_channels', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 2147483647, 0, 0, 1, 17),
('bx_channels_snippet_meta', 'bx_channels', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 2147483647, 0, 0, 1, 18);
