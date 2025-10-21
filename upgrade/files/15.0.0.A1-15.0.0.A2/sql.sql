
SET @sStorageEngine = (SELECT `value` FROM `sys_options` WHERE `name` = 'sys_storage_default');

-- Options

UPDATE sys_options SET `type` = 'select', `extra` = 'a:3:{s:6:"module";s:6:"system";s:6:"method";s:27:"get_options_iconset_default";s:5:"class";s:13:"TemplServices";}' WHERE `name` = 'sys_iconset_default';

DELETE FROM `sys_options` WHERE `name` = 'site_description';

SET @iCategoryId = (SELECT `id` FROM `sys_options_categories` WHERE `name` = 'site_settings');
INSERT IGNORE INTO `sys_options`(`category_id`, `name`, `caption`, `info`, `value`, `type`, `extra`, `check`, `check_error`, `order`) VALUES
(@iCategoryId, 'sys_per_page_browse_showcase', '_adm_stg_cpt_option_sys_per_page_browse_showcase', '_adm_stg_inf_option_sys_per_page_browse_showcase', '32', 'digit', '', '', '', 24);

-- Menu

DELETE FROM `sys_menu_templates` WHERE `id` IN(33, 34);
INSERT INTO `sys_menu_templates` (`id`, `template`, `title`, `visible`) VALUES
(33, 'menu_toolbar_left.html', '_sys_menu_template_title_toolbar_left', 0),
(34, 'menu_toolbar_right.html', '_sys_menu_template_title_toolbar_right', 0);

UPDATE `sys_objects_menu` SET `template_id` = 33 WHERE `object` = 'sys_toolbar_site' AND `template_id` = 5;
UPDATE `sys_objects_menu` SET `template_id` = 34 WHERE `object` = 'sys_toolbar_member' AND `template_id` = 5;

UPDATE `sys_menu_items` SET `link` = '{own_profile_url}' WHERE `set_name` = 'sys_account_notifications' AND `name` = 'profile';

-- Rewrite

DELETE FROM `sys_rewrite_rules` WHERE `preg` = '^home/?$';
INSERT INTO `sys_rewrite_rules` (`preg`, `service`, `active`) VALUES
('^home/?$', 'a:3:{s:6:\"module\";s:6:\"system\";s:6:\"method\";s:13:\"home_redirect\";s:6:\"params\";a:0:{}}', 1);

-- Preloader

UPDATE `sys_preloader` SET `content` = 'htmx/head-support.min.js' WHERE `content` = 'htmx/head-support.js';
UPDATE `sys_preloader` SET `content` = 'htmx/preload.min.js' WHERE `content` = 'htmx/preload.js';

-- Last step is to update current version

UPDATE `sys_modules` SET `version` = '15.0.0-A2' WHERE (`version` = '15.0.0.A1' OR `version` = '15.0.0-A1') AND `name` = 'system';

