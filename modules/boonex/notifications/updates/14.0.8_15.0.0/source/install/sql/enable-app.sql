-- PAGES: config_api
UPDATE `sys_objects_page` SET `config_api`='{\r\n    layout: \'navigator\',\r\n    blocks: {\r\n        browse: {\r\n            name: \'bx_notifications:get_block_view\',\r\n            showTitle: false,\r\n            showBg: false,\r\n            perLine: 1,\r\n        },\r\n    },\r\n}' WHERE `object`='bx_notifications_view';

-- PAGES: active_api
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_notifications_view' AND `module`='bx_notifications' AND `title_system`='' AND `title`='_bx_ntfs_page_block_title_view';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_notifications_settings' AND `module`='bx_notifications' AND `title_system`='' AND `title`='_bx_ntfs_page_block_title_settings';


-- MENUS:

-- MENUS: config_api

-- MENUS: active_api
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_toolbar_member' AND `module`='bx_notifications' AND `name`='notifications-preview';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_account_settings' AND `module`='bx_notifications' AND `name`='notifications-settings';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_ntfs_submenu' AND `module`='bx_notifications' AND `name`='notifications-view';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_notifications_submenu' AND `module`='bx_notifications' AND `name`='notifications-all';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_notifications_preview' AND `module`='bx_notifications' AND `name`='more';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_notifications_settings' AND `module`='bx_notifications' AND `name`='notifications-site';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_notifications_settings' AND `module`='bx_notifications' AND `name`='notifications-email';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_notifications_settings' AND `module`='bx_notifications' AND `name`='notifications-push';
