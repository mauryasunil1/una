-- PAGES
UPDATE `sys_objects_page` SET `layout_id`='13' WHERE `object`='bx_tasks_context';

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_tasks_context' AND `title_system`='_bx_tasks_page_block_title_sys_menu_in_context';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_tasks_context', 2, 'bx_tasks', '_bx_tasks_page_block_title_sys_menu_in_context', '_bx_tasks_page_block_title_menu_in_context', 13, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:22:"get_block_menu_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 0, 0, 1, 1);

UPDATE `sys_pages_blocks` SET `cell_id`='3' WHERE `object`='bx_tasks_context' AND `title_system`='_bx_tasks_page_block_title_sys_entries_in_context';
UPDATE `sys_pages_blocks` SET `cell_id`='4' WHERE `object`='bx_tasks_context' AND `title_system`='_bx_tasks_page_block_title_sys_calendar_in_context';

DELETE FROM `sys_objects_page` WHERE `object`='bx_tasks_context_time';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_tasks_context_time', 'tasks-context-time', '_bx_tasks_page_title_sys_entries_time_in_context', '_bx_tasks_page_title_entries_time_in_context', 'bx_tasks', 13, 510, 1, '', '', '', '', 0, 1, 0, 'BxTasksPageAuthor', 'modules/boonex/tasks/classes/BxTasksPageAuthor.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_tasks_context_time';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_tasks_context_time', 2, 'bx_tasks', '_bx_tasks_page_block_title_sys_menu_in_context', '_bx_tasks_page_block_title_menu_in_context', 13, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:22:"get_block_menu_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 0, 0, 1, 1),
('bx_tasks_context_time', 3, 'bx_tasks', '_bx_tasks_page_block_title_sys_entries_time_in_context', '_bx_tasks_page_block_title_entries_time_in_context', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:29:"get_block_manage_time_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 0, 0, 1, 1);

DELETE FROM `sys_objects_page` WHERE `object`='bx_tasks_context_time_administration';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_tasks_context_time_administration', 'tasks-context-time-administration', '_bx_tasks_page_title_sys_entries_time_in_context_administration', '_bx_tasks_page_title_entries_time_in_context_administration', 'bx_tasks', 13, 510, 1, '', '', '', '', 0, 1, 0, 'BxTasksPageAuthor', 'modules/boonex/tasks/classes/BxTasksPageAuthor.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_tasks_context_time_administration';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_tasks_context_time_administration', 2, 'bx_tasks', '_bx_tasks_page_block_title_sys_menu_in_context', '_bx_tasks_page_block_title_menu_in_context', 13, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:22:"get_block_menu_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 0, 0, 1, 1),
('bx_tasks_context_time_administration', 3, 'bx_tasks', '_bx_tasks_page_block_title_sys_entries_time_in_context_administration', '_bx_tasks_page_block_title_entries_time_in_context_administration', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:35:"get_block_administrate_time_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 0, 0, 1, 1);


-- MENUS
DELETE FROM `sys_menu_items` WHERE `set_name`='bx_tasks_view_actions' AND `name`='report-time';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_tasks_view_actions', 'bx_tasks', 'report-time', '_bx_tasks_menu_item_title_system_report_time', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 25);

DELETE FROM `sys_objects_menu` WHERE `object`='bx_tasks_view_context_submenu';
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_tasks_view_context_submenu', '_bx_tasks_menu_title_view_context_submenu', 'bx_tasks_view_context_submenu', 'bx_tasks', 6, 0, 1, 'BxTasksMenuView', 'modules/boonex/tasks/classes/BxTasksMenuView.php');

DELETE FROM `sys_menu_sets` WHERE `set_name`='bx_tasks_view_context_submenu';
INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_tasks_view_context_submenu', 'bx_tasks', '_bx_tasks_menu_set_title_view_context_submenu', 0);

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_tasks_view_context_submenu';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_tasks_view_context_submenu', 'bx_tasks', 'tasks-context', '_bx_tasks_menu_item_title_system_view_context_entries', '_bx_tasks_menu_item_title_view_context_entries', 'page.php?i=tasks-context&profile_id={profile_id}', '', '', '', '', 2147483647, '', 1, 0, 1),
('bx_tasks_view_context_submenu', 'bx_tasks', 'tasks-context-time', '_bx_tasks_menu_item_title_system_view_context_time', '_bx_tasks_menu_item_title_view_context_time', 'page.php?i=tasks-context-time&profile_id={profile_id}', '', '', '', '', 2147483647, '', 1, 0, 2),
('bx_tasks_view_context_submenu', 'bx_tasks', 'tasks-context-time-administration', '_bx_tasks_menu_item_title_system_view_context_time_administration', '_bx_tasks_menu_item_title_view_context_time_administration', 'page.php?i=tasks-context-time-administration&profile_id={profile_id}', '', '', '', '', 2147483647, 'a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:31:"check_allowed_manage_in_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 1, 0, 3);


-- GRIDS
DELETE FROM `sys_objects_grid` WHERE `object` IN ('bx_tasks_time_administration', 'bx_tasks_time');
INSERT INTO `sys_objects_grid` (`object`, `source_type`, `source`, `table`, `field_id`, `field_order`, `field_active`, `paginate_url`, `paginate_per_page`, `paginate_simple`, `paginate_get_start`, `paginate_get_per_page`, `filter_fields`, `filter_fields_translatable`, `filter_mode`, `sorting_fields`, `sorting_fields_translatable`, `visible_for_levels`, `override_class_name`, `override_class_file`) VALUES
('bx_tasks_time_administration', 'Sql', 'SELECT `ttt`.*, `tt`.`title` FROM `bx_tasks_time_track` AS `ttt` INNER JOIN `bx_tasks_tasks` AS `tt` ON `ttt`.`object_id`=`tt`.`id` WHERE 1 ', 'bx_tasks_time_track', 'id', 'date', '', '', 20, NULL, 'start', '', 'ttt`.`text,tt`.`title,tt`.`text', '', 'like', 'date', '', 192, 'BxTasksGridTimeAdministration', 'modules/boonex/tasks/classes/BxTasksGridTimeAdministration.php'),
('bx_tasks_time', 'Sql', 'SELECT `ttt`.*, `tt`.`title` FROM `bx_tasks_time_track` AS `ttt` INNER JOIN `bx_tasks_tasks` AS `tt` ON `ttt`.`object_id`=`tt`.`id` WHERE 1 ', 'bx_tasks_time_track', 'id', 'date', '', '', 20, NULL, 'start', '', 'ttt`.`text,tt`.`title,tt`.`text', '', 'like', 'date', '', 2147483647, 'BxTasksGridTime', 'modules/boonex/tasks/classes/BxTasksGridTime.php');

DELETE FROM `sys_grid_fields` WHERE `object` IN ('bx_tasks_time_administration', 'bx_tasks_time');
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_tasks_time_administration', 'checkbox', '_sys_select', '2%', 0, 0, '', 1),
('bx_tasks_time_administration', 'author_id', '_bx_tasks_grid_column_title_tm_author_id', '28%', 0, 0, '', 2),
('bx_tasks_time_administration', 'object_id', '_bx_tasks_grid_column_title_tm_object_id', '30%', 0, 0, '', 3),
('bx_tasks_time_administration', 'text', '_bx_tasks_grid_column_title_tm_text', '15%', 0, 16, '', 4),
('bx_tasks_time_administration', 'value', '_bx_tasks_grid_column_title_tm_value', '10%', 0, 0, '', 5),
('bx_tasks_time_administration', 'value_date', '_bx_tasks_grid_column_title_tm_value_date', '15%', 0, 0, '', 6),

('bx_tasks_time', 'checkbox', '_sys_select', '2%', 0, 0, '', 1),
('bx_tasks_time', 'object_id', '_bx_tasks_grid_column_title_tm_object_id', '30%', 0, 0, '', 2),
('bx_tasks_time', 'text', '_bx_tasks_grid_column_title_tm_text', '25%', 0, 32, '', 3),
('bx_tasks_time', 'value', '_bx_tasks_grid_column_title_tm_value', '10%', 0, 0, '', 4),
('bx_tasks_time', 'value_date', '_bx_tasks_grid_column_title_tm_value_date', '15%', 0, 0, '', 5),
('bx_tasks_time', 'actions', '', '18%', 0, '', '', 6);

DELETE FROM `sys_grid_actions` WHERE `object` IN ('bx_tasks_time_administration', 'bx_tasks_time');
INSERT INTO `sys_grid_actions` (`object`, `type`, `name`, `title`, `icon`, `icon_only`, `confirm`, `order`) VALUES
('bx_tasks_time_administration', 'bulk', 'calculate', '_bx_tasks_grid_action_title_tm_calculate', '', 0, 0, 1),
('bx_tasks_time_administration', 'bulk', 'delete', '_bx_tasks_grid_action_title_tm_delete', '', 0, 1, 2),

('bx_tasks_time', 'independent', 'add', '_bx_tasks_grid_action_title_tm_add', '', 0, 0, 1),
('bx_tasks_time', 'bulk', 'delete', '_bx_tasks_grid_action_title_tm_delete', '', 0, 1, 1),
('bx_tasks_time', 'single', 'edit', '_bx_tasks_grid_action_title_tm_edit', 'pencil-alt', 1, 0, 1),
('bx_tasks_time', 'single', 'delete', '_bx_tasks_grid_action_title_tm_delete', 'remove', 1, 1, 2);


-- ALERTS
SET @iHandler := (SELECT `id` FROM `sys_alerts_handlers` WHERE `name`='bx_tasks' LIMIT 1);
DELETE FROM `sys_alerts` WHERE `unit`='profile' AND `action`='search_by_term' AND `handler_id`=@iHandler;
INSERT INTO `sys_alerts` (`unit`, `action`, `handler_id`) VALUES
('profile', 'search_by_term', @iHandler);
