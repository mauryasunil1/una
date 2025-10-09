-- FORMS
DELETE FROM `sys_form_inputs` WHERE `object`='bx_ads' AND `name` IN ('do_cancel', 'controls');
INSERT INTO `sys_form_inputs`(`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES 
('bx_ads', 'bx_ads', 'do_cancel', '_sys_form_input_cancel', '', 0, 'button', '_sys_form_input_sys_cancel', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:41:"window.open(''{edit_cancel_url}'', ''_self'')";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 0, 0),
('bx_ads', 'bx_ads', 'controls', '', 'do_submit,do_cancel', 0, 'input_set', '_sys_form_input_sys_controls', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_ads_entry_price_edit' AND `input_name` IN ('controls', 'do_submit', 'do_cancel');
SET @iOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_form_display_inputs` WHERE `display_name`='bx_ads_entry_price_edit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_ads_entry_price_edit', 'controls', 2147483647, 1, @iOrder+1),
('bx_ads_entry_price_edit', 'do_submit', 2147483647, 1, @iOrder+2),
('bx_ads_entry_price_edit', 'do_cancel', 2147483647, 1, @iOrder+3);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_ads_entry_price_year_edit' AND `input_name` IN ('controls', 'do_submit', 'do_cancel');
SET @iOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_form_display_inputs` WHERE `display_name`='bx_ads_entry_price_year_edit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_ads_entry_price_year_edit', 'controls', 2147483647, 1, @iOrder+1),
('bx_ads_entry_price_year_edit', 'do_submit', 2147483647, 1, @iOrder+2),
('bx_ads_entry_price_year_edit', 'do_cancel', 2147483647, 1, @iOrder+3);

DELETE FROM `sys_form_display_inputs` WHERE `display_name` IN ('bx_ads_entry_price_add', 'bx_ads_entry_price_edit', 'bx_ads_entry_price_year_add', 'bx_ads_entry_price_year_edit') AND `input_name`='seg_sex';
DELETE FROM `sys_form_display_inputs` WHERE `display_name` IN ('bx_ads_entry_price_add', 'bx_ads_entry_price_edit', 'bx_ads_entry_price_year_add', 'bx_ads_entry_price_year_edit') AND `input_name`='seg_gender';
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_ads_entry_price_add', 'seg_gender', 2147483647, 1, 26),
('bx_ads_entry_price_edit', 'seg_gender', 2147483647, 1, 23),

('bx_ads_entry_price_year_add', 'seg_gender', 2147483647, 1, 27),
('bx_ads_entry_price_year_edit', 'seg_gender', 2147483647, 1, 24);
