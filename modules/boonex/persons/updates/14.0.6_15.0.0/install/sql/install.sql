SET @sName = 'bx_persons';


-- TABLES
CREATE TABLE IF NOT EXISTS `bx_persons_reactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `reaction` varchar(32) NOT NULL default '',
  `count` int(11) NOT NULL default '0',
  `sum` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reaction` (`object_id`, `reaction`)
);

CREATE TABLE IF NOT EXISTS `bx_persons_reactions_track` (
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
DELETE FROM `sys_objects_transcoder` WHERE `object`='bx_persons_badge';
INSERT INTO `sys_objects_transcoder` (`object`, `storage_object`, `source_type`, `source_params`, `private`, `atime_tracking`, `atime_pruning`, `ts`) VALUES 
('bx_persons_badge', 'bx_persons_pictures_resized', 'Storage', 'a:1:{s:6:"object";s:19:"bx_persons_pictures";}', 'no', '1', '2592000', '0');

DELETE FROM `sys_transcoder_filters` WHERE `transcoder_object`='bx_persons_badge';
INSERT INTO `sys_transcoder_filters` (`transcoder_object`, `filter`, `filter_params`, `order`) VALUES 
('bx_persons_badge', 'Resize', 'a:3:{s:1:"w";s:2:"32";s:1:"h";s:2:"32";s:13:"square_resize";s:1:"1";}', '0');


-- FORMS
DELETE FROM `sys_form_displays` WHERE `display_name`='bx_person_edit_badge';
INSERT INTO `sys_form_displays`(`object`, `display_name`, `module`, `view_mode`, `title`) VALUES 
('bx_person', 'bx_person_edit_badge', 'bx_persons', 0, '_bx_persons_form_profile_display_edit_badge');

DELETE FROM `sys_form_inputs` WHERE `object`='bx_person' AND `name` IN ('do_cancel', 'controls', 'badge', 'badge_link');
INSERT INTO `sys_form_inputs`(`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`, `rateable`) VALUES 
('bx_person', 'bx_persons', 'do_cancel', '_sys_form_input_cancel', '', 0, 'button', '_sys_form_input_sys_cancel', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:41:"window.open(''{edit_cancel_url}'', ''_self'')";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 0, 0, ''),
('bx_person', 'bx_persons', 'controls', '', 'do_submit,do_cancel', 0, 'input_set', '_sys_form_input_sys_controls', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0, ''),
('bx_person', 'bx_persons', 'badge', 'a:1:{i:0;s:21:"bx_persons_badge_crop";}', 'a:1:{s:21:"bx_persons_badge_crop";s:24:"_sys_uploader_crop_title";}', 0, 'files', '_bx_persons_form_profile_input_sys_badge', '_bx_persons_form_profile_input_badge', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0, ''),
('bx_person', 'bx_persons', 'badge_link', '', '', 0, 'text', '_bx_persons_form_profile_input_sys_badge_link', '_bx_persons_form_profile_input_badge_link', '', 0, 0, 0, '', '', '', '', '', '', 'Xss', '', 1, 0, '');

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_person_edit' AND `input_name` IN ('controls', 'do_submit', 'do_cancel');
SET @iOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_form_display_inputs` WHERE `display_name`='bx_person_edit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_person_edit', 'controls', 2147483647, 1, @iOrder+1),
('bx_person_edit', 'do_submit', 2147483647, 1, @iOrder+2),
('bx_person_edit', 'do_cancel', 2147483647, 1, @iOrder+3);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_person_edit_badge' AND `input_name` IN ('badge', 'badge_link', 'do_submit');
INSERT INTO `sys_form_display_inputs`(`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES 
('bx_person_edit_badge', 'badge', 2147483647, 1, 1),
('bx_person_edit_badge', 'badge_link', 2147483647, 1, 2),
('bx_person_edit_badge', 'do_submit', 2147483647, 1, 3);


-- VOTES

DELETE FROM `sys_objects_vote` WHERE `Name`='bx_persons_reactions';
INSERT INTO `sys_objects_vote` (`Name`, `Module`, `TableMain`, `TableTrack`, `PostTimeout`, `MinValue`, `MaxValue`, `IsUndo`, `IsOn`, `TriggerTable`, `TriggerFieldId`, `TriggerFieldAuthor`, `TriggerFieldRate`, `TriggerFieldRateCount`, `ClassName`, `ClassFile`) VALUES 
('bx_persons_reactions', 'bx_persons', 'bx_persons_reactions', 'bx_persons_reactions_track', '604800', '1', '1', '1', '1', 'bx_persons_data', 'id', 'author', 'rrate', 'rvotes', 'BxTemplVoteReactions', '');


-- SCORES
UPDATE `sys_objects_score` SET `is_on`='1' WHERE `name`='bx_persons';
