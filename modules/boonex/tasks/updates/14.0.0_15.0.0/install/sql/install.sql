-- FORMS
DELETE FROM `sys_form_displays` WHERE `display_name`='bx_tasks_entry_edit_state';
INSERT INTO `sys_form_displays`(`object`, `display_name`, `module`, `view_mode`, `title`) VALUES 
('bx_tasks', 'bx_tasks_entry_edit_state', 'bx_tasks', 0, '_bx_tasks_form_entry_display_edit_state');

DELETE FROM `sys_form_inputs` WHERE `object`='bx_tasks' AND `name` IN ('do_cancel_edit', 'controls_edit', 'controls_edit_popup', 'type', 'priority', 'state');
INSERT INTO `sys_form_inputs`(`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES 
('bx_tasks', 'bx_tasks', 'do_cancel_edit', '_bx_tasks_form_entry_input_do_cancel_edit', '', 0, 'button', '_bx_tasks_form_entry_input_sys_do_cancel_edit', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:41:"window.open(''{edit_cancel_url}'', ''_self'')";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 0, 0),
('bx_tasks', 'bx_tasks', 'controls_edit', '', 'do_submit,do_cancel_edit', 0, 'input_set', '_bx_tasks_form_entry_input_sys_controls_edit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0),
('bx_tasks', 'bx_tasks', 'controls_edit_popup', '', 'do_submit,do_cancel', 0, 'input_set', '_bx_tasks_form_entry_input_sys_controls_edit_popup', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0),
('bx_tasks', 'bx_tasks', 'type', '', '#!bx_tasks_types', 0, 'select', '_bx_tasks_form_entry_input_sys_type', '_bx_tasks_form_entry_input_type', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 1, 0),
('bx_tasks', 'bx_tasks', 'priority', '', '#!bx_tasks_priorities', 0, 'select', '_bx_tasks_form_entry_input_sys_priority', '_bx_tasks_form_entry_input_priority', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 1, 0),
('bx_tasks', 'bx_tasks', 'state', '', '#!bx_tasks_states', 0, 'select', '_bx_tasks_form_entry_input_sys_state', '_bx_tasks_form_entry_input_state', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 1, 0);

UPDATE `sys_form_inputs` SET `caption_system`='_bx_tasks_form_entry_input_sys_controls' WHERE `object`='bx_tasks' AND `name`='controls';

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_tasks_entry_add' AND `input_name` IN ('type', 'priority');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_tasks_entry_add', 'type', 2147483647, 1, 5),
('bx_tasks_entry_add', 'priority', 2147483647, 1, 5);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_tasks_entry_edit' AND `input_name` IN ('tasks_list', 'type', 'priority', 'controls_edit', 'do_cancel_edit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_tasks_entry_edit', 'type', 2147483647, 1, 13),
('bx_tasks_entry_edit', 'priority', 2147483647, 1, 13),
('bx_tasks_entry_edit', 'controls_edit', 2147483647, 1, 13),
('bx_tasks_entry_edit', 'do_cancel_edit', 2147483647, 1, 15);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_tasks_entry_edit_state';
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_tasks_entry_edit_state', 'state', 2147483647, 1, 1),
('bx_tasks_entry_edit_state', 'controls_edit_popup', 2147483647, 1, 2),
('bx_tasks_entry_edit_state', 'do_submit', 2147483647, 1, 3),
('bx_tasks_entry_edit_state', 'do_cancel', 2147483647, 1, 4);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_tasks_entry_view' AND `input_name` IN ('type', 'priority', 'state');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_tasks_entry_view', 'type', 2147483647, 1, 0),
('bx_tasks_entry_view', 'priority', 2147483647, 1, 0),
('bx_tasks_entry_view', 'state', 2147483647, 1, 5);


-- PRE-VALUES
DELETE FROM `sys_form_pre_lists` WHERE `key`='bx_tasks_types';
INSERT INTO `sys_form_pre_lists`(`key`, `title`, `module`, `use_for_sets`) VALUES
('bx_tasks_types', '_bx_tasks_pre_lists_types', 'bx_tasks', '0');

DELETE FROM `sys_form_pre_values` WHERE `Key`='bx_tasks_types';
INSERT INTO `sys_form_pre_values`(`Key`, `Value`, `Order`, `LKey`, `LKey2`) VALUES
('bx_tasks_types', '', 0, '_sys_please_select', ''),
('bx_tasks_types', '1', 1, '_bx_tasks_type_1', ''),
('bx_tasks_types', '2', 2, '_bx_tasks_type_2', ''),
('bx_tasks_types', '3', 3, '_bx_tasks_type_3', '');

DELETE FROM `sys_form_pre_lists` WHERE `key`='bx_tasks_priorities';
INSERT INTO `sys_form_pre_lists`(`key`, `title`, `module`, `use_for_sets`) VALUES
('bx_tasks_priorities', '_bx_tasks_pre_lists_priorities', 'bx_tasks', '0');

DELETE FROM `sys_form_pre_values` WHERE `Key`='bx_tasks_priorities';
INSERT INTO `sys_form_pre_values`(`Key`, `Value`, `Order`, `LKey`, `LKey2`) VALUES
('bx_tasks_priorities', '', 0, '_sys_please_select', ''),
('bx_tasks_priorities', '1', 1, '_bx_tasks_priority_1', ''),
('bx_tasks_priorities', '2', 2, '_bx_tasks_priority_2', ''),
('bx_tasks_priorities', '3', 3, '_bx_tasks_priority_3', ''),
('bx_tasks_priorities', '4', 4, '_bx_tasks_priority_4', ''),
('bx_tasks_priorities', '5', 5, '_bx_tasks_priority_5', '');

DELETE FROM `sys_form_pre_lists` WHERE `key`='bx_tasks_states';
INSERT INTO `sys_form_pre_lists`(`key`, `title`, `module`, `use_for_sets`) VALUES
('bx_tasks_states', '_bx_tasks_pre_lists_states', 'bx_tasks', '0');

DELETE FROM `sys_form_pre_values` WHERE `Key`='bx_tasks_states';
INSERT INTO `sys_form_pre_values`(`Key`, `Value`, `Order`, `LKey`, `LKey2`) VALUES
('bx_tasks_states', '', 0, '_sys_please_select', ''),
('bx_tasks_states', '1', 1, '_bx_tasks_state_1', ''),
('bx_tasks_states', '2', 2, '_bx_tasks_state_2', ''),
('bx_tasks_states', '3', 3, '_bx_tasks_state_3', ''),
('bx_tasks_states', '4', 4, '_bx_tasks_state_4', ''),
('bx_tasks_states', '5', 5, '_bx_tasks_state_5', ''),
('bx_tasks_states', '6', 6, '_bx_tasks_state_6', ''),
('bx_tasks_states', '7', 7, '_bx_tasks_state_7', '');
