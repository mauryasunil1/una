<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    UnaBaseView UNA Base Representation Classes
 * @{
 */

/**
 * Basic Lucide iconset representation.
 * @see BxDolIconset
 */
class BxBaseIconsetLucide extends BxBaseIconset
{
    protected $_aMap;

    public function __construct ($aObject, $oTemplate)
    {
        parent::__construct ($aObject, $oTemplate);

        $this->_aMap = [
            'ad' => 'circle-star',
            'book-reader' => 'book-open',
            'camera-retro' => 'camera',
            'comment' => 'message-circle',
            'comments' => 'messages-square',
            'donate' => 'hand-coins',
            'ellipsis-v' => 'ellipsis-vertical',
            'fa-book' => 'book-text',
            'fa-smile' => 'smile',
            'fa-thumbs-up' => 'thumbs-up',
            'file-alt' => 'file',
            'file-word' => 'file-text',
            'hashtag' => 'hash',
            'object-group' => 'group',
            'share-alt' => 'share-2',
            'tasks' => 'list-todo',
        ];
    }

    public function getPreloaderJs()
    {
        return 'https://unpkg.com/lucide@latest';
    }

    public function getIcon($sIcon)
    {
        $sIcon = trim(preg_replace('/(sys-icon|far|col-\w+)/i', '', $sIcon));
        if(isset($this->_aMap[$sIcon]))
            $sIcon = $this->_aMap[$sIcon];

        return bx_gen_method_name($sIcon, ['_', '-']);
    }

    public function getCode()
    {
        $sMap = json_encode($this->_aMap);

        $sCode = <<<BLAH
        (function initClassOnlyLucide() {
            if(!window.lucide || !lucide.icons)
                return;
 
            const aMap = $sMap;
 
            document.querySelectorAll('i.sys-icon').forEach(el => {
                if(el.hasAttribute('data-lucide'))
                    return;

                const sName = el.getAttribute('class').replace(/(sys-icon|far|col-\w+)/gi, '').trim().split(' ').shift();
                if(sName)
                  el.setAttribute('data-lucide', aMap[sName] != undefined ? aMap[sName] : sName);
                else
                  console.warn('Lucide: no icon class found on', el);
            });

            lucide.createIcons({
              attrs: { class: ['sys-icon'] },
              nameAttr: 'data-lucide'
            });
        })();
BLAH;

        return $this->_oTemplate->_wrapInTagJsCode($sCode);
    }
}

/** @} */
