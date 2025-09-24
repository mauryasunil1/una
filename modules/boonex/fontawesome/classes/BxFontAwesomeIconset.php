<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    FontAwesome Font Awesome Pro integration
 * @ingroup     UnaModules
 *
 * @{
 */

/**
 * Basic Font Awesome Pro iconset representation.
 * @see BxDolIconset
 */
class BxFontAwesomeIconset extends BxBaseIconset
{
    public function __construct ($aObject, $oTemplate)
    {
        parent::__construct ($aObject, $oTemplate);
    }

    public function getPreloaderCss()
    {
        return 'modules/boonex/fontawesome/template/css/|icons.css';
    }
}

/** @} */
