/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Albums Albums
 * @ingroup     UnaModules
 *
 * @{
 */

Array.prototype.indexOfMediaObject = function (iMediaId) {
    var iLength = this.length;
    for (var i=0 ; i < iLength ; ++i) {
        if (iMediaId == this[i]['media-id'])
            return i;
    }
    return -1;
}

function bx_albums_open_gallery(eve, e, sContext, aItems) {
    
    eve.preventDefault ? eve.preventDefault() : eve.returnValue = false;

    var options = {};

    var fnProcessRetina = function (o) {
        var dpr = ((window.glBxDisableRetina !== undefined && window.glBxDisableRetina) || window.devicePixelRatio === undefined ? 1 : window.devicePixelRatio);
        if (dpr < 2)
            return o;
        o.w *= 2;
        o.h *= 2;
        return o;
    }

    if (!aItems.length) // no images - no concert!
        return false;

    options.dataSource = aItems;
    options.pswpModule = PhotoSwipe;
    options.preload = [1,2];
    options.showHideAnimationType = 'none';

    var lightbox = new PhotoSwipeLightbox(options);
    lightbox.init();

    lightbox.addFilter('numItems', (numItems) => {
        return aItems.length;
    });
    lightbox.addFilter('itemData', (itemData, index) => {
        return aItems[index];
    });
    lightbox.on('close', () => {
        const { pswp }  = lightbox;
        bx_albums_reload_page(pswp.currSlide.data.url, pswp.currSlide.data.alt, true, true);
    });

    lightbox.loadAndOpen(aItems.indexOfMediaObject($(e).attr('data-media-id')));
}

function bx_albums_reload_page(sUrl, sTitle, bChangeHistory, bChangeContent) {

    // if HTML5 history API isn't supported then use href attribute in the link
    if (!(window.history && history.pushState))
        return true; // when onclick returns true, page is reloaded using href attribute

    // reload all blocks on the page using AJAX
    if ('undefined' === typeof(bChangeContent) || bChangeContent) {
        $('.bx-layout-wrapper .bx-page-block-container').each(function () {
            var iId = parseInt($(this).attr('id').replace('bx-page-block-',''));
            if (iId)
                loadDynamicBlock(iId, sUrl);
        });
    }

    if (glBxAlbumsActualUrl == sUrl)
        return false;

    // remember actual url, to not load it twice
    glBxAlbumsActualUrl = sUrl;

    // change history
    if ('undefined' === typeof(bChangeHistory) || bChangeHistory) {
        if ('undefined' === typeof(sTitle))
            sTitle = null;
        History.pushState({title:sTitle, url:sUrl}, sTitle, sUrl);
    }

    return false; // when onclick returns false, href attr isn't used
}

$(document).ready(function () {
    glBxAlbumsActualUrl = location.href;    
    // listen when we press back and forward buttons in browser
    History.Adapter.bind(window, 'statechange', function(event) { 
        var oState = History.getState();        
        if ('undefined' === typeof(oState) || glBxAlbumsActualUrl == oState.url)
            return;

        if ($('.pswp:visible').length && 'undefined' !== typeof(glBxAlbumsGallery)) {
            var a = /id=(\d+)/.exec(document.location);
            if (a && a.length > 0 && a[1]) {
                for (var i in glBxAlbumsGallery.items) {
                    if (glBxAlbumsGallery.items[i]['media-id'] != a[1])
                        continue;
                    glBxAlbumsGallery._bx_albums_skip_history = true;
                    glBxAlbumsGallery.goTo(i);
                    break;
                }
                        
            }
        } else {
            bx_albums_reload_page(oState.url, oState.title, false);
        }
    });
});

/** @} */
