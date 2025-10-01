/**
 * Copyright (c) UNA, Inc - https://una.io
 * MIT License - https://opensource.org/licenses/MIT
 *
 * @defgroup    Charts Charts
 * @ingroup     UnaModules
 *
 * @{
 */

function BxCharts(oOptions) {
    this._sObjName = undefined == oOptions.sObjName ? 'oCharts' : oOptions.sObjName;    // javascript object name, to run current object instance from onTimer
    this._sChartName = oOptions.sChartName == undefined ? '' : oOptions.sChartName;
    this._sActionsUri = oOptions.sActionUri;
    this._sKeyGraph = 'bx_chart_growth_graph_' + this._sChartName;
    this._oChartOptionsDefault = { layout: { 
        autoPadding: true, 
        padding: {
            left: 40,
            right: 40,
            top: 40,
            bottom: 20
        }
    }};
    var $this = this;
    $(document).ready(function () {
        $this.loadData();
    });
}

BxCharts.prototype.loadData = function () {
    var $this = this;
    var oGraph = $('.' + this._sKeyGraph);
    var oGraphWrp = oGraph.parents('div:first');
    var oGraphErr = oGraphWrp.find('.bx-chart-growth-graph-error').hide();
    var sAdditionalParameters = "";
    if ($('.bx_chart_growth_selector_' + this._sChartName).length > 0) {
        sAdditionalParameters = '?m=' + $('.bx_chart_growth_selector_' + this._sChartName).val();
        $('.bx_chart_growth_selector_' + this._sChartName).off().change(function () {
            $this.loadData();
        });
    }

    bx_loading(oGraphWrp, true);

    $.get(
    	this._sActionsUri + 'get_chart_data/' + $this._sChartName + '/' + sAdditionalParameters +'',
    	{
    	},
    	function (oData) {
    	    bx_loading(oGraphWrp, false);

    	    if (oData.error != undefined) {
    	        if ($this._oChart)
    	            $this._oChart.destroy();

    	        oGraphErr.html(oData.error).show();
    	        return;
    	    }

    	    if (oData.links) {
    	        oData.options.plugins.legend.onClick = function (e, legendItem, legend) {
                    if (legendItem.index != undefined)
                        window.open(oData.links[legendItem.index], '_blank');
    	        };
    	    }

    	    var oDataForChart = oData.data || false;
    	    var oChartOptions = oData.options || {};
    	    if ($this._oChart)
    	        $this._oChart.destroy();
    	   
    	    $this._oChart = new Chart(oGraph, {
    	        type: oData.type != undefined ? oData.type : 'line',
    	        data: oDataForChart,
    	        options: $.extend({}, $this._oChartOptionsDefault, oChartOptions)
    	    });

    	    if (oData.links) {
    	        oGraph.click(function (evt) {
    	            var activePoint = $this._oChart.getElementsAtEventForMode(evt, 'nearest', { intersect: true }, true);
    	            if (activePoint && activePoint.length) {
    	                var sLink = oData.links[activePoint[0].index];
    	                if (sLink != undefined && sLink != "")
    	                    window.open(sLink, '_blank');
    	            }
    	        });
            }
    	},
    	'json'
    );
};

/** @} */
