<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    CASConnect CAS Connect
 * @ingroup     UnaModules
 *
 * @{
 */

class BxCASTemplate extends BxBaseModConnectTemplate
{
    function __construct(&$oConfig, &$oDb)
    {
        parent::__construct($oConfig, $oDb);
    }
}

/** @} */
