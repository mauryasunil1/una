-- PAGES: config_api
UPDATE `sys_objects_page` SET `config_api`='{\r\n    layout: \'profile\',\r\n    blocks: {\r\n        col00: {\r\n            name: \'system:get_create_post_form\',\r\n            showTitle: false,\r\n            showBg: false,\r\n        },\r\n        col1: {\r\n            name: \'bx_timeline:get_block_view_profile\',\r\n            showTitle: false,\r\n            showBg: false,\r\n            perLine: 1,\r\n        },\r\n        leaderboard2: {\r\n            name: \'bx_reputation:get_block_widget\',\r\n            showTitle: false,\r\n            showBg: true,\r\n            sidebar: true,\r\n        },\r\n        col3: {\r\n            name: \'bx_posts:browse_public\',\r\n            showTitle: false,\r\n            showBg: false,\r\n            sidebar: true,\r\n        },\r\n        col2: {\r\n            name: \'bx_groups:entity_info\',\r\n            showTitle: false,\r\n            showBg: true,\r\n            sidebar: true,\r\n        },\r\n        col4: {\r\n            name: \'bx_groups:entity_text_block\',\r\n            showTitle: false,\r\n            showBg: true,\r\n            sidebar: true,\r\n        },\r\n        col5: {\r\n            name: \'bx_invites:get_block_invite\',\r\n            showTitle: false,\r\n            showBg: true,\r\n            sidebar: true,\r\n        },\r\n    },\r\n    headerSettings: {\r\n        offset: false,\r\n        header: false,\r\n        cover: \'group\'\r\n    },\r\n}' WHERE `object`='bx_groups_view_profile';

-- PAGES: active_api
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_create_profile' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_create_profile';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_view_profile' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_profile_info';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_view_profile' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_profile_description';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_view_profile_closed' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_profile_info';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_view_profile_closed' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_fans';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_edit_profile' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_edit_profile';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_invite' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_invite_to_group';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_delete_profile' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_delete_profile';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_join_profile' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_join_profile';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_profile_info' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_system_profile_info' AND `title`='_bx_groups_page_block_title_profile_info_link';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_profile_info' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_profile_description';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_profile_pricing' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_system_profile_pricing' AND `title`='_bx_groups_page_block_title_profile_pricing_link';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_home' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_featured_profiles';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_home' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_latest_profiles';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_top' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_top_profiles';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_search' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_search_form';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_search' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_search_results';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_context' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_sys_entries_in_context' AND `title`='_bx_groups_page_block_title_entries_in_context_link';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_joined_groups' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_joined_entries';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_manage' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_system_manage' AND `title`='_bx_groups_page_block_title_manage';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_administration' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_system_manage_administration' AND `title`='_bx_groups_page_block_title_manage';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_joined' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_sys_entries_actions' AND `title`='_bx_groups_page_block_title_entries_actions';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_joined' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_sys_entries_of_author' AND `title`='_bx_groups_page_block_title_entries_of_author';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_joined' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_sys_favorites_of_author' AND `title`='_bx_groups_page_block_title_favorites_of_author';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_joined' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_sys_joined_entries' AND `title`='_bx_groups_page_block_title_joined_entries';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_favorites' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_sys_favorites_entries' AND `title`='_bx_groups_page_block_title_favorites_entries';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_favorites' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_favorites_entries_info';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_favorites' AND `module`='bx_groups' AND `title_system`='' AND `title`='_bx_groups_page_block_title_favorites_entries_actions';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_view_profile' AND `module`='system' AND `title_system`='_sys_page_block_title_sys_create_post_context' AND `title`='_sys_page_block_title_create_post_context';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_view_profile' AND `module`='bx_timeline' AND `title_system`='_bx_timeline_page_block_title_system_view_profile' AND `title`='_bx_timeline_page_block_title_view_profile';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_fans' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_system_fans' AND `title`='_bx_groups_page_block_title_fans_link';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_groups_manage_item' AND `module`='bx_groups' AND `title_system`='_bx_groups_page_block_title_system_fans_manage' AND `title`='_bx_groups_page_block_title_fans_link';


-- MENUS:

-- MENUS: config_api

-- MENUS: active_api
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_site' AND `module`='bx_groups' AND `name`='groups-home';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_homepage' AND `module`='bx_groups' AND `name`='groups-home';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_add_content_links' AND `module`='bx_groups' AND `name`='create-group-profile';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_profile_stats' AND `module`='bx_groups' AND `name`='profile-stats-my-groups';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_profile_followings' AND `module`='bx_groups' AND `name`='groups';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_account_dashboard_manage_tools' AND `module`='bx_groups' AND `name`='groups-administration';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions' AND `module`='bx_groups' AND `name`='join-group-profile';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions' AND `module`='bx_groups' AND `name`='profile-fan-add';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions' AND `module`='bx_groups' AND `name`='profile-subscribe-add';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions' AND `module`='bx_groups' AND `name`='profile-set-badges';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions' AND `module`='bx_groups' AND `name`='profile-actions-more';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_more' AND `module`='bx_groups' AND `name`='edit-group-profile';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_more' AND `module`='bx_groups' AND `name`='invite-to-group';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_more' AND `module`='bx_groups' AND `name`='delete-group-profile';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_all' AND `module`='bx_groups' AND `name`='join-group-profile';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_all' AND `module`='bx_groups' AND `name`='profile-fan-add';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_all' AND `module`='bx_groups' AND `name`='profile-fan-remove';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_all' AND `module`='bx_groups' AND `name`='profile-subscribe-add';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_all' AND `module`='bx_groups' AND `name`='profile-subscribe-remove';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_actions_all' AND `module`='bx_groups' AND `name`='report';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_meta' AND `module`='bx_groups' AND `name`='members';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_meta' AND `module`='bx_groups' AND `name`='views';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_meta' AND `module`='bx_groups' AND `name`='votes';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_meta' AND `module`='bx_groups' AND `name`='comments';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_my' AND `module`='bx_groups' AND `name`='create-group-profile';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_submenu' AND `module`='bx_groups' AND `name`='groups-home';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_submenu' AND `module`='bx_groups' AND `name`='groups-top';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_submenu' AND `module`='bx_groups' AND `name`='groups-search';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_submenu' AND `module`='bx_groups' AND `name`='groups-joined';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_submenu' AND `module`='bx_groups' AND `name`='groups-manage';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_submenu' AND `module`='bx_groups' AND `name`='view-group-profile';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_view_submenu' AND `module`='bx_groups' AND `name`='group-fans';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_snippet_meta' AND `module`='bx_groups' AND `name`='join-paid';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_snippet_meta' AND `module`='bx_groups' AND `name`='join';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_snippet_meta' AND `module`='bx_groups' AND `name`='leave';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_snippet_meta' AND `module`='bx_groups' AND `name`='subscribe';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_snippet_meta' AND `module`='bx_groups' AND `name`='unsubscribe';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_menu_manage_tools' AND `module`='bx_groups' AND `name`='clear-reports';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_groups_menu_manage_tools' AND `module`='bx_groups' AND `name`='delete';
