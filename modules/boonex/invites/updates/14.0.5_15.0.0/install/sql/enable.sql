SET @sName = 'bx_invites';


-- PAGES
DELETE FROM `sys_pages_blocks` WHERE `module`=@sName AND `title_system` LIKE '_bx_invites_page_block_title_system_invite_to_context%';
DELETE FROM `sys_pages_blocks` WHERE `module`=@sName AND `title_system` LIKE '_bx_invites_page_block_title_system_accept_by_code%';
SET @iBlockOrder = (SELECT `order` FROM `sys_pages_blocks` WHERE `object` = '' AND `cell_id` = 0 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('', 0, @sName, '_bx_invites_page_block_title_system_invite_to_context', '_bx_invites_page_block_title_invite', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:10:"bx_invites";s:6:"method";s:27:"get_block_invite_to_context";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 0, 1, 1, @iBlockOrder + 1),
('', 0, @sName, '_bx_invites_page_block_title_system_accept_by_code', '_bx_invites_page_block_title_accept_by_code', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:10:"bx_invites";s:6:"method";s:24:"get_block_accept_by_code";}', 0, 1, 1, @iBlockOrder + 2);


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`=@sName LIMIT 1);
DELETE FROM `sys_options` WHERE `name` IN ('bx_invites_context_auto_join', 'bx_invites_context_key_length');
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `check`, `check_error`, `extra`, `order`) VALUES
('bx_invites_context_auto_join', '', @iCategId, '_bx_invites_option_context_auto_join', 'checkbox', '', '', '', 20),
('bx_invites_context_key_length', '0', @iCategId, '_bx_invites_option_context_key_length', 'digit', '', '', '', 22);


-- GRIDS
UPDATE `sys_objects_grid` SET `sorting_fields`='email,date,date_seen,date_joined' WHERE `object`='bx_invites_invites';

DELETE FROM `sys_grid_fields` WHERE `object`='bx_invites_invites';
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_invites_invites', 'checkbox', '_sys_select', '2%', 0, '', '', 1),
('bx_invites_invites', 'who_send', '_bx_invites_grid_invites_column_title_who_sent', '12%', 0, '', '', 2),
('bx_invites_invites', 'multi', '_bx_invites_grid_invites_column_title_multi', '5%', 0, '16', '', 3),
('bx_invites_invites', 'email', '_bx_invites_grid_invites_column_title_email', '15%', 1, '25', '', 4),
('bx_invites_invites', 'aj', '_bx_invites_grid_invites_column_title_aj', '10%', 0, '16', '', 5),
('bx_invites_invites', 'date', '_bx_invites_grid_invites_column_title_date', '8%', 0, '20', '', 6),
('bx_invites_invites', 'date_seen', '_bx_invites_grid_invites_column_title_date_seen', '8%', 0, '20', '', 7),
('bx_invites_invites', 'joined_account', '_bx_invites_grid_invites_column_title_joined_account', '12%', 0, '20', '', 8),
('bx_invites_invites', 'date_joined', '_bx_invites_grid_invites_column_title_date_joined', '8%', 0, '20', '', 9),
('bx_invites_invites', 'request', '_bx_invites_grid_invites_column_title_request', '8%', 0, '20', '', 10),
('bx_invites_invites', 'actions', '', '12%', 0, '', '', 11);


-- ALERTS
SET @iHandler := (SELECT `id` FROM `sys_alerts_handlers` WHERE `name`=@sName LIMIT 1);
DELETE FROM `sys_alerts` WHERE `unit`='account' AND `action`='add_form_check' AND `handler_id`=@iHandler;
INSERT INTO `sys_alerts` (`unit`, `action`, `handler_id`) VALUES
('account', 'add_form_check', @iHandler);
