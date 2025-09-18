-- PAGES: config_api


-- PAGES: active_api
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_create_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_create_entry';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_edit_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_edit_entry';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_delete_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_delete_entry';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_prev_entry';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_text';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_all_actions';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_next_entry';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_attachments';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_comments';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='_bx_classes_page_block_title_sys_entry_context' AND `title`='_bx_classes_page_block_title_entry_context';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_info';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_location';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_polls';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_students_completed_class';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_students_not_completed_class';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry' AND `module`='bx_classes' AND `title_system`='' AND `title`='_bx_classes_page_block_title_entry_reports';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_view_entry_comments' AND `module`='bx_classes' AND `title_system`='_bx_classes_page_block_title_entry_comments' AND `title`='_bx_classes_page_block_title_entry_comments_link';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_context' AND `module`='bx_classes' AND `title_system`='_bx_classes_page_block_title_sys_entries_in_context' AND `title`='_bx_classes_page_block_title_entries_in_context';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_manage' AND `module`='bx_classes' AND `title_system`='_bx_classes_page_block_title_system_manage' AND `title`='_bx_classes_page_block_title_manage';
UPDATE `sys_pages_blocks` SET `active_api`=1 WHERE `object`='bx_classes_administration' AND `module`='bx_classes' AND `title_system`='_bx_classes_page_block_title_system_manage_administration' AND `title`='_bx_classes_page_block_title_manage';


-- MENUS:

-- MENUS: config_api

-- MENUS: active_api
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='sys_profile_stats' AND `module`='bx_classes' AND `name`='profile-stats-manage-classes';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_entry_attachments' AND `module`='bx_classes' AND `name`='photo_html5';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_entry_attachments' AND `module`='bx_classes' AND `name`='video_html5';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_entry_attachments' AND `module`='bx_classes' AND `name`='video_record_video';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_entry_attachments' AND `module`='bx_classes' AND `name`='sound_html5';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_entry_attachments' AND `module`='bx_classes' AND `name`='file_html5';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_entry_attachments' AND `module`='bx_classes' AND `name`='poll';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_entry_attachments' AND `module`='bx_classes' AND `name`='add-link';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view' AND `module`='bx_classes' AND `name`='complete-class';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view' AND `module`='bx_classes' AND `name`='edit-class';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view' AND `module`='bx_classes' AND `name`='delete-class';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view' AND `module`='bx_classes' AND `name`='approve';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='complete-class';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='edit-class';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='delete-class';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='approve';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='set-badges';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='view';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='reaction';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='score';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='favorite';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='feature';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='repost';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='report';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='notes';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='audit';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='social-sharing';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_view_actions' AND `module`='bx_classes' AND `name`='more-auto';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_snippet_meta' AND `module`='bx_classes' AND `name`='date';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_snippet_meta' AND `module`='bx_classes' AND `name`='date-start';
UPDATE `sys_menu_items` SET `active_api`=1 WHERE `set_name`='bx_classes_snippet_meta' AND `module`='bx_classes' AND `name`='date-end';
