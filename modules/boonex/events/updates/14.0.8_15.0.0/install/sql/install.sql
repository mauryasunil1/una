SET @sName = 'bx_events';


-- TABLES
CREATE TABLE IF NOT EXISTS `bx_events_reactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `reaction` varchar(32) NOT NULL default '',
  `count` int(11) NOT NULL default '0',
  `sum` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reaction` (`object_id`, `reaction`)
);

CREATE TABLE IF NOT EXISTS `bx_events_reactions_track` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `author_id` int(11) NOT NULL default '0',
  `author_nip` int(11) unsigned NOT NULL default '0',
  `reaction` varchar(32) NOT NULL default '',
  `value` tinyint(4) NOT NULL default '0',
  `date` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  KEY `vote` (`object_id`, `author_nip`)
);


-- FORMS
DELETE FROM `sys_form_inputs` WHERE `object`='bx_event' AND `name` IN ('do_cancel', 'controls');
INSERT INTO `sys_form_inputs`(`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES 
('bx_event', 'bx_events', 'do_cancel', '_sys_form_input_cancel', '', 0, 'button', '_sys_form_input_sys_cancel', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:41:"window.open(''{edit_cancel_url}'', ''_self'')";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 0, 0),
('bx_event', 'bx_events', 'controls', '', 'do_submit,do_cancel', 0, 'input_set', '_sys_form_input_sys_controls', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_event_edit' AND `input_name` IN ('controls', 'do_submit', 'do_cancel');
SET @iOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_form_display_inputs` WHERE `display_name`='bx_event_edit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_event_edit', 'controls', 2147483647, 1, @iOrder+1),
('bx_event_edit', 'do_submit', 2147483647, 1, @iOrder+2),
('bx_event_edit', 'do_cancel', 2147483647, 1, @iOrder+3);

UPDATE `sys_form_inputs` SET `type`='select', `caption`='_bx_events_form_price_input_role_id', `checker_error`='_bx_events_form_price_input_err_role_id', `db_pass`='Xss' WHERE `object`='bx_events_price' AND `name`='role_id';

DELETE FROM `sys_form_inputs` WHERE `object`='bx_events_price' AND `name` IN ('caption', 'default');
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_events_price', 'bx_events', 'caption', '', '', 0, 'text', '_bx_events_form_price_input_sys_caption', '_bx_events_form_price_input_caption', '_bx_events_form_price_input_inf_caption', 1, 0, 0, '', '', '', 'Avail', '', '_bx_events_form_price_input_err_caption', 'Xss', '', 1, 0),
('bx_events_price', 'bx_events', 'default', 1, '', 0, 'switcher', '_bx_events_form_price_input_sys_default', '_bx_events_form_price_input_default', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 1, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_events_price_add' AND `input_name` IN ('caption', 'default');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_events_price_add', 'caption', 2147483647, 1, 3),
('bx_events_price_add', 'default', 2147483647, 1, 6);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_events_price_edit' AND `input_name`IN ('caption', 'default');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_events_price_edit', 'caption', 2147483647, 1, 3),
('bx_events_price_edit', 'default', 2147483647, 1, 6);


-- VOTES
DELETE FROM `sys_objects_vote` WHERE `Name`='bx_events_reactions';
INSERT INTO `sys_objects_vote` (`Name`, `Module`, `TableMain`, `TableTrack`, `PostTimeout`, `MinValue`, `MaxValue`, `IsUndo`, `IsOn`, `TriggerTable`, `TriggerFieldId`, `TriggerFieldAuthor`, `TriggerFieldRate`, `TriggerFieldRateCount`, `ClassName`, `ClassFile`) VALUES 
('bx_events_reactions', 'bx_events', 'bx_events_reactions', 'bx_events_reactions_track', '604800', '1', '1', '1', '1', 'bx_events_data', 'id', 'author', 'rrate', 'rvotes', 'BxTemplVoteReactions', '');


-- SCORES
UPDATE `sys_objects_score` SET `is_on`='1' WHERE `name`='bx_events';
