<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

$aConfig = array(
    /**
     * Main Section.
     */
    'title' => 'Spaces',
    'version_from' => '14.0.5',
    'version_to' => '15.0.0',
    'vendor' => 'UNA INC',

    'compatible_with' => array(
        '15.0.0-A1'
    ),

    /**
     * 'home_dir' and 'home_uri' - should be unique. Don't use spaces in 'home_uri' and the other special chars.
     */
    'home_dir' => 'boonex/spaces/updates/update_14.0.5_15.0.0/',
    'home_uri' => 'spaces_update_1405_1500',

    'module_dir' => 'boonex/spaces/',
    'module_uri' => 'spaces',

    'db_prefix' => 'bx_spaces_',
    'class_prefix' => 'BxSpaces',

    /**
     * Installation/Uninstallation Section.
     */
    'install' => array(
        'execute_sql' => 1,
        'update_files' => 1,
        'update_languages' => 1,
        'clear_db_cache' => 1,
    ),

    /**
     * Category for language keys.
     */
    'language_category' => 'Spaces',

    /**
     * Files Section
     */
    'delete_files' => array(),
);
