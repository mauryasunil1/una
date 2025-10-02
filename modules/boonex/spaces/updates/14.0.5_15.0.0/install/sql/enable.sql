-- TABLES
UPDATE `bx_spaces_prices` SET `added` = (SELECT `td`.`added` FROM `bx_spaces_data` AS `td` INNER JOIN `sys_profiles` AS `tp` ON `td`.`id`=`tp`.`content_id` AND `tp`.`type`='bx_spaces' WHERE `tp`.`id`=`profile_id` LIMIT 1);


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`='bx_spaces' LIMIT 1);
DELETE FROM `sys_options` WHERE `name` IN ('bx_spaces_auto_activation_for_categories', 'bx_spaces_use_cover_as_thumb');
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `info`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
('bx_spaces_auto_activation_for_categories', 'on', @iCategId, '_bx_spaces_option_auto_activation_for_categories', '', 'checkbox', '', '', '', 3),
('bx_spaces_use_cover_as_thumb', 'on', @iCategId, '_bx_spaces_option_use_cover_as_thumb', '_bx_spaces_option_use_cover_as_thumb_inf', 'checkbox', '', '', '', 5);


-- PAGES
DELETE FROM `sys_pages_blocks` WHERE `object`='bx_spaces_view_profile' AND `title`='_bx_spaces_page_block_title_entry_rating';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('bx_spaces_view_profile', 0, 'bx_spaces', '', '_bx_spaces_page_block_title_entry_rating', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:13:"entity_rating";}', 0, 0, 0, 0);

DELETE FROM `sys_objects_page` WHERE `object`='bx_spaces_manage_item';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_spaces_manage_item', 'space-manage', '_bx_spaces_page_title_sys_manage_profile', '_bx_spaces_page_title_manage_profile', 'bx_spaces', 5, 2147483647, 1, 'page.php?i=space-manage', '', '', '', 0, 1, 0, 'BxSpacesPageEntry', 'modules/boonex/spaces/classes/BxSpacesPageEntry.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_spaces_manage_item';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_spaces_manage_item', 1, 'bx_spaces', '_bx_spaces_page_block_title_system_fans_manage', '_bx_spaces_page_block_title_fans_link', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:10:"fans_table";}', 0, 0, 1, 1),
('bx_spaces_manage_item', 1, 'bx_spaces', '_bx_spaces_page_block_title_system_invites_manage', '_bx_spaces_page_block_title_invites', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:13:"invites_table";}', 0, 0, 1, 2);

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_spaces_fans';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_spaces_fans', 1, 'bx_spaces', '_bx_spaces_page_block_title_system_fans', '_bx_spaces_page_block_title_fans_link', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:14:"browse_members";s:6:"params";a:2:{i:0;s:12:"{profile_id}";i:1;a:2:{s:13:"empty_message";b:1;s:13:"ajax_paginate";b:0;}}}', 0, 0, 1, 1);

DELETE FROM `sys_objects_page` WHERE `object`='bx_spaces_category';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_spaces_category', 'spaces-category', '_bx_spaces_page_title_sys_entries_by_category', '_bx_spaces_page_title_entries_by_category', 'bx_spaces', 1, 2147483647, 1, 'page.php?i=spaces-category', '', '', '', 0, 1, 0, 'BxSpacesPageBrowse', 'modules/boonex/spaces/classes/BxSpacesPageBrowse.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_spaces_category';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_spaces_category', 1, 'bx_spaces', '', '_bx_spaces_page_block_title_categories', 11, 2147483647, 'service', 'a:4:{s:6:"module";s:6:"system";s:6:"method";s:15:"categories_list";s:6:"params";a:2:{i:0;s:14:"bx_spaces_cats";i:1;a:2:{s:10:\"show_empty\";b:1;s:21:\"show_empty_categories\";b:1;}}s:5:"class";s:20:"TemplServiceCategory";}', 0, 0, 1, 1),
('bx_spaces_category', 2, 'bx_spaces', '_bx_spaces_page_block_title_sys_entries_by_category', '_bx_spaces_page_block_title_entries_by_category', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:15:"browse_category";s:6:"params";a:3:{s:9:"unit_view";s:7:"gallery";s:13:"empty_message";b:1;s:13:"ajax_paginate";b:0;}}', 0, 0, 1, 1);

DELETE FROM `sys_objects_page` WHERE `object`='bx_spaces_mcategory';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_spaces_mcategory', 'spaces-mcategory', '_bx_spaces_page_title_sys_entries_by_multi_category', '_bx_spaces_page_title_entries_by_category', 'bx_spaces', 1, 2147483647, 1, 'page.php?i=spaces-mcategory', '', '', '', 0, 1, 0, 'BxSpacesPageBrowse', 'modules/boonex/spaces/classes/BxSpacesPageBrowse.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_spaces_mcategory';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_spaces_mcategory', 1, 'bx_spaces', '', '_bx_spaces_page_block_title_categories', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:21:"categories_multi_list";}', 0, 0, 1, 1),
('bx_spaces_mcategory', 2, 'bx_spaces', '_bx_spaces_page_block_title_sys_entries_by_category', '_bx_spaces_page_block_title_entries_by_category', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:21:"browse_multi_category";s:6:"params";a:3:{s:9:"unit_view";s:7:"gallery";s:13:"empty_message";b:1;s:13:"ajax_paginate";b:0;}}', 0, 0, 1, 1);

DELETE FROM `sys_pages_blocks` WHERE `module`='bx_spaces' AND `title_system`='_bx_spaces_page_block_title_sys_recom_fans';
SET @iBlockOrder = (SELECT `order` FROM `sys_pages_blocks` WHERE `object` = '' AND `cell_id` = 0 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('', 0, 'bx_spaces', '_bx_spaces_page_block_title_sys_multicats', '_bx_spaces_page_block_title_multicats', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:21:"categories_multi_list";}', 0, 1, 1, IFNULL(@iBlockOrder, 0) + 1),
('', 0, 'bx_spaces', '_bx_spaces_page_block_title_sys_recom_fans', '_bx_spaces_page_block_title_recom_fans', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:9:\"bx_spaces\";s:6:\"method\";s:27:\"browse_recommendations_fans\";}', 0, 1, 1, IFNULL(@iBlockOrder, 0) + 2);


-- MENUS
UPDATE `sys_menu_items` set `title`='{title_pay_and_join}' WHERE `set_name`='bx_spaces_view_actions' AND `name`='join-space-profile';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_spaces_view_actions_more' AND `name` IN ('add-space-content', 'space-manage');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_spaces_view_actions_more', 'bx_spaces', 'add-space-content', '_bx_spaces_menu_item_title_system_add_content', '_bx_spaces_menu_item_title_add_content', 'javascript:void(0)', 'bx_menu_popup(''bx_spaces_add_content'', this, {}, {profile_id:{profile_id}});', '', 'plus', 'bx_spaces_add_content', 2147483647, '', 1, 0, 5),
('bx_spaces_view_actions_more', 'bx_spaces', 'space-manage', '_bx_spaces_menu_item_title_system_manage', '_bx_spaces_menu_item_title_manage', 'page.php?i=space-manage&profile_id={profile_id}', '', '', 'users', '', 2147483647, '', 1, 0, 10);

DELETE FROM `sys_menu_items` WHERE `set_name`= 'bx_spaces_view_actions_all' AND `name` IN ('profile-fans', 'profile-subscriptions', 'rate', 'reaction');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_spaces_view_actions_all', 'bx_spaces', 'profile-fans', '_bx_spaces_menu_item_title_system_fans', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 10),
('bx_spaces_view_actions_all', 'bx_spaces', 'profile-subscriptions', '_bx_spaces_menu_item_title_system_subscriptions', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 30),
('bx_spaces_view_actions_all', 'bx_spaces', 'rate', '_sys_menu_item_title_system_va_rate', '', '', '', '', '', '', '', 0, 2147483647, '', 0, 0, 225),
('bx_spaces_view_actions_all', 'bx_spaces', 'reaction', '_sys_menu_item_title_system_va_reaction', '', '', '', '', '', '', '', 0, 2147483647, '', 0, 0, 227);

UPDATE `sys_menu_items` SET `visibility_custom`='a:3:{s:6:"module";s:9:"bx_spaces";s:6:"method";s:22:"is_free_join_avaliable";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}' WHERE `set_name`='bx_spaces_view_actions_all' AND `name`='profile-fans';
UPDATE `sys_menu_items` SET `order`='12', `active`='0' WHERE `set_name`='bx_spaces_view_actions_all' AND `name`='profile-fan-add';
UPDATE `sys_menu_items` SET `order`='14', `active`='0' WHERE `set_name`='bx_spaces_view_actions_all' AND `name`='profile-fan-remove';
UPDATE `sys_menu_items` SET `order`='32', `active`='0' WHERE `set_name`='bx_spaces_view_actions_all' AND `name`='profile-subscribe-add';
UPDATE `sys_menu_items` SET `order`='34', `active`='0' WHERE `set_name`='bx_spaces_view_actions_all' AND `name`='profile-subscribe-remove';
UPDATE `sys_menu_items` SET `active`='0' WHERE `set_name`='bx_jobs_view_actions_all' AND `name`='score';

DELETE FROM `sys_objects_menu` WHERE `object`='bx_spaces_add_content';
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_spaces_add_content', '_bx_spaces_menu_title_add_content', 'sys_add_content_links', 'bx_spaces', 6, 0, 1, 'BxSpacesMenuAddContent', 'modules/boonex/spaces/classes/BxSpacesMenuAddContent.php');

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_spaces_view_meta' AND `name` IN ('reactions', 'scores');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_spaces_view_meta', 'bx_spaces', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 0, 2147483647, '', 0, 0, 43),
('bx_spaces_view_meta', 'bx_spaces', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 0, 2147483647, '', 0, 0, 46);

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_spaces_snippet_meta' AND `name` IN ('votes', 'rating', 'reactions', 'scores', 'ignore-join');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `hidden_on_cxt`, `active`, `copyable`, `editable`, `order`) VALUES
('bx_spaces_snippet_meta', 'bx_spaces', 'votes', '_sys_menu_item_title_system_sm_votes', '_sys_menu_item_title_sm_votes', '', '', '', '', '', 2147483647, '', '', 0, 0, 1, 16),
('bx_spaces_snippet_meta', 'bx_spaces', 'rating', '_sys_menu_item_title_system_sm_rating', '_sys_menu_item_title_sm_rating', '', '', '', '', '', 2147483647, '', '', 0, 0, 1, 17),
('bx_spaces_snippet_meta', 'bx_spaces', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 2147483647, '', '', 0, 0, 1, 18),
('bx_spaces_snippet_meta', 'bx_spaces', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 2147483647, '', '', 0, 0, 1, 19),
('bx_spaces_snippet_meta', 'bx_spaces', 'ignore-join', '_sys_menu_item_title_system_sm_ignore', '_sys_menu_item_title_sm_ignore', '', '', '', '', '', 2147483647, '', 'all!recom_spaces_fans', 1, 0, 1, 70);

UPDATE `sys_menu_items` SET `hidden_on_cxt`='recom_spaces_fans' WHERE `set_name`='bx_spaces_snippet_meta' AND `name` IN ('leave', 'subscribe', 'unsubscribe');


-- CONNECTIONS
UPDATE `sys_objects_connection` SET `tt_content`='bx_spaces_data', `tf_id_content`='id', `tf_count_content`='members' WHERE `object`='bx_spaces_fans';

UPDATE `bx_spaces_data` SET `members`=(SELECT COUNT(`tf`.`initiator`) FROM `bx_spaces_fans` AS `tf` INNER JOIN `sys_profiles` AS `tp` ON `tf`.`content`=`tp`.`id` AND `tp`.`type`='bx_spaces' AND  `tf`.`mutual`='1' WHERE `tp`.`content_id`=`bx_spaces_data`.`id` GROUP BY `tf`.`content` LIMIT 1);


-- RECOMMENDATIONS
SET @iRecFans = (SELECT `id` FROM `sys_objects_recommendation` WHERE `name`='bx_spaces_fans' LIMIT 1);
DELETE FROM `sys_objects_recommendation` WHERE `id`=@iRecFans;
DELETE FROM `sys_recommendation_criteria` WHERE `object_id`=@iRecFans;

INSERT INTO `sys_objects_recommendation` (`name`, `module`, `connection`, `content_info`, `countable`, `active`, `class_name`, `class_file`) VALUES
('bx_spaces_fans', 'bx_spaces', 'bx_spaces_fans', '', 1, 1, 'BxSpacesRecommendationFans', 'modules/boonex/spaces/classes/BxSpacesRecommendationFans.php');
SET @iRecFans = LAST_INSERT_ID();

INSERT INTO `sys_recommendation_criteria` (`object_id`, `name`, `source_type`, `source`, `params`, `weight`, `active`) VALUES
(@iRecFans, 'by_friends', 'sql', 'SELECT `tgf`.`content` AS `id`, SUM({points}) AS `value` FROM `sys_profiles_conn_friends` AS `tf` INNER JOIN `bx_spaces_fans` AS `tgf` ON `tf`.`content`=`tgf`.`initiator` AND `tgf`.`content` NOT IN (SELECT `content` FROM `bx_spaces_fans` WHERE `initiator`={profile_id}) AND `tgf`.`mutual`=''1'' WHERE `tf`.`initiator`={profile_id} AND `tf`.`mutual`=''1'' GROUP BY `id`', 'a:1:{s:6:"points";i:2;}', 0.5, 1),
(@iRecFans, 'by_subscriptions', 'sql', 'SELECT `tgf`.`content` AS `id`, SUM({points}) AS `value` FROM `sys_profiles_conn_subscriptions` AS `ts` INNER JOIN `sys_profiles` AS `tp` ON `ts`.`content`=`tp`.`id` AND `tp`.`type` IN ({profile_types}) AND `tp`.`status`=''active'' INNER JOIN `bx_spaces_fans` AS `tgf` ON `ts`.`content`=`tgf`.`initiator` AND `tgf`.`content` NOT IN (SELECT `content` FROM `bx_spaces_fans` WHERE `initiator`={profile_id}) AND `tgf`.`mutual`=''1'' WHERE `ts`.`initiator`={profile_id} GROUP BY `id`', 'a:2:{s:6:"points";i:2;s:13:"profile_types";s:0:"";}', 0.2, 1),
(@iRecFans, 'by_fans', 'sql', 'SELECT `tg2`.`content` AS `id`, SUM({points}) AS `value` FROM `bx_spaces_fans` AS `tg1` INNER JOIN `bx_spaces_fans` AS `tm` ON `tg1`.`content`=`tm`.`content` AND `tm`.`initiator`<>{profile_id} AND `tm`.`mutual`=''1'' INNER JOIN `bx_spaces_fans` AS `tg2` ON `tm`.`initiator`=`tg2`.`initiator` AND `tg2`.`mutual`=''1'' AND `tg2`.`content` NOT IN (SELECT `content` FROM `bx_spaces_fans` WHERE `initiator`={profile_id})  WHERE `tg1`.`initiator`={profile_id} AND `tg1`.`mutual`=''1'' GROUP BY `id`', 'a:1:{s:6:"points";i:1;}', 0.2, 1),
(@iRecFans, 'featured', 'sql', 'SELECT `tp`.`id` AS `id`, {points} AS `value` FROM `bx_spaces_data` AS `tg` INNER JOIN `sys_profiles` AS `tp` ON `tg`.`id`=`tp`.`content_id` AND `tp`.`type`=''bx_spaces'' WHERE `tg`.`featured`<>''0'' AND `tg`.`status`=''active'' AND `tg`.`status_admin`=''active'' AND `tp`.`id` NOT IN (SELECT `content` FROM `bx_spaces_fans` WHERE `initiator`={profile_id})', 'a:1:{s:6:"points";i:0;}', 0.1, 1);


-- GRIDS
UPDATE `sys_objects_grid` SET `source`='SELECT *, `default` AS `default_price` FROM `bx_spaces_prices` WHERE 1 ', `field_active`='active' WHERE `object`='bx_spaces_prices_manage';
UPDATE `sys_objects_grid` SET `source`='SELECT * FROM `bx_spaces_prices` WHERE `active`<>''0'' ' WHERE `object`='bx_spaces_prices_view';

DELETE FROM `sys_grid_fields` WHERE `object`='bx_spaces_prices_manage';
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_spaces_prices_manage', 'checkbox', '_sys_select', '2%', 0, 0, '', 1),
('bx_spaces_prices_manage', 'order', '', '2%', 0, 0, '', 2),
('bx_spaces_prices_manage', 'switcher', '', '6%', 0, 0, '', 3),
('bx_spaces_prices_manage', 'name', '_bx_spaces_grid_column_title_name', '15%', 0, 16, '', 4),
('bx_spaces_prices_manage', 'caption', '_bx_spaces_grid_column_title_caption', '20%', 0, 32, '', 5),
('bx_spaces_prices_manage', 'price', '_bx_spaces_grid_column_title_price', '15%', 0, 16, '', 6),
('bx_spaces_prices_manage', 'period', '_bx_spaces_grid_column_title_period', '15%', 0, 16, '', 7),
('bx_spaces_prices_manage', 'default_price', '_bx_spaces_grid_column_title_default_price', '5%', 0, 0, '', 8),
('bx_spaces_prices_manage', 'actions', '', '20%', 0, 0, '', 9);
