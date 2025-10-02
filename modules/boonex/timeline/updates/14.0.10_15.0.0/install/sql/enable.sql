SET @sName = 'bx_timeline';


-- PAGES
DELETE FROM `sys_pages_blocks` WHERE `object`='bx_timeline_item' AND `title`='_bx_timeline_page_block_title_item_polls';
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('bx_timeline_item', 1, 'bx_timeline', '', '_bx_timeline_page_block_title_item_polls', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:11:"bx_timeline";s:6:"method";s:12:"entity_polls";}', 0, 0, 1, 5);


-- MENUS
DELETE FROM `sys_menu_items` WHERE `set_name`='bx_timeline_menu_post_attachments' AND `name`='add-poll';
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `editable`, `order`) VALUES 
('bx_timeline_menu_post_attachments', 'bx_timeline', 'add-poll', '_bx_timeline_menu_item_title_system_add_poll', '_bx_timeline_menu_item_title_add_poll', 'javascript:void(0)', 'javascript:{js_object_poll}.showPollForm(this);', '_self', 'tasks', '', '', 2147483647, 1, 0, 1, 9);

DELETE FROM `sys_menu_items` WHERE `set_name`='sys_create_post' AND `name`='create-item';
SET @iCreatePostOrder = (SELECT `order` FROM `sys_menu_items` WHERE `set_name` = 'sys_create_post' AND `active` = 1 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_create_post', 'bx_timeline', 'create-item', '_bx_timeline_menu_item_title_system_create_entry', '_bx_timeline_menu_item_title_create_entry', 'page.php?i=timeline-view&profile_id={member_id}', '', '', 'far clock col-green1', '', 2147483647, 1, 0, IFNULL(@iCreatePostOrder, 0) + 1);
