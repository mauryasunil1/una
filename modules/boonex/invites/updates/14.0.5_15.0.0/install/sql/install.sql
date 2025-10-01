SET @sName = 'bx_invites';


-- FORMS
UPDATE `sys_objects_form` SET `submit_name`='a:2:{i:0;s:13:"ifi_do_submit";i:1;s:11:"ifi_do_send";}' WHERE `object`='bx_invites_invite';

DELETE FROM `sys_form_displays` WHERE `display_name`='bx_invites_invite_accept_by_code';
INSERT INTO `sys_form_displays` (`display_name`, `module`, `object`, `title`, `view_mode`) VALUES
('bx_invites_invite_accept_by_code', @sName, 'bx_invites_invite', '_bx_invites_form_invite_display_accept_by_code', 0);

DELETE FROM `sys_form_inputs` WHERE `object`='bx_invites_invite' AND `name` IN ('email_use', 'key', 'ifi_do_send');
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_invites_invite', @sName, 'email_use', 1, '', 0, 'switcher', '_bx_invites_form_invite_input_sys_email_use', '_bx_invites_form_invite_input_email_use', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_invites_invite', @sName, 'key', '', '', 0, 'text', '_bx_invites_form_invite_input_sys_key', '_bx_invites_form_invite_input_key', '', 1, 0, 0, '', '', '', 'Avail', '', '_bx_invites_form_invite_input_key_err', '', '', 0, 0),
('bx_invites_invite', @sName, 'ifi_do_send', '_bx_invites_form_invite_input_do_send', '', 0, 'submit', '_bx_invites_form_invite_input_sys_do_send', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0);

UPDATE `sys_form_display_inputs` SET `input_name`='ifi_do_send' WHERE `display_name`='bx_invites_invite_send' AND `input_name`='ifi_do_submit';

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_invites_invite_send' AND `input_name`='email_use';
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_invites_invite_send', 'email_use', 2147483647, 1, 2);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_invites_invite_accept_by_code';
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_invites_invite_accept_by_code', 'key', 2147483647, 1, 1),
('bx_invites_invite_accept_by_code', 'ifi_do_submit', 2147483647, 1, 2);
