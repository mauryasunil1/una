SET @sName = 'bx_notifications';


-- ALERTS
SET @iHandler := (SELECT `id` FROM `sys_alerts_handlers` WHERE `name`=@sName LIMIT 1);

DELETE FROM `sys_alerts` WHERE `unit`='sys_cmts' AND `action`='reported_content' AND `handler_id`=@iHandler;
INSERT INTO `sys_alerts` (`unit`, `action`, `handler_id`) VALUES
('sys_cmts', 'reported_content', @iHandler);
