<?php

    if (!$this->oDb->isFieldExists('sys_sessions', 'ttl'))
        $this->oDb->query("ALTER TABLE `sys_sessions` ADD `ttl` int(10) unsigned NOT NULL default '0' AFTER `date`");

    if (!$this->oDb->isIndexExists('sys_sessions', 'ttl') && $this->oDb->isFieldExists('sys_sessions', 'ttl'))
        $this->oDb->query("ALTER TABLE `sys_sessions` ADD KEY `ttl` (`ttl`)");


    if (!$this->oDb->isFieldExists('sys_accounts', 'picture'))
        $this->oDb->query("ALTER TABLE `sys_accounts` ADD `picture` int(11) NOT NULL DEFAULT '0' AFTER `name`");


    if (!$this->oDb->isFieldExists('sys_objects_menu', 'title_public')) {
        $this->oDb->query("ALTER TABLE `sys_objects_menu` ADD `title_public` varchar(255) NOT NULL AFTER `title`");

        $this->oDb->query("UPDATE `sys_objects_menu` SET `title_public` = '_sys_menu_title_public_homepage_submenu' WHERE `object` = 'sys_homepage_submenu'");

        $this->oDb->query("UPDATE `sys_objects_menu` SET `title_public` = '_sys_menu_title_public_account_dashboard' WHERE `object` = 'sys_account_dashboard'");

        $this->oDb->query("UPDATE `sys_objects_menu` SET `title_public` = '_sys_menu_title_public_account_settings' WHERE `object` = 'sys_account_settings_submenu'");

        $this->oDb->query("UPDATE `sys_objects_menu` SET `title_public` = '_sys_menu_title_public_con_submenu' WHERE `object` = 'sys_con_submenu'");

        $this->oDb->query("UPDATE `sys_objects_menu` SET `set_name` = 'sys_create_post' WHERE `object` = 'sys_create_post' AND `set_name` = 'sys_add_content_links'");

        $this->oDb->query("INSERT IGNORE INTO `sys_objects_menu` (`object`, `title`, `title_public`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES ('sys_ntfs_submenu', '_sys_menu_title_ntfs_submenu', '', 'sys_ntfs_submenu', 'system', 8, 0, 1, 'BxTemplMenuSubmenuWithAddons', '')");
    }

    if (!$this->oDb->isFieldExists('sys_objects_menu', 'cache')) {
        $this->oDb->query("ALTER TABLE `sys_objects_menu` ADD `cache` enum('off','guest','global','per_user','per_acl') NOT NULL DEFAULT 'off' AFTER `persistent`");

        $this->oDb->query("UPDATE `sys_objects_menu` SET `cache` = 'per_acl' WHERE `object` IN('sys_site', 'sys_account_notifications', 'sys_add_content', 'sys_toolbar_site', 'sys_footer', 'sys_site_submenu', 'sys_homepage_submenu', 'sys_homepage', 'sys_application', 'sys_site_in_panel')");
        $this->oDb->query("UPDATE `sys_objects_menu` SET `cache` = 'per_user' WHERE `object` IN('sys_toolbar_member', 'sys_profile_stats')");
    }


    if (!$this->oDb->isFieldExists('sys_menu_items', 'title_attr')) {
        $this->oDb->query("ALTER TABLE `sys_menu_items` ADD `title_attr` varchar(255) NOT NULL DEFAULT '' AFTER `title`");
    }

    if (!$this->oDb->isFieldExists('sys_menu_items', 'info')) {
        $this->oDb->query("ALTER TABLE `sys_menu_items` ADD `info` varchar(255) NOT NULL DEFAULT '' AFTER `title_attr`");
    }

    if (!$this->oDb->isFieldExists('sys_menu_items', 'area_label')) {
        $this->oDb->query("ALTER TABLE `sys_menu_items` ADD `area_label` varchar(255) NOT NULL DEFAULT '' AFTER `target`");
    }

    if (!$this->oDb->isFieldExists('sys_menu_items', 'icon_only')) {
        $this->oDb->query("ALTER TABLE `sys_menu_items` ADD `icon_only` tinyint(4) NOT NULL DEFAULT '0' AFTER `icon`");
    }

    if (!$this->oDb->isFieldExists('sys_menu_items', 'persistent')) {
        $this->oDb->query("ALTER TABLE `sys_menu_items` ADD `persistent` tinyint(4) NOT NULL DEFAULT '0' AFTER `collapsed`");
    }


    if (!$this->oDb->isFieldExists('sys_objects_connection', 'tt_initiator')) {
        $this->oDb->query("ALTER TABLE `sys_objects_connection` ADD `tt_initiator` varchar(32) NOT NULL DEFAULT '' AFTER `type`");
    }

    if (!$this->oDb->isFieldExists('sys_objects_connection', 'tf_id_initiator')) {
        $this->oDb->query("ALTER TABLE `sys_objects_connection` ADD `tf_id_initiator` varchar(32) NOT NULL DEFAULT '' AFTER `tt_initiator`");
    }

    if (!$this->oDb->isFieldExists('sys_objects_connection', 'tf_count_initiator')) {
        $this->oDb->query("ALTER TABLE `sys_objects_connection` ADD `tf_count_initiator` varchar(32) NOT NULL DEFAULT '' AFTER `tf_id_initiator`");
    }

    if (!$this->oDb->isFieldExists('sys_objects_connection', 'tt_content')) {
        $this->oDb->query("ALTER TABLE `sys_objects_connection` ADD `tt_content` varchar(32) NOT NULL DEFAULT '' AFTER `tf_count_initiator`");
    }

    if (!$this->oDb->isFieldExists('sys_objects_connection', 'tf_id_content')) {
        $this->oDb->query("ALTER TABLE `sys_objects_connection` ADD `tf_id_content` varchar(32) NOT NULL DEFAULT '' AFTER `tt_content`");
    }

    if (!$this->oDb->isFieldExists('sys_objects_connection', 'tf_count_content')) {
        $this->oDb->query("ALTER TABLE `sys_objects_connection` ADD `tf_count_content` varchar(32) NOT NULL DEFAULT '' AFTER `tf_id_content`");
    }


    if (!$this->oDb->isFieldExists('sys_categories', 'icon_type')) {
        $this->oDb->query("ALTER TABLE `sys_categories` ADD `icon_type` varchar(8) NOT NULL DEFAULT '' AFTER `value`");
    }

    if (!$this->oDb->isFieldExists('sys_categories', 'icon')) {
        $this->oDb->query("ALTER TABLE `sys_categories` ADD `icon` text NOT NULL AFTER `icon_type`");
    }

    return true;
