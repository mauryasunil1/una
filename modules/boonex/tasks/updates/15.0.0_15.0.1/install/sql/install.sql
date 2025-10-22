-- TABLES
CREATE TABLE IF NOT EXISTS `bx_tasks_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `count` int(11) NOT NULL default '0',
  `sum` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_id` (`object_id`)
);

CREATE TABLE IF NOT EXISTS `bx_tasks_time_track` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `author_id` int(11) NOT NULL default '0',
  `author_nip` int(11) unsigned NOT NULL default '0',
  `value` int(11) NOT NULL default '0',
  `value_date` int(11) NOT NULL default '0',
  `text` text NOT NULL default '',
  `date` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`)
);


-- FORMS
DELETE FROM `sys_form_inputs` WHERE `object`='bx_tasks' AND `name`='estimate';
INSERT INTO `sys_form_inputs`(`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES 
('bx_tasks', 'bx_tasks', 'estimate', '', '', 0, 'text', '_bx_tasks_form_entry_input_sys_estimate', '_bx_tasks_form_entry_input_estimate', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 1, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name` IN ('bx_tasks_entry_add', 'bx_tasks_entry_edit', 'bx_tasks_entry_view') AND `input_name`='estimate';
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_tasks_entry_add', 'estimate', 2147483647, 1, 6),
('bx_tasks_entry_edit', 'estimate', 2147483647, 1, 12),
('bx_tasks_entry_view', 'estimate', 2147483647, 1, 2);

UPDATE `sys_form_inputs` SET `db_pass`='DateTimeUtc' WHERE `object`='bx_tasks' AND `name`='due_date';
UPDATE `sys_form_inputs` SET `caption_system`='_bx_tasks_form_entry_input_sys_initial_members', `caption`='_bx_tasks_form_entry_input_initial_members' WHERE `object`='bx_tasks' AND `name`='initial_members';


DELETE FROM `sys_objects_form` WHERE `object`='bx_tasks_time';
INSERT INTO `sys_objects_form` (`object`, `module`, `title`, `action`, `form_attrs`, `submit_name`, `table`, `key`, `uri`, `uri_title`, `params`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES
('bx_tasks_time', 'bx_tasks', '_bx_tasks_form_time', 'report.php', 'a:3:{s:2:"id";s:0:"";s:4:"name";s:0:"";s:5:"class";s:17:"bx-report-do-form";}', 'submit', '', 'id', '', '', '', 0, 1, '', '');

DELETE FROM `sys_form_displays` WHERE `object`='bx_tasks_time';
INSERT INTO `sys_form_displays` (`display_name`, `module`, `object`, `title`, `view_mode`) VALUES
('bx_tasks_time_add', 'bx_tasks', 'bx_tasks_time', '_bx_tasks_form_display_time_add', 0),
('bx_tasks_time_edit', 'bx_tasks', 'bx_tasks_time', '_bx_tasks_form_display_time_edit', 0);

DELETE FROM `sys_form_inputs` WHERE `object`='bx_tasks_time';
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_tasks_time', 'bx_tasks', 'sys', '', '', 0, 'hidden', '_bx_tasks_form_time_input_sys_sys', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_tasks_time', 'bx_tasks', 'object_id', '', '', 0, 'hidden', '_bx_tasks_form_time_input_sys_object_id', '_bx_tasks_form_time_input_object_id', '', 0, 0, 0, '', '', '', '', '', '', 'Int', '', 0, 0),
('bx_tasks_time', 'bx_tasks', 'action', '', '', 0, 'hidden', '_bx_tasks_form_time_input_sys_action', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_tasks_time', 'bx_tasks', 'value', '', '', 0, 'time', '_bx_tasks_form_time_input_sys_value', '_bx_tasks_form_time_input_value', '', 1, 0, 0, '', '', '', 'Avail', '', '_bx_tasks_form_time_input_value_err', 'Xss', '', 1, 0),
('bx_tasks_time', 'bx_tasks', 'value_date', '', '', 0, 'datepicker', '_bx_tasks_form_time_input_sys_value_date', '_bx_tasks_form_time_input_value_date', '_bx_tasks_form_time_input_value_date_inf', 0, 0, 0, '', '', '', '', '', '', 'DateUtc', '', 1, 0),
('bx_tasks_time', 'bx_tasks', 'text', '', '', 0, 'textarea', '_bx_tasks_form_time_input_sys_text', '_bx_tasks_form_time_input_text', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 1, 0),
('bx_tasks_time', 'bx_tasks', 'submit', '_bx_tasks_form_time_input_submit', '', 0, 'submit', '_bx_tasks_form_time_input_sys_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_tasks_time', 'bx_tasks', 'cancel', '_bx_tasks_form_time_input_cancel', '', 0, 'button', '_bx_tasks_form_time_input_sys_cancel', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:45:"$(''.bx-popup-applied:visible'').dolPopupHide()";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 1, 0),
('bx_tasks_time', 'bx_tasks', 'controls', '', 'submit,cancel', 0, 'input_set', '_bx_tasks_form_time_input_sys_controls', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name` IN ('bx_tasks_time_add', 'bx_tasks_time_edit');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_tasks_time_add', 'sys', 2147483647, 1, 1),
('bx_tasks_time_add', 'object_id', 2147483647, 1, 2),
('bx_tasks_time_add', 'action', 2147483647, 1, 3),
('bx_tasks_time_add', 'value', 2147483647, 1, 4),
('bx_tasks_time_add', 'value_date', 2147483647, 1, 5),
('bx_tasks_time_add', 'text', 2147483647, 1, 6),
('bx_tasks_time_add', 'controls', 2147483647, 1, 7),
('bx_tasks_time_add', 'submit', 2147483647, 1, 8),
('bx_tasks_time_add', 'cancel', 2147483647, 1, 9),

('bx_tasks_time_edit', 'value', 2147483647, 1, 1),
('bx_tasks_time_edit', 'value_date', 2147483647, 1, 2),
('bx_tasks_time_edit', 'text', 2147483647, 1, 3),
('bx_tasks_time_edit', 'controls', 2147483647, 1, 4),
('bx_tasks_time_edit', 'submit', 2147483647, 1, 5),
('bx_tasks_time_edit', 'cancel', 2147483647, 1, 6);


-- REPORTS
DELETE FROM `sys_objects_report` WHERE `name`='bx_tasks_time';
INSERT INTO `sys_objects_report` (`name`, `module`, `table_main`, `table_track`, `pruning`, `is_on`, `base_url`, `object_comment`, `trigger_table`, `trigger_field_id`, `trigger_field_author`, `trigger_field_count`, `class_name`, `class_file`) VALUES 
('bx_tasks_time', 'bx_tasks', 'bx_tasks_time', 'bx_tasks_time_track', '0', '1', 'page.php?i=view-task&id={object_id}', '', 'bx_tasks_tasks', 'id', 'author', 'time', 'BxTasksTime', 'modules/boonex/tasks/classes/BxTasksTime.php');
