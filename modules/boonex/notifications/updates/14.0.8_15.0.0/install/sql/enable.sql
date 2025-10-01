SET @sName = 'bx_notifications';


-- MENUS
UPDATE `sys_objects_menu` SET `title_public`='_bx_ntfs_menu_title_public_submenu' WHERE `object`='bx_notifications_submenu';

DELETE FROM `sys_menu_items` WHERE `set_name`='sys_ntfs_submenu' AND `name`='notifications-view';
SET @iMIOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_menu_items` WHERE `set_name` = 'sys_ntfs_submenu' AND `order` < 9999);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `markers`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `hidden_on`, `active`, `copyable`, `order`) VALUES
('sys_ntfs_submenu', 'bx_notifications', 'notifications-view', '_bx_ntfs_menu_item_title_system_notifications', '_bx_ntfs_menu_item_title_notifications', 'page.php?i=notifications-view', '', '', 'bell col-green3', 'a:2:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:28:"get_unread_notifications_num";}', '', 'bx_notifications_preview', 1, 2147483646, 0, 1, 1, @iMIOrder + 1);
