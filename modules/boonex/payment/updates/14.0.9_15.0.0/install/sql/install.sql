SET @sName = 'bx_payment';


-- TABLES
UPDATE `bx_payment_providers` SET `active`='0' WHERE `name`='generic';

SET @iProviderId = (SELECT `id` FROM `bx_payment_providers` WHERE `name`='stripe_connect' LIMIT 1);
DELETE FROM `bx_payment_providers` WHERE `id`=@iProviderId;
DELETE FROM `bx_payment_providers_options` WHERE `provider_id`=@iProviderId;

INSERT INTO `bx_payment_providers`(`name`, `caption`, `description`, `option_prefix`, `for_visitor`, `for_single`, `for_recurring`, `active`, `order`, `class_name`) VALUES
('stripe_connect', '_bx_payment_strp_cnnt_cpt', '_bx_payment_strp_cnnt_dsc', 'strp_cnnt_', 1, 1, 1, 1, 65, 'BxPaymentProviderStripeConnect');
SET @iProviderId = LAST_INSERT_ID();

INSERT INTO `bx_payment_providers_options`(`provider_id`, `name`, `type`, `caption`, `description`, `extra`, `check_type`, `check_params`, `check_error`, `order`) VALUES
(@iProviderId, 'strp_cnnt_mode', 'value', '_bx_payment_strp_mode_cpt', '', '', '', '', '', 1),
(@iProviderId, 'strp_cnnt_connect', 'custom', '_bx_payment_strp_cnnt_connect_cpt', '', '', '', '', '', 2),
(@iProviderId, 'strp_cnnt_live_account_id', 'value', '_bx_payment_strp_cnnt_live_account_id_cpt', '', '', '', '', '', 3),
(@iProviderId, 'strp_cnnt_test_account_id', 'value', '_bx_payment_strp_cnnt_test_account_id_cpt', '', '', '', '', '', 4);


-- GRIDS
UPDATE `sys_objects_grid` SET `source`='SELECT * FROM `bx_payment_providers` WHERE 1 ' WHERE `object`='bx_payment_grid_providers';

DELETE FROM `sys_grid_actions` WHERE `object`='bx_payment_grid_cart' AND `name` IN ('quantity_sub', 'quantity_add');
INSERT INTO `sys_grid_actions` (`object`, `type`, `name`, `title`, `icon`, `icon_only`, `confirm`, `order`) VALUES
('bx_payment_grid_cart', 'single', 'quantity_sub', '_bx_payment_grid_action_title_crt_quantity_sub', 'minus', 1, 0, 2),
('bx_payment_grid_cart', 'single', 'quantity_add', '_bx_payment_grid_action_title_crt_quantity_add', 'plus', 1, 0, 3);
