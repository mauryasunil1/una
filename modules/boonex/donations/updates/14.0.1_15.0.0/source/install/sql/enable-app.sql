-- PAGES: config_api
UPDATE `sys_objects_page` SET `config_api`='{\r\n    layout: \'navigator\',\r\n    blocks: {\r\n        footer: {\r\n            name: \'static:dummy\',\r\n            showTitle: false,\r\n            showBg: false,\r\n            leftbar: true,\r\n        }\r\n    },\r\n    icon: \'MagnifyingGlass\',\r\n    headerSettings: {\r\n        backButton: false,\r\n        header: true,\r\n        menu: true\r\n    },\r\n}' WHERE `object`='bx_donations_make';

-- PAGES: active_api
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_donations_make' AND `module`='bx_donations' AND `title_system`='_bx_donations_page_block_title_system_make' AND `title`='_bx_donations_page_block_title_make';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_donations_list' AND `module`='bx_donations' AND `title_system`='' AND `title`='_bx_donations_page_block_title_list';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_donations_list_all' AND `module`='bx_donations' AND `title_system`='' AND `title`='_bx_donations_page_block_title_list_all';


-- MENUS:

-- MENUS: config_api

-- MENUS: active_api
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_donations_list_submenu' AND `module`='bx_donations' AND `name`='donations-list-all';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_donations_list_submenu' AND `module`='bx_donations' AND `name`='donations-list';
