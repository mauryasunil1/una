<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Spaces Spaces
 * @ingroup     UnaModules
 *
 * @{
 */

class BxSpacesMenuAddContent extends BxBaseModGroupsAddContent
{    
    public function __construct($aObject, $oTemplate = false)
    {
        $this->_sModule = 'bx_spaces';

        parent::__construct($aObject, $oTemplate);
    }
}

/** @} */
