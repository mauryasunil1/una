-- MENUS
DELETE FROM `sys_menu_items` WHERE `set_name`='sys_create_post' AND `name`='create-post';
SET @iCreatePostOrder = (SELECT `order` FROM `sys_menu_items` WHERE `set_name` = 'sys_create_post' AND `active` = 1 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_create_post', 'bx_posts', 'create-post', '_bx_posts_menu_item_title_system_create_entry', '_bx_posts_menu_item_title_create_entry', 'page.php?i=create-post', '', '', 'file-alt col-red3', '', 2147483647, 1, 0, IFNULL(@iCreatePostOrder, 0) + 1);

UPDATE `sys_objects_menu` SET `title_public`='_bx_posts_menu_title_public_submenu' WHERE `object`='bx_posts_submenu';
