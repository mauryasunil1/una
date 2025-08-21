--
-- NEO APP: blocks
---

UPDATE `sys_pages_blocks` SET `active_api` = 1 WHERE `object` = 'sys_about' AND `title` IN('_sys_page_block_title_about');
UPDATE `sys_pages_blocks` SET `active_api` = 1 WHERE `object` = 'sys_terms' AND `title` IN('_sys_page_block_title_terms');
UPDATE `sys_pages_blocks` SET `active_api` = 1 WHERE `object` = 'sys_privacy' AND `title` IN('_sys_page_block_title_privacy');
UPDATE `sys_pages_blocks` SET `active_api` = 1 WHERE `object` = 'sys_login' AND `title` IN('_sys_page_block_system_title_login');
