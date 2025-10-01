SET @sName = 'bx_developer';


-- FORMS
DELETE FROM `sys_form_inputs` WHERE `object`='bx_developer_nav_menu' AND `name`='title_public';
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_developer_nav_menu', @sName, 'title_public', '', '', 0, 'text', '_bx_dev_nav_txt_sys_menus_title_public', '_bx_dev_nav_txt_menus_title_public', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 0, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name` IN ('bx_developer_nav_menu_add', 'bx_developer_nav_menu_edit') AND `input_name`='title_public';
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_developer_nav_menu_add', 'title_public', 2147483647, 1, 3),
('bx_developer_nav_menu_edit', 'title_public', 2147483647, 1, 4);

UPDATE `sys_form_display_inputs` SET `active`='1' WHERE `display_name`='bx_developer_nav_set_edit' AND `input_name`='set_name';

UPDATE `sys_form_inputs` SET `type`='textarea' WHERE `object`='bx_developer_nav_item' AND `name`='icon';
