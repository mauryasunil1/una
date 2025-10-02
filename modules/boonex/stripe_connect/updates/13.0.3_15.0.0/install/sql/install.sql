SET @sName = 'bx_stripe_connect';


-- TABLES
DROP TABLE IF EXISTS `bx_stripe_connect_accounts`;

CREATE TABLE IF NOT EXISTS `bx_stripe_connect_accounts` (
  `id` int(11) NOT NULL auto_increment,
  `added` int(11) NOT NULL default '0',
  `changed` int(11) NOT NULL default '0',
  `profile_id` int(11) NOT NULL default '0',
  `live_account_id` varchar(64) NOT NULL default '',
  `live_details` tinyint(4) NOT NULL default '0',
  `test_account_id` varchar(64) NOT NULL default '',
  `test_details` tinyint(4) NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_id` (`profile_id`)
);

CREATE TABLE IF NOT EXISTS `bx_stripe_connect_commissions` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default '',
  `acl_id` int(11) NOT NULL default '0',
  `fee_single` varchar(8) NOT NULL default '',
  `fee_recurring` varchar(8) NOT NULL default '',
  `active` tinyint(4) NOT NULL default '0',
  `order` tinyint(4) NOT NULL default '0',
  PRIMARY KEY(`id`),
  UNIQUE KEY `name`(`name`)
);


-- FORMS
DELETE FROM `sys_objects_form` WHERE `object`='bx_stripe_connect_form_commissions';
INSERT INTO `sys_objects_form` (`object`, `module`, `title`, `action`, `form_attrs`, `submit_name`, `table`, `key`, `uri`, `uri_title`, `params`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES
('bx_stripe_connect_form_commissions', @sName, '_bx_stripe_connect_form_commissions_form', '', '', 'do_submit', 'bx_stripe_connect_commissions', 'id', '', '', '', 0, 1, 'BxStripeConnectFormCommissions', 'modules/boonex/stripe_connect/classes/BxStripeConnectFormCommissions.php');

DELETE FROM `sys_form_displays` WHERE `object`='bx_stripe_connect_form_commissions';
INSERT INTO `sys_form_displays` (`display_name`, `module`, `object`, `title`, `view_mode`) VALUES
('bx_stripe_connect_form_commissions_add', @sName, 'bx_stripe_connect_form_commissions', '_bx_stripe_connect_form_commissions_display_add', 0),
('bx_stripe_connect_form_commissions_edit', @sName, 'bx_stripe_connect_form_commissions', '_bx_stripe_connect_form_commissions_display_edit', 0);

DELETE FROM `sys_form_inputs` WHERE `object`='bx_stripe_connect_form_commissions';
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_stripe_connect_form_commissions', @sName, 'name', '0', '', 0, 'text', '_bx_stripe_connect_form_commissions_input_sys_name', '_bx_stripe_connect_form_commissions_input_name', '', 1, 0, 0, '', '', '', 'Avail', '', '_bx_stripe_connect_form_commissions_input_name_err', 'Xss', '', 0, 0),
('bx_stripe_connect_form_commissions', @sName, 'acl_id', '0', '', 0, 'select', '_bx_stripe_connect_form_commissions_input_sys_acl_id', '_bx_stripe_connect_form_commissions_input_acl_id', '', 1, 0, 0, '', '', '', 'Avail', '', '_bx_stripe_connect_form_commissions_input_acl_id_err', 'Int', '', 0, 0),
('bx_stripe_connect_form_commissions', @sName, 'fee_single', '0', '', 0, 'text', '_bx_stripe_connect_form_commissions_input_sys_fee_single', '_bx_stripe_connect_form_commissions_input_fee_single', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 0, 0),
('bx_stripe_connect_form_commissions', @sName, 'fee_recurring', '0', '', 0, 'text', '_bx_stripe_connect_form_commissions_input_sys_fee_recurring', '_bx_stripe_connect_form_commissions_input_fee_recurring', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 0, 0),
('bx_stripe_connect_form_commissions', @sName, 'controls', '', 'do_submit,do_cancel', 0, 'input_set', '', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_stripe_connect_form_commissions', @sName, 'do_submit', '_bx_stripe_connect_form_commissions_input_submit', '', 0, 'submit', '_bx_stripe_connect_form_commissions_input_sys_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_stripe_connect_form_commissions', @sName, 'do_cancel', '_bx_stripe_connect_form_commissions_input_cancel', '', 0, 'button', '_bx_stripe_connect_form_commissions_input_sys_cancel', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:45:"$(''.bx-popup-applied:visible'').dolPopupHide()";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 0, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name` IN ('bx_stripe_connect_form_commissions_add', 'bx_stripe_connect_form_commissions_edit');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_stripe_connect_form_commissions_add', 'name', 2147483647, 1, 1),
('bx_stripe_connect_form_commissions_add', 'acl_id', 2147483647, 1, 2),
('bx_stripe_connect_form_commissions_add', 'fee_single', 2147483647, 1, 3),
('bx_stripe_connect_form_commissions_add', 'fee_recurring', 2147483647, 1, 4),
('bx_stripe_connect_form_commissions_add', 'controls', 2147483647, 1, 5),
('bx_stripe_connect_form_commissions_add', 'do_submit', 2147483647, 1, 6),
('bx_stripe_connect_form_commissions_add', 'do_cancel', 2147483647, 1, 7),

('bx_stripe_connect_form_commissions_edit', 'name', 2147483647, 1, 1),
('bx_stripe_connect_form_commissions_edit', 'acl_id', 2147483647, 1, 2),
('bx_stripe_connect_form_commissions_edit', 'fee_single', 2147483647, 1, 3),
('bx_stripe_connect_form_commissions_edit', 'fee_recurring', 2147483647, 1, 4),
('bx_stripe_connect_form_commissions_edit', 'controls', 2147483647, 1, 6),
('bx_stripe_connect_form_commissions_edit', 'do_submit', 2147483647, 1, 7),
('bx_stripe_connect_form_commissions_edit', 'do_cancel', 2147483647, 1, 8);
