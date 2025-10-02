<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

$aConfig = array(
    /**
     * Main Section.
     */
    'title' => 'English',
    'version_from' => '14.0.9',
    'version_to' => '15.0.0',
    'vendor' => 'UNA INC',

    'compatible_with' => array(
        '15.0.0-A1'
    ),

    /**
     * 'home_dir' and 'home_uri' - should be unique. Don't use spaces in 'home_uri' and the other special chars.
     */
    'home_dir' => 'boonex/english/updates/update_14.0.9_15.0.0/',
    'home_uri' => 'en_update_1409_1500',

    'module_dir' => 'boonex/english/',
    'module_uri' => 'en',

    'db_prefix' => 'bx_eng_',
    'class_prefix' => 'BxEng',

    /**
     * Installation/Uninstallation Section.
     */
    'install' => array(
        'execute_sql' => 1,
        'update_files' => 1,
        'update_languages' => 1,
        'restore_languages' => 1,
        'clear_db_cache' => 1,
    ),

    /**
     * Category for language keys.
     */
    'language_category' => 'System',

    /**
     * Files Section
     */
    'delete_files' => array(),
);
