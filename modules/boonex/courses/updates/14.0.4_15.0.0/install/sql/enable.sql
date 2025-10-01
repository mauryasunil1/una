-- TABLES
UPDATE `bx_courses_prices` SET `added` = (SELECT `td`.`added` FROM `bx_courses_data` AS `td` INNER JOIN `sys_profiles` AS `tp` ON `td`.`id`=`tp`.`content_id` AND `tp`.`type`='bx_courses' WHERE `tp`.`id`=`profile_id` LIMIT 1);


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`='bx_courses' LIMIT 1); 
DELETE FROM `sys_options` WHERE `name`='bx_courses_use_cover_as_thumb';
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `info`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
('bx_courses_use_cover_as_thumb', 'on', @iCategId, '_bx_courses_option_use_cover_as_thumb', '_bx_courses_option_use_cover_as_thumb_inf', 'checkbox', '', '', '', 2);


-- PAGES
DELETE FROM `sys_pages_blocks` WHERE `object`='bx_courses_view_profile' AND `title`='_bx_events_page_block_title_entry_context';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('bx_courses_view_profile', 3, 'bx_courses', '', '_bx_events_page_block_title_entry_context', 13, 2147483647, 'service', 'a:2:{s:6:"module";s:10:"bx_courses";s:6:"method";s:14:"entity_context";}', 0, 0, 1, 1);

DELETE FROM `sys_objects_page` WHERE `object`='bx_courses_context';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_courses_context', 'courses-context', '_bx_courses_page_title_sys_entries_in_context', '_bx_courses_page_title_entries_in_context', 'bx_courses', 5, 2147483647, 1, '', '', '', '', 0, 1, 0, 'BxCoursesPageEntriesInContext', 'modules/boonex/courses/classes/BxCoursesPageEntriesInContext.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_courses_context';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_courses_context', 1, 'bx_courses', '_bx_courses_page_block_title_sys_entries_in_context', '_bx_courses_page_block_title_entries_in_context', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:10:"bx_courses";s:6:"method";s:14:"browse_context";}', 0, 0, 1, 1);


-- MENUS
UPDATE `sys_menu_items` set `title`='{title_pay_and_join}' WHERE `set_name`='bx_courses_view_actions' AND `name`='join-course-profile';

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_courses_view_actions_more' AND `name`='add-course-content';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_courses_view_actions_more', 'bx_courses', 'add-course-content', '_bx_courses_menu_item_title_system_add_content', '_bx_courses_menu_item_title_add_content', 'javascript:void(0)', 'bx_menu_popup(''bx_courses_add_content'', this, {}, {profile_id:{profile_id}});', '', 'plus', 'bx_courses_add_content', 2147483647, '', 1, 0, 5);

DELETE FROM `sys_menu_items` WHERE `set_name`= 'bx_courses_view_actions_all' AND `name` IN ('profile-fans', 'profile-subscriptions', 'reaction');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_courses_view_actions_all', 'bx_courses', 'profile-fans', '_bx_courses_menu_item_title_system_fans', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 10),
('bx_courses_view_actions_all', 'bx_courses', 'profile-subscriptions', '_bx_courses_menu_item_title_system_subscriptions', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 30),
('bx_courses_view_actions_all', 'bx_courses', 'reaction', '_sys_menu_item_title_system_va_reaction', '', '', '', '', '', '', '', 0, 2147483647, '', 0, 0, 225);

UPDATE `sys_menu_items` SET `visibility_custom`='a:3:{s:6:"module";s:10:"bx_courses";s:6:"method";s:22:"is_free_join_avaliable";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}' WHERE `set_name`='bx_courses_view_actions_all' AND `name`='profile-fans';
UPDATE `sys_menu_items` SET `order`='12', `active`='0' WHERE `set_name`='bx_courses_view_actions_all' AND `name`='profile-fan-add';
UPDATE `sys_menu_items` SET `order`='14', `active`='0' WHERE `set_name`='bx_courses_view_actions_all' AND `name`='profile-fan-remove';
UPDATE `sys_menu_items` SET `order`='32', `active`='0' WHERE `set_name`='bx_courses_view_actions_all' AND `name`='profile-subscribe-add';
UPDATE `sys_menu_items` SET `order`='34', `active`='0' WHERE `set_name`='bx_courses_view_actions_all' AND `name`='profile-subscribe-remove';
UPDATE `sys_menu_items` SET `active`='0' WHERE `set_name`='bx_courses_view_actions_all' AND `name`='score';

DELETE FROM `sys_objects_menu` WHERE `object`='bx_courses_add_content';
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_courses_add_content', '_bx_courses_menu_title_add_content', 'sys_add_content_links', 'bx_courses', 6, 0, 1, 'BxCoursesMenuAddContent', 'modules/boonex/courses/classes/BxCoursesMenuAddContent.php');

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_courses_view_meta' AND `name` IN ('reactions', 'scores');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_courses_view_meta', 'bx_courses', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 0, 2147483647, '', 0, 0, 43),
('bx_courses_view_meta', 'bx_courses', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 0, 2147483647, '', 0, 0, 46);

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_courses_snippet_meta' AND `name` IN ('votes', 'reactions', 'scores');
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `editable`, `order`) VALUES
('bx_courses_snippet_meta', 'bx_courses', 'votes', '_sys_menu_item_title_system_sm_votes', '_sys_menu_item_title_sm_votes', '', '', '', '', '', 2147483647, '', 0, 0, 1, 16),
('bx_courses_snippet_meta', 'bx_courses', 'reactions', '_sys_menu_item_title_system_sm_reactions', '_sys_menu_item_title_sm_reactions', '', '', '', '', '', 2147483647, '', 0, 0, 1, 17),
('bx_courses_snippet_meta', 'bx_courses', 'scores', '_sys_menu_item_title_system_sm_scores', '_sys_menu_item_title_sm_scores', '', '', '', '', '', 2147483647, '', 0, 0, 1, 18);

DELETE FROM `sys_menu_items` WHERE `set_name`='trigger_group_view_submenu' AND `name`='courses-context';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('trigger_group_view_submenu', 'bx_courses', 'courses-context', '_bx_courses_menu_item_title_system_view_entries_in_context', '_bx_courses_menu_item_title_view_entries_in_context', 'page.php?i=courses-context&profile_id={profile_id}', '', '', 'book-reader col-blue3-dark', '', 2147483647, 'a:3:{s:6:"module";s:10:"bx_courses";s:6:"method";s:21:"is_enable_for_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 1, 0, 0);


-- CONNECTIONS
UPDATE `sys_objects_connection` SET `tt_content`='bx_courses_data', `tf_id_content`='id', `tf_count_content`='members' WHERE `object`='bx_courses_fans';

UPDATE `bx_courses_data` SET `members`=(SELECT COUNT(`tf`.`initiator`) FROM `bx_courses_fans` AS `tf` INNER JOIN `sys_profiles` AS `tp` ON `tf`.`content`=`tp`.`id` AND `tp`.`type`='bx_courses' AND  `tf`.`mutual`='1' WHERE `tp`.`content_id`=`bx_courses_data`.`id` GROUP BY `tf`.`content` LIMIT 1);


-- GRIDS
UPDATE `sys_objects_grid` SET `source`='SELECT *, `default` AS `default_price` FROM `bx_courses_prices` WHERE 1 ', `field_active`='active' WHERE `object`='bx_courses_prices_manage';
UPDATE `sys_objects_grid` SET `source`='SELECT * FROM `bx_courses_prices` WHERE `active`<>''0'' ' WHERE `object`='bx_courses_prices_view';

DELETE FROM `sys_grid_fields` WHERE `object`='bx_courses_prices_manage';
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_courses_prices_manage', 'checkbox', '_sys_select', '2%', 0, 0, '', 1),
('bx_courses_prices_manage', 'order', '', '2%', 0, 0, '', 2),
('bx_courses_prices_manage', 'switcher', '', '6%', 0, 0, '', 3),
('bx_courses_prices_manage', 'name', '_bx_courses_grid_column_title_name', '15%', 0, 16, '', 4),
('bx_courses_prices_manage', 'caption', '_bx_courses_grid_column_title_caption', '20%', 0, 32, '', 5),
('bx_courses_prices_manage', 'price', '_bx_courses_grid_column_title_price', '15%', 0, 16, '', 6),
('bx_courses_prices_manage', 'period', '_bx_courses_grid_column_title_period', '15%', 0, 16, '', 7),
('bx_courses_prices_manage', 'default_price', '_bx_courses_grid_column_title_default_price', '5%', 0, 0, '', 8),
('bx_courses_prices_manage', 'actions', '', '20%', 0, 0, '', 9);


-- PRIVACY
UPDATE `sys_objects_privacy` SET `spaces`='bx_spaces' WHERE `object`='bx_courses_allow_view_to';
