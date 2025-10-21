SET @sName = 'bx_notifications';


-- TABLES
SET @iHandlerId = (SELECT `id` FROM `bx_notifications_handlers` WHERE `group`='sys_cmts_object_reported' AND `type`='insert');
DELETE FROM `bx_notifications_handlers` WHERE `id`=@iHandlerId;
DELETE FROM `bx_notifications_settings` WHERE `handler_id`=@iHandlerId;

INSERT INTO `bx_notifications_handlers`(`group`, `type`, `alert_unit`, `alert_action`, `content`, `privacy`) VALUES 
('sys_cmts_object_reported', 'insert', 'sys_cmts', 'reported_content', 'a:3:{s:11:"module_name";s:6:"system";s:13:"module_method";s:34:"get_notifications_comment_reported";s:12:"module_class";s:17:"TemplCmtsServices";}', '');
SET @iHandlerId = LAST_INSERT_ID();

INSERT INTO `bx_notifications_settings`(`group`, `handler_id`, `delivery`, `type`, `title`, `order`) VALUES
('action_required', @iHandlerId, 'site', 'personal', '_bx_ntfs_alert_action_reported_content_personal', 8),
('action_required', @iHandlerId, 'email', 'personal', '_bx_ntfs_alert_action_reported_content_personal', 8),
('action_required', @iHandlerId, 'push', 'personal', '_bx_ntfs_alert_action_reported_content_personal', 8);
