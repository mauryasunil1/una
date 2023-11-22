<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Ads Ads
 * @ingroup     UnaModules
 *
 * @{
 */

/*
 * Module representation.
 */
class BxAdsTemplate extends BxBaseModTextTemplate
{
    function __construct(&$oConfig, &$oDb)
    {
        $this->MODULE = 'bx_ads';

        parent::__construct($oConfig, $oDb);

        $this->aMethodsToCallAddJsCss[] = 'categories';
    }

    public function entryOfferAccepted($iUserId, $aContent, $aOffer)
    {
        $CNF = &$this->_oConfig->CNF;

        $oPayments = BxDolPayments::getInstance();
        $iContentAuthorId = (int)$aContent[$CNF['FIELD_AUTHOR']];

        $sJsCodePay = $sJsMethodPay = '';
        $aJsPay = $oPayments->getAddToCartJs($iContentAuthorId, $this->MODULE, $aContent[$CNF['FIELD_ID']], $aOffer[$CNF['FIELD_OFR_QUANTITY']], true);
        if(!empty($aJsPay) && is_array($aJsPay))
            list($sJsCodePay, $sJsMethodPay) = $aJsPay;

        return $this->parseHtmlByName('entry-offer-accepted.html', array(
            'js_object' => $this->_oConfig->getJsObject('entry'),
            'id' => $aOffer['id'],
            'amount' => _t_format_currency_ext($aOffer['amount'], [
                'sign' => $oPayments->getCurrencySign($iContentAuthorId)
            ]),
            'quantity' => _t('_bx_ads_txt_n_items', $aOffer['quantity']),
            'bx_if:show_pay' => array(
                'condition' => !empty($sJsMethodPay),
                'content' => array(
                    'js_method_pay' => $sJsMethodPay,
                )
            ),
            'js_code' => $sJsCodePay
        ));
    }

    public function entryBreadcrumb($aContentInfo, $aTmplVarsItems = array())
    {
    	$CNF = &$this->_oConfig->CNF;

        $oPermalink = BxDolPermalinks::getInstance();

        $aTmplVarsItems = array();
        $this->_entryBreadcrumb($aContentInfo[$CNF['FIELD_CATEGORY']], $oPermalink, $aTmplVarsItems);
        $aTmplVarsItems = array_reverse($aTmplVarsItems);
        
        $aTmplVarsItems[] = array(
            'url' => bx_absolute_url($oPermalink->permalink('page.php?i=' . $CNF['URI_VIEW_ENTRY'] . '&id=' . $aContentInfo[$CNF['FIELD_ID']])),
            'title' => bx_process_output($aContentInfo[$CNF['FIELD_TITLE']])
        );

    	return parent::entryBreadcrumb($aContentInfo, $aTmplVarsItems);
    }

    public function categoriesList($aParams = array())
    {
        $CNF = &$this->_oConfig->CNF;

        $sResult = $this->_categoriesList(0, array(
            'url' => bx_absolute_url(BxDolPermalinks::getInstance()->permalink($CNF['URL_CATEGORIES'], array('category' => '')))
        ));

        if(empty($sResult) && isset($aParams['show_empty']) && $aParams['show_empty'] === true)
            $sResult = MsgBox(_t('_Empty'));

        return $sResult;
    }

    public function getEntryLink($aEntry)
    {
        $CNF = &$this->_oConfig->CNF;

        return $this->getLink('entry-link', array(
            'href' => bx_absolute_url(BxDolPermalinks::getInstance()->permalink('page.php?i=' . $CNF['URI_VIEW_ENTRY'], array(
                'id' => $aEntry[$CNF['FIELD_ID']]
            ))),
            'title' => bx_html_attribute($aEntry[$CNF['FIELD_TITLE']]),
            'content' => $aEntry[$CNF['FIELD_TITLE']]
        ));
    }

    protected function getUnit($aData, $aParams = [])
    {
        $CNF = &$this->_oConfig->CNF;

        $aResult = parent::getUnit($aData, $aParams);

        if($this->_oConfig->isPromotion()) {
            $sJsObject = $this->_oConfig->getJsObject('main');

            $aResult = array_merge($aResult, [
                'content_url' => 'javascript:void(0)',
                'bx_if:show_onclick' => [
                    'condition' => true,
                    'content' => [
                        'content_onclick' => 'return ' . $sJsObject . '.registerClick(this, ' . $aData[$CNF['FIELD_ID']] . ')'
                    ]
                ],
                'bx_if:show_tracker' => [
                    'condition' => true,
                    'content' => [
                        'js_object' => $sJsObject,
                        'id' => $aData[$CNF['FIELD_ID']]
                    ]
                ],
            ]);
        }
        return $aResult;
    }

    /**
     * Use Gallery image for both because currently there is no Unit types with small thumbnails.
     */
    protected function getUnitThumbAndGallery ($aData)
    {
        list($sPhotoThumb, $sPhotoGallery) = parent::getUnitThumbAndGallery($aData);

        return array($sPhotoGallery, $sPhotoGallery);
    }

    protected function _categoriesList($iParentId, $aParams = array())
    {
        $aCategories = $this->_oDb->getCategories(array('type' => 'parent_id', 'parent_id' => $iParentId));

        $aTmplVars = array();
        foreach($aCategories as $aCategory) {
            $iItems = (int)$aCategory['items'];

            $sSibcategories = $this->_categoriesList($aCategory['id'], $aParams);
            if($iItems == 0 && empty($sSibcategories))
                continue;

            $aTmplVars[] = array(
                'url' => $aParams['url'] . $aCategory['id'],
                'title' => _t($aCategory['title']),
                'bx_if:show_icon' => array(
                    'condition' => !empty($aCategory['icon']),
                    'content' => array(
                        'icon' => $aCategory['icon'],
                    )
                ),
                'bx_if:show_counter' => array(
                    'condition' => $iItems != 0,
                    'content' => array(
                        'items' => $iItems,
                    )
                ),
                'bx_if:show_subcategories' => array(
                    'condition' => !empty($sSibcategories),
                    'content' => array(
                        'subcategories' => $sSibcategories
                    )
                )
            );
        }

        if(empty($aTmplVars))
            return '';

        return $this->parseHtmlByName('categories.html', array(
            'bx_repeat:categories' => $aTmplVars
        ));
    }

    protected function _entryBreadcrumb($iCategory, &$oPermalink, &$aTmplVarsItems)
    {
        $CNF = &$this->_oConfig->CNF;

        $aCategory = $this->_oDb->getCategories(array('type' => 'id', 'id' => $iCategory));
        if(empty($aCategory) || !is_array($aCategory))
            return;

        $aTmplVarsItems[] = array(
            'url' => bx_absolute_url($oPermalink->permalink($CNF['URL_CATEGORIES'], array($CNF['GET_PARAM_CATEGORY'] => $aCategory['id']))),
            'title' => bx_process_output(_t($aCategory['title']))
        );

        if(empty($aCategory['parent_id']))
            return;

        $this->_entryBreadcrumb((int)$aCategory['parent_id'], $oPermalink, $aTmplVarsItems);
    }
}

/** @} */
