SET @sName = 'bx_organizations';


-- TABLES
CREATE TABLE IF NOT EXISTS `bx_organizations_reactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `reaction` varchar(32) NOT NULL default '',
  `count` int(11) NOT NULL default '0',
  `sum` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reaction` (`object_id`, `reaction`)
);

CREATE TABLE IF NOT EXISTS `bx_organizations_reactions_track` (
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


-- STORAGES & TRANSCODERS
DELETE FROM `sys_objects_transcoder` WHERE `object`='bx_organizations_badge';
INSERT INTO `sys_objects_transcoder` (`object`, `storage_object`, `source_type`, `source_params`, `private`, `atime_tracking`, `atime_pruning`, `ts`) VALUES 
('bx_organizations_badge', 'bx_organizations_pics_resized', 'Storage', 'a:1:{s:6:"object";s:21:"bx_organizations_pics";}', 'no', '1', '2592000', '0');

DELETE FROM `sys_transcoder_filters` WHERE `transcoder_object`='bx_organizations_badge';
INSERT INTO `sys_transcoder_filters` (`transcoder_object`, `filter`, `filter_params`, `order`) VALUES 
('bx_organizations_badge', 'Resize', 'a:3:{s:1:"w";s:2:"32";s:1:"h";s:2:"32";s:13:"square_resize";s:1:"1";}', '0');


-- FORMS
DELETE FROM `sys_form_displays` WHERE `display_name`='bx_organization_edit_badge';
INSERT INTO `sys_form_displays`(`object`, `display_name`, `module`, `view_mode`, `title`) VALUES 
('bx_organization', 'bx_organization_edit_badge', 'bx_organizations', 0, '_bx_orgs_form_profile_display_edit_badge');

DELETE FROM `sys_form_inputs` WHERE `object`='bx_organization' AND `name` IN ('do_cancel', 'controls', 'badge', 'badge_link');
INSERT INTO `sys_form_inputs`(`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES 
('bx_organization', 'bx_organizations', 'do_cancel', '_sys_form_input_cancel', '', 0, 'button', '_sys_form_input_sys_cancel', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:41:"window.open(''{edit_cancel_url}'', ''_self'')";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 0, 0),
('bx_organization', 'bx_organizations', 'controls', '', 'do_submit,do_cancel', 0, 'input_set', '_sys_form_input_sys_controls', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_organization', 'bx_organizations', 'badge', 'a:1:{i:0;s:27:"bx_organizations_badge_crop";}', 'a:1:{s:27:"bx_organizations_badge_crop";s:24:"_sys_uploader_crop_title";}', 0, 'files', '_bx_orgs_form_profile_input_sys_badge', '_bx_orgs_form_profile_input_badge', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0),
('bx_organization', 'bx_organizations', 'badge_link', '', '', 0, 'text', '_bx_orgs_form_profile_input_sys_badge_link', '_bx_orgs_form_profile_input_badge_link', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 1, 0);

UPDATE `sys_form_inputs` SET `type`='datetime' WHERE `object`='bx_organization' AND `name`='profile_last_active';

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_organization_edit' AND `input_name` IN ('controls', 'do_submit', 'do_cancel');
SET @iOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_form_display_inputs` WHERE `display_name`='bx_organization_edit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_organization_edit', 'controls', 2147483647, 1, @iOrder+1),
('bx_organization_edit', 'do_submit', 2147483647, 1, @iOrder+2),
('bx_organization_edit', 'do_cancel', 2147483647, 1, @iOrder+3);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_organization_edit_badge' AND `input_name` IN ('badge', 'badge_link', 'do_submit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_organization_edit_badge', 'badge', 2147483647, 1, 1),
('bx_organization_edit_badge', 'badge_link', 2147483647, 1, 2),
('bx_organization_edit_badge', 'do_submit', 2147483647, 1, 3);

UPDATE `sys_form_inputs` SET `type`='select', `caption`='_bx_orgs_form_price_input_role_id', `checker_error`='_bx_orgs_form_price_input_err_role_id', `db_pass`='Xss' WHERE `object`='bx_organizations_price' AND `name`='role_id';

DELETE FROM `sys_form_inputs` WHERE `object`='bx_organizations_price' AND `name` IN ('caption', 'default');
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_organizations_price', 'bx_organizations', 'caption', '', '', 0, 'text', '_bx_orgs_form_price_input_sys_caption', '_bx_orgs_form_price_input_caption', '_bx_orgs_form_price_input_inf_caption', 1, 0, 0, '', '', '', 'Avail', '', '_bx_orgs_form_price_input_err_caption', 'Xss', '', 1, 0),
('bx_organizations_price', 'bx_organizations', 'default', 1, '', 0, 'switcher', '_bx_orgs_form_price_input_sys_default', '_bx_orgs_form_price_input_default', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 1, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_organizations_price_add' AND `input_name` IN ('caption', 'default');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_organizations_price_add', 'caption', 2147483647, 1, 3),
('bx_organizations_price_add', 'default', 2147483647, 1, 6);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_organizations_price_edit' AND `input_name`IN ('caption', 'default');
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_organizations_price_edit', 'caption', 2147483647, 1, 3),
('bx_organizations_price_edit', 'default', 2147483647, 1, 6);


-- VOTES
DELETE FROM `sys_objects_vote` WHERE `Name`='bx_organizations_reactions';
INSERT INTO `sys_objects_vote` (`Name`, `Module`, `TableMain`, `TableTrack`, `PostTimeout`, `MinValue`, `MaxValue`, `IsUndo`, `IsOn`, `TriggerTable`, `TriggerFieldId`, `TriggerFieldAuthor`, `TriggerFieldRate`, `TriggerFieldRateCount`, `ClassName`, `ClassFile`) VALUES 
('bx_organizations_reactions', 'bx_organizations', 'bx_organizations_reactions', 'bx_organizations_reactions_track', '604800', '1', '1', '1', '1', 'bx_organizations_data', 'id', 'author', 'rrate', 'rvotes', 'BxTemplVoteReactions', '');


-- SCORES
UPDATE `sys_objects_score` SET `is_on`='1' WHERE `name`='bx_organizations';
