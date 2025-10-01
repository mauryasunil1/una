<?php
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 */

$aConfig = array(
    /**
     * Main Section.
     */
    'title' => 'Quote of the Day',
    'version_from' => '13.0.1',
    'version_to' => '15.0.0',
    'vendor' => 'UNA INC',

    'compatible_with' => array(
        '15.0.0-A1'
    ),

    /**
     * 'home_dir' and 'home_uri' - should be unique. Don't use spaces in 'home_uri' and the other special chars.
     */
    'home_dir' => 'boonex/quoteofday/updates/update_13.0.1_15.0.0/',
    'home_uri' => 'quoteofday_update_1301_1500',

    'module_dir' => 'boonex/quoteofday/',
    'module_uri' => 'quoteofday',

    'db_prefix' => 'bx_quoteofday_',
    'class_prefix' => 'BxQuoteOfDay',

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
    'language_category' => 'Quote Of Day',

    /**
     * Files Section
     */
    'delete_files' => array(),
);
