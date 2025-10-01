SET @sName = 'bx_acl';


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`=@sName LIMIT 1);
DELETE FROM `sys_options` WHERE `name`='bx_acl_show_to_unauthenticated';
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `check`, `check_error`, `extra`, `order`) VALUES
('bx_acl_show_to_unauthenticated', '', @iCategId, '_bx_acl_option_show_to_unauthenticated', 'checkbox', '', '', '', 10);
