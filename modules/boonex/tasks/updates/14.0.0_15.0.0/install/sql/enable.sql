-- MENUS
DELETE FROM `sys_menu_items` WHERE `set_name`='bx_tasks_view' AND `name`='edit-task-state';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_tasks_view', 'bx_tasks', 'edit-task-state', '_bx_tasks_menu_item_title_system_edit_entry_state', '_bx_tasks_menu_item_title_edit_entry_state', 'javascript:void(0)', 'javascript:{js_object}.processTaskEditState({content_id}, this)', '', 'pencil-alt', '', 2147483647, '', 1, 0, 2);

UPDATE `sys_menu_items` SET `visibility_custom`='' WHERE `set_name`='bx_tasks_view' AND `name` IN ('edit-task', 'delete-task');

DELETE FROM `sys_menu_items` WHERE `set_name`='bx_tasks_view_actions' AND `name`='edit-task-state';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `visibility_custom`, `active`, `copyable`, `order`) VALUES 
('bx_tasks_view_actions', 'bx_tasks', 'edit-task-state', '_bx_tasks_menu_item_title_system_edit_entry_state', '', '', '', '', '', '', '', 0, 2147483647, '', 1, 0, 12);

UPDATE `sys_menu_items` SET `visibility_custom`='' WHERE `set_name`='bx_tasks_view_actions' AND `name` IN ('edit-task', 'delete-task');

UPDATE `sys_menu_items` SET `visibility_custom`='a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:22:"check_allowed_complete";s:6:"params";a:1:{i:0;s:12:"{content_id}";}}' WHERE `set_name`='bx_tasks_view_actions' AND `name`='set-completed';
UPDATE `sys_menu_items` SET `visibility_custom`='a:3:{s:6:"module";s:8:"bx_tasks";s:6:"method";s:24:"check_allowed_uncomplete";s:6:"params";a:1:{i:0;s:12:"{content_id}";}}' WHERE `set_name`='bx_tasks_view_actions' AND `name`='set-uncompleted';
