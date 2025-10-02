SET @sName = 'bx_timeline';


-- TABLES
CREATE TABLE IF NOT EXISTS `bx_timeline_polls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL default '0',
  `content_id` int(11) NOT NULL default '0',
  `text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `content_id` (`content_id`),
  FULLTEXT KEY `search_fields` (`text`)
);

CREATE TABLE IF NOT EXISTS `bx_timeline_polls_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) unsigned NOT NULL default '0',
  `title` varchar(255) NOT NULL,
  `rate` float NOT NULL default '0',
  `votes` int(11) NOT NULL default '0',
  `order` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  KEY `poll_id` (`poll_id`),
  FULLTEXT KEY `title` (`title`)
);

CREATE TABLE IF NOT EXISTS `bx_timeline_polls_answers_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `count` int(11) NOT NULL default '0',
  `sum` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `object_id` (`object_id`)
);

CREATE TABLE IF NOT EXISTS `bx_timeline_polls_answers_votes_track` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL default '0',
  `author_id` int(11) NOT NULL default '0',
  `author_nip` int(11) unsigned NOT NULL default '0',
  `value` tinyint(4) NOT NULL default '0',
  `date` int(11) NOT NULL default '0',
  PRIMARY KEY (`id`),
  KEY `vote` (`object_id`, `author_nip`)
);


-- FORMS
DELETE FROM `sys_form_inputs` WHERE `object`='bx_timeline_post' AND `name`='polls';
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_timeline_post', 'bx_timeline', 'polls', '', '', 0, 'custom', '_bx_timeline_form_post_input_sys_polls', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 1, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name` IN ('bx_timeline_post_add', 'bx_timeline_post_add_public', 'bx_timeline_post_add_profile', 'bx_timeline_post_edit') AND `input_name`='polls';
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_timeline_post_add', 'polls', 2147483647, 1, 9),
('bx_timeline_post_add_public', 'polls', 2147483647, 1, 9),
('bx_timeline_post_add_profile', 'polls', 2147483647, 1, 9),
('bx_timeline_post_edit', 'polls', 2147483647, 1, 9);

DELETE FROM `sys_objects_form` WHERE `object`='bx_timeline_poll';
INSERT INTO `sys_objects_form` (`object`, `module`, `title`, `action`, `form_attrs`, `submit_name`, `table`, `key`, `uri`, `uri_title`, `params`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES
('bx_timeline_poll', 'bx_timeline', '_bx_timeline_form_poll', '', '', 'do_submit', 'bx_timeline_polls', 'id', '', '', 'a:1:{s:14:"checker_helper";s:31:"BxTimelineFormPollCheckerHelper";}', 0, 1, 'BxTimelineFormPoll', 'modules/boonex/timeline/classes/BxTimelineFormPoll.php');

DELETE FROM `sys_form_displays` WHERE `object`='bx_timeline_poll';
INSERT INTO `sys_form_displays` (`display_name`, `module`, `object`, `title`, `view_mode`) VALUES
('bx_timeline_poll_add', 'bx_timeline', 'bx_timeline_poll', '_bx_timeline_form_poll_display_add', 0);

DELETE FROM `sys_form_inputs` WHERE `object`='bx_timeline_poll';
INSERT INTO `sys_form_inputs` (`object`, `module`, `name`, `value`, `values`, `checked`, `type`, `caption_system`, `caption`, `info`, `required`, `collapsed`, `html`, `attrs`, `attrs_tr`, `attrs_wrapper`, `checker_func`, `checker_params`, `checker_error`, `db_pass`, `db_params`, `editable`, `deletable`) VALUES
('bx_timeline_poll', 'bx_timeline', 'text', '', '', 0, 'text', '_bx_timeline_form_poll_input_sys_text', '_bx_timeline_form_poll_input_text', '', 1, 0, 0, '', '', '', 'Avail', '', '_bx_timeline_form_poll_input_text_err', 'Xss', '', 1, 0),
('bx_timeline_poll', 'bx_timeline', 'answers', '', '', 0, 'custom', '_bx_timeline_form_poll_input_sys_answers', '_bx_timeline_form_poll_input_answers', '', 1, 0, 0, '', '', '', 'AvailAnswers', '', '_bx_timeline_form_poll_input_answers_err', '', '', 1, 0),
('bx_timeline_poll', 'bx_timeline', 'controls', '', 'do_submit,do_cancel', 0, 'input_set', '', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_timeline_poll', 'bx_timeline', 'do_submit', '_bx_timeline_form_poll_input_do_submit', '', 0, 'submit', '_bx_timeline_form_poll_input_sys_do_submit', '', '', 0, 0, 0, '', '', '', '', '', '', '', '', 0, 0),
('bx_timeline_poll', 'bx_timeline', 'do_cancel', '_bx_timeline_form_poll_input_do_cancel', '', 0, 'button', '_bx_timeline_form_poll_input_do_cancel', '', '', 0, 0, 0, 'a:2:{s:7:"onclick";s:45:"$(''.bx-popup-applied:visible'').dolPopupHide()";s:5:"class";s:22:"bx-def-margin-sec-left";}', '', '', '', '', '', '', '', 0, 0);

DELETE FROM `sys_form_display_inputs` WHERE `display_name`='bx_timeline_poll_add';
INSERT INTO `sys_form_display_inputs` (`display_name`, `input_name`, `visible_for_levels`, `active`, `order`) VALUES
('bx_timeline_poll_add', 'text', 2147483647, 1, 1),
('bx_timeline_poll_add', 'answers', 2147483647, 1, 2),
('bx_timeline_poll_add', 'controls', 2147483647, 1, 3),
('bx_timeline_poll_add', 'do_submit', 2147483647, 1, 4),
('bx_timeline_poll_add', 'do_cancel', 2147483647, 1, 5);


-- VOTES
DELETE FROM `sys_objects_vote` WHERE `Name`='bx_timeline_poll_answers';
INSERT INTO `sys_objects_vote`(`Name`, `Module`, `TableMain`, `TableTrack`, `PostTimeout`, `MinValue`, `MaxValue`, `IsUndo`, `IsOn`, `TriggerTable`, `TriggerFieldId`, `TriggerFieldAuthor`, `TriggerFieldRate`, `TriggerFieldRateCount`, `ClassName`, `ClassFile`) VALUES 
('bx_timeline_poll_answers', 'bx_timeline', 'bx_timeline_polls_answers_votes', 'bx_timeline_polls_answers_votes_track', '604800', '1', '1', '0', '1', 'bx_timeline_polls_answers', 'id', 'author_id', 'rate', 'votes', 'BxTimelineVotePollAnswers', 'modules/boonex/timeline/classes/BxTimelineVotePollAnswers.php');
