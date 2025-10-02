SET @sName = 'bx_stripe_connect';


-- SETTINGS
SET @iCategId = (SELECT `id` FROM `sys_options_categories` WHERE `name`=@sName LIMIT 1);
DELETE FROM `sys_options` WHERE `name` IN('bx_stripe_connect_api_id_live', 'bx_stripe_connect_api_id_test', 'bx_stripe_connect_api_scope', 'bx_stripe_connect_pmode_single', 'bx_stripe_connect_pmode_recurring', 'bx_stripe_connect_pmode', 'bx_stripe_connect_redirect_url');
INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `check`, `check_error`, `order`, `extra`) VALUES
('bx_stripe_connect_pmode', 'direct', @iCategId, '_bx_stripe_connect_option_pmode', 'select', '', '', 60, 'a:2:{s:6:"module";s:17:"bx_stripe_connect";s:6:"method";s:17:"get_options_pmode";}');


-- PAGES
DELETE FROM `sys_objects_page` WHERE `object`='bx_stripe_connect_result';
DELETE FROM `sys_pages_blocks` WHERE `object`='bx_stripe_connect_result';

DELETE FROM `sys_objects_page` WHERE `object`='bx_stripe_connect_activity';
INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_stripe_connect_activity', 'connected-activity', '_bx_stripe_connect_page_title_sys_connected_activity', '_bx_stripe_connect_page_title_connected_activity', @sName, 12, 2147483647, 0, '', '', '', '', 0, 1, 0, 'BxStripeConnectPageActivity', 'modules/boonex/stripe_connect/classes/BxStripeConnectPageActivity.php');

DELETE FROM `sys_pages_blocks` WHERE `object`='bx_stripe_connect_activity';
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_stripe_connect_activity', 0, @sName, '_bx_stripe_connect_page_block_title_reporting_chart', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:17:"bx_stripe_connect";s:6:"method";s:25:"get_block_reporting_chart";}', 0, 0, 0, 1),
('bx_stripe_connect_activity', 2, @sName, '_bx_stripe_connect_page_block_title_payments', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:17:"bx_stripe_connect";s:6:"method";s:18:"get_block_payments";}', 0, 0, 1, 1),
('bx_stripe_connect_activity', 3, @sName, '_bx_stripe_connect_page_block_title_balances', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:17:"bx_stripe_connect";s:6:"method";s:18:"get_block_balances";}', 0, 0, 1, 1),
('bx_stripe_connect_activity', 3, @sName, '_bx_stripe_connect_page_block_title_notifications', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:17:"bx_stripe_connect";s:6:"method";s:23:"get_block_notifications";}', 0, 0, 1, 2);

DELETE FROM `sys_pages_blocks` WHERE `object`='sys_dashboard' AND `title`='_bx_stripe_connect_page_block_title_connect';


-- MENUS
DELETE FROM `sys_menu_items` WHERE `set_name`='sys_account_dashboard' AND `name`='connected-activity';
SET @iAccountDashboardMenuOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_menu_items` WHERE `set_name`='sys_account_dashboard' LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `editable`, `order`) VALUES
('sys_account_dashboard', @sName, 'connected-activity', '_bx_stripe_connect_menu_item_title_system_connected_activity', '_bx_stripe_connect_menu_item_title_connected_activity', 'page.php?i=connected-activity', '', '', 'cc-stripe col-blue1', '', '', 2147483646, 1, 0, 1, @iAccountDashboardMenuOrder + 1);


-- GRIDS
UPDATE `sys_objects_grid` SET `paginate_per_page`='20', `filter_fields`='live_account_id,test_account_id', `sorting_fields`='live_account_id,test_account_id' WHERE `object`='bx_stripe_connect_accounts';

DELETE FROM `sys_grid_fields` WHERE `object`='bx_stripe_connect_accounts';
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_stripe_connect_accounts', 'checkbox', '_sys_select', '2%', 0, '', '', 1),
('bx_stripe_connect_accounts', 'profile_id', '_bx_stripe_connect_grid_column_title_profile_id', '15%', 0, '', '', 2),
('bx_stripe_connect_accounts', 'live_account_id', '_bx_stripe_connect_grid_column_title_live_account_id', '18%', 0, 32, '', 3),
('bx_stripe_connect_accounts', 'live_details', '_bx_stripe_connect_grid_column_title_live_details', '5%', 0, '', '', 4),
('bx_stripe_connect_accounts', 'test_account_id', '_bx_stripe_connect_grid_column_title_test_account_id', '18%', 0, 32, '', 5),
('bx_stripe_connect_accounts', 'test_details', '_bx_stripe_connect_grid_column_title_test_details', '5%', 0, '', '', 6),
('bx_stripe_connect_accounts', 'added', '_bx_stripe_connect_grid_column_title_added', '10%', 0, '', '', 7),
('bx_stripe_connect_accounts', 'changed', '_bx_stripe_connect_grid_column_title_changed', '10%', 0, '', '', 8),
('bx_stripe_connect_accounts', 'actions', '', '17%', 0, '', '', 9);

UPDATE `sys_grid_actions` SET `icon`='times' WHERE `object`='bx_stripe_connect_accounts' AND `type`='single' AND `name`='delete';

DELETE FROM `sys_objects_grid` WHERE `object`='bx_stripe_connect_commissions';
INSERT INTO `sys_objects_grid` (`object`, `source_type`, `source`, `table`, `field_id`, `field_order`, `field_active`, `paginate_url`, `paginate_per_page`, `paginate_simple`, `paginate_get_start`, `paginate_get_per_page`, `filter_fields`, `filter_fields_translatable`, `filter_mode`, `sorting_fields`, `sorting_fields_translatable`, `visible_for_levels`, `show_total_count`, `override_class_name`, `override_class_file`) VALUES
('bx_stripe_connect_commissions', 'Sql', 'SELECT * FROM `bx_stripe_connect_commissions` WHERE 1 ', 'bx_stripe_connect_commissions', 'id', 'order', 'active', '', 100, NULL, 'start', '', 'name', '', 'auto', '', '', 192, 1, 'BxStripeConnectGridCommissions', 'modules/boonex/stripe_connect/classes/BxStripeConnectGridCommissions.php');

DELETE FROM `sys_grid_fields` WHERE `object`='bx_stripe_connect_commissions';
INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_stripe_connect_commissions', 'order', '', '2%', 0, '0', '', 1),
('bx_stripe_connect_commissions', 'switcher', '', '8%', 0, '0', '', 2),
('bx_stripe_connect_commissions', 'name', '_bx_stripe_connect_grid_column_title_cms_name', '25%', 1, '16', '', 3),
('bx_stripe_connect_commissions', 'acl_id', '_bx_stripe_connect_grid_column_title_cms_acl_id', '25%', 0, '16', '', 4),
('bx_stripe_connect_commissions', 'fee_single', '_bx_stripe_connect_grid_column_title_cms_fee_single', '10%', 0, '0', '', 5),
('bx_stripe_connect_commissions', 'fee_recurring', '_bx_stripe_connect_grid_column_title_cms_fee_recurring', '10%', 0, '0', '', 6),
('bx_stripe_connect_commissions', 'actions', '', '20%', 0, '0', '', 7);

DELETE FROM `sys_grid_actions` WHERE `object`='bx_stripe_connect_commissions';
INSERT INTO `sys_grid_actions` (`object`, `type`, `name`, `title`, `icon`, `icon_only`, `confirm`, `order`) VALUES
('bx_stripe_connect_commissions', 'independent', 'add', '_bx_stripe_connect_grid_action_title_cms_add', '', 0, 0, 1),
('bx_stripe_connect_commissions', 'bulk', 'delete', '_bx_stripe_connect_grid_action_title_cms_delete', '', 0, 1, 1),
('bx_stripe_connect_commissions', 'single', 'edit', '_bx_stripe_connect_grid_action_title_cms_edit', 'pencil-alt', 1, 0, 1),
('bx_stripe_connect_commissions', 'single', 'delete', '_bx_stripe_connect_grid_action_title_cms_delete', 'remove', 1, 1, 2);


-- ALERTS
SET @iHandler := (SELECT `id` FROM `sys_alerts_handlers` WHERE `name`=@sName LIMIT 1);
DELETE FROM `sys_alerts` WHERE `unit`='bx_payment' AND `action` IN ('stripe_get_button', 'stripe_create_customer', 'stripe_retrieve_customer', 'stripe_create_charge', 'stripe_retrieve_charge', 'stripe_create_subscription', 'stripe_v3_get_button', 'stripe_v3_create_session') AND `handler_id`=@iHandler;
INSERT INTO `sys_alerts` (`unit`, `action`, `handler_id`) VALUES
('bx_payment', 'stripe_v3_get_button', @iHandler),
('bx_payment', 'stripe_v3_create_session', @iHandler);
