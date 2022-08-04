<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

$aConfig = array(
    /**
     * Main Section.
     */
    'title' => 'Videos',
    'version_from' => '13.0.3',
    'version_to' => '13.0.4',
    'vendor' => 'BoonEx',

    'compatible_with' => array(
        '13.0.0-B3'
    ),

    /**
     * 'home_dir' and 'home_uri' - should be unique. Don't use spaces in 'home_uri' and the other special chars.
     */
    'home_dir' => 'boonex/videos/updates/update_13.0.3_13.0.4/',
    'home_uri' => 'videos_update_1303_1304',

    'module_dir' => 'boonex/videos/',
    'module_uri' => 'videos',

    'db_prefix' => 'bx_videos_',
    'class_prefix' => 'BxVideos',

    /**
     * Installation/Uninstallation Section.
     */
    'install' => array(
        'execute_sql' => 0,
        'update_files' => 1,
        'update_languages' => 0,
        'clear_db_cache' => 0,
    ),

    /**
     * Category for language keys.
     */
    'language_category' => 'Videos',

    /**
     * Files Section
     */
    'delete_files' => array(),
);
