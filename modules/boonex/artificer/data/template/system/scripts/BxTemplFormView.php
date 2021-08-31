<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    UnaTemplate UNA Template Classes
 * @{
 */

class BxTemplFormView extends BxBaseFormView
{
    function __construct($aInfo, $oTemplate = false)
    {
        parent::__construct($aInfo, $oTemplate);
    }

    protected function _genInputStandardAttrs(&$aInput)
    {
        $aAttrs = parent::_genInputStandardAttrs($aInput);
        if(in_array($aInput['type'], ['hidden']))
            return $aAttrs;

        return $this->_updateInputAttrs($aAttrs);
    }

    protected function _genInputSelectAttrs(&$aInput, $isMultiple)
    {
        $aAttrs = parent::_genInputSelectAttrs($aInput, $isMultiple);
        return $this->_updateInputAttrs($aAttrs);
    }

    protected function _genInputTextareaAttrs(&$aInput)
    {
        $aAttrs = parent::_genInputTextareaAttrs($aInput);
        return $this->_updateInputAttrs($aAttrs);
    }

    protected function _genInputButtonAttrs(&$aInput)
    {
        $aAttrs = parent::_genInputButtonAttrs($aInput);
        
        if(!isset($aAttrs['class']))
            $aAttrs['class'] = '';

        $aAttrs['class'] .= ' group block px-4 py-2 bg-white ring-1 ring-gray-200 dark:ring-gray-800 dark:bg-gray-900 dark:hover:bg-gray-700 shadow-sm text-gray-900 dark:text-white flex items-center text-sm font-normal rounded';

        return $aAttrs;
    }

    protected function _genCustomInputUsernamesSuggestionsAttrs (&$aInput, $bDisabled = false)
    {
        $aAttrs = parent::_genCustomInputUsernamesSuggestionsAttrs($aInput, $bDisabled);

        $aAttrs = $this->_updateInputAttrs($aAttrs);
        $aAttrs['class'] .= ' flex flex-wrap items-stretch';

        return $aAttrs;
    }

    protected function _genCustomInputUsernamesSuggestionsTextAttrs (&$aInput, $bDisabled = false)
    {
        $aAttrs = parent::_genCustomInputUsernamesSuggestionsTextAttrs($aInput, $bDisabled);

        if(!isset($aAttrs['class']))
            $aAttrs['class'] = '';

        $aAttrs['class'] .= ' leading-10';

        return $aAttrs;
    }

    protected function _updateInputAttrs(&$aAttrs)
    {
        if(!isset($aAttrs['class']))
            $aAttrs['class'] = '';

        $aAttrs['class'] .= ' block w-full px-3 py-1.5 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-gray-700 rounded leading-5 bg-white dark:bg-gray-900 placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-2 focus:text-gray-900 dark:focus:text-gray-100 focus:ring-blue-500 focus:border-opacity-70 focus:ring-opacity-20 focus:border-blue-500 text-sm';

        return $aAttrs;
    }
}

/** @} */
