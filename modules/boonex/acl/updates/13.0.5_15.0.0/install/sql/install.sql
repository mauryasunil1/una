SET @sName = 'bx_acl';


-- FORMS
UPDATE `sys_form_inputs` SET `type`='select', `caption`='_bx_acl_form_price_input_level_id', `checker_func`='Avail', `checker_error`='_bx_acl_form_price_input_err_level_id' WHERE `object`='bx_acl_price' AND `name`='level_id';

DELETE FROM `sys_form_inputs` WHERE `object`='bx_acl_price' AND `name` IN ('caption', 'description', 'details');
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_acl_price', @sName, 'caption', '0', '', 0, 'text_translatable', '_bx_acl_form_price_input_sys_caption', '_bx_acl_form_price_input_caption', '_bx_acl_form_price_input_inf_caption', 1, 0, 0, '', '', '', 'AvailTranslatable', 'a:1:{i:0;s:7:"caption";}', '_bx_acl_form_price_input_err_caption', 'Xss', '', 0, 0),
('bx_acl_price', @sName, 'description', '0', '', 0, 'textarea_translatable', '_bx_acl_form_price_input_sys_description', '_bx_acl_form_price_input_description', '', 0, 0, 3, '', '', '', '', '', '', 'Xss', '', 0, 0),
('bx_acl_price', @sName, 'details', '0', '', 0, 'textarea_translatable', '_bx_acl_form_price_input_sys_details', '_bx_acl_form_price_input_details', '', 0, 0, 3, '', '', '', '', '', '', 'Xss', '', 0, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_acl_price_add' AND `input_name` IN ('caption', 'description', 'details');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_acl_price_add', 'caption', 2147483647, 1, 3),
('bx_acl_price_add', 'description', 2147483647, 1, 3),
('bx_acl_price_add', 'details', 2147483647, 1, 3);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_acl_price_edit' AND `input_name` IN ('caption', 'description', 'details');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_acl_price_edit', 'caption', 2147483647, 1, 3),
('bx_acl_price_edit', 'description', 2147483647, 1, 3),
('bx_acl_price_edit', 'details', 2147483647, 1, 3);


-- GRIDS
UPDATE `sys_objects_grid` SET `field_active`='active', `filter_fields_translatable`='caption' WHERE `object`='bx_acl_administration';
UPDATE `sys_objects_grid` SET `source`='SELECT `tlp`.*, `tl`.`Name` AS `level_name`, `tl`.`Icon` AS `level_icon` FROM `bx_acl_level_prices` AS `tlp` LEFT JOIN `sys_acl_levels` AS `tl` ON `tlp`.`level_id`=`tl`.`ID` WHERE `tlp`.`active`<>''0'' && `tl`.`Active`=''yes'' AND `tl`.`Purchasable`=''yes'' ' WHERE `object`='bx_acl_view';

DELETE FROM `sys_grid_fields` WHERE `object`='bx_acl_administration';
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_acl_administration', 'checkbox', '_sys_select', '2%', 0, '', '', 1),
('bx_acl_administration', 'order', '', '2%', 0, '', '', 2),
('bx_acl_administration', 'switcher', '', '6%', 0, '', '', 3),
('bx_acl_administration', 'level_id', '_bx_acl_grid_column_level_id', '10%', 0, 16, '', 4),
('bx_acl_administration', 'name', '_bx_acl_grid_column_name', '10%', 0, 16, '', 5),
('bx_acl_administration', 'caption', '_bx_acl_grid_column_caption', '10%', 1, 16, '', 6),
('bx_acl_administration', 'description', '_bx_acl_grid_column_description', '8%', 1, 8, '', 7),
('bx_acl_administration', 'details', '_bx_acl_grid_column_details', '8%', 1, 8, '', 8),
('bx_acl_administration', 'price', '_bx_acl_grid_column_price', '8%', 0, 16, '', 9),
('bx_acl_administration', 'period', '_bx_acl_grid_column_period', '8%', 0, 16, '', 10),
('bx_acl_administration', 'trial', '_bx_acl_grid_column_trial', '8%', 0, 16, '', 11),
('bx_acl_administration', 'actions', '', '20%', 0, '', '', 12);

DELETE FROM `sys_grid_fields` WHERE `object`='bx_acl_view' AND `name` IN ('description', 'details');
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_acl_view', 'description', '_bx_acl_grid_column_description', '10%', 1, 8, '', 3),
('bx_acl_view', 'details', '_bx_acl_grid_column_details', '10%', 1, 8, '', 4);

UPDATE `sys_grid_fields` set `width`='10%' WHERE `object`='bx_acl_view' AND `name` IN ('period', 'trial');
UPDATE `sys_grid_fields` set `width`='20%' WHERE `object`='bx_acl_view' AND `name` IN ('actions');
