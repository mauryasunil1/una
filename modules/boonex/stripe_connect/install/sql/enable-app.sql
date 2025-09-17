-- PAGES: config_api


-- PAGES: active_api
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_stripe_connect_activity' AND `module`='bx_stripe_connect' AND `title_system`='' AND `title`='_bx_stripe_connect_page_block_title_payments';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_stripe_connect_activity' AND `module`='bx_stripe_connect' AND `title_system`='' AND `title`='_bx_stripe_connect_page_block_title_balances';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_stripe_connect_activity' AND `module`='bx_stripe_connect' AND `title_system`='' AND `title`='_bx_stripe_connect_page_block_title_notifications';
