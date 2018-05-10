
var getMonthlyQuote = function(primaryName, province, revenue, coverages) {
    var total = 0;

    for (var i = 0; i < coverages.length; i++) {
        var coverage = coverages[i];
        if (coverage.code === "CGL") {
            total += getCommercialGeneralLiabilityQuote(primaryName, province, revenue, coverage.coverageAmount);
        } else if (coverage.code === "DATA") {
            total += getCyberLiabilityQuote(primaryName, province, revenue);
        } else if (coverage.code === "CONTENT") {
            total += getBusinessContentQuote(primaryName, province, coverage.coverageAmount);
        } else if (coverage.code === "ERRORS") {
            total += getBusinessErrorsQuote(primaryName, province, coverage.coverageAmount);
        } else if (coverage.code === "INSTALLATION") {
            total += getInstallationQuote(primaryName, province, revenue);
        } else if (coverage.code === "TOOLS") {
            total += getToolsQuote(primaryName, province, coverage.coverageAmount);
        } else if (coverage.code === "INTERRUPTION") {
            total += getInterruptionCoverage(primaryName, province, revenue);
        }
    }

    return total;
}

var getCoveragesForPrimaryName = function(primaryName) {
    var coverages = [];
    if (_isPrimaryNameInArray(commercial_general_liability, primaryName)) {
        var c = {
            code: "CGL",
            name: "Coverage Limit",
            values: [
                0,2000000,5000000
            ]
        }
        coverages.push(c);
    }
    if (_isPrimaryNameInArray(data_privacy_liability, primaryName)) {
        var c = {
            code: "DATA",
            name: "Enable Coverage",
            values: [
                0,1
            ]
        }
        coverages.push(c);
    }
    if (_isPrimaryNameInArray(business_content_coverage, primaryName)) {
        var c = {
            code: "CONTENT",
            name: "Coverage Limit",
            values: [
                0,25000,100000,250000
            ]
        }
        coverages.push(c);
    }
    if (_isPrimaryNameInArray(business_errors_coverage, primaryName)) {
        var c = {
            code: "ERRORS",
            name: "Coverage Limit",
            values: [
                0,1000000,2000000
            ]
        }
        coverages.push(c);
    }
    if (_isPrimaryNameInArray(installation_coverage, primaryName)) {
        var c = {
            code: "INSTALLATION",
            name: "Enable Coverage",
            values: [
                0,1
            ]
        }
        coverages.push(c);
    }
    if (_isPrimaryNameInArray(tools_coverage, primaryName)) {
        var c = {
            code: "TOOLS",
            name: "Coverage Limit",
            values: [
                0,25000,50000,100000,250000
            ]
        }
        coverages.push(c);
    }
    if (_isPrimaryNameInArray(business_interruption_coverage, primaryName)) {
        coverages.push("INTERRUPTION");
        var c = {
            code: "INTERRUPTION",
            name: "Enable Coverage",
            values: [
                0,1
            ]
        }
        coverages.push(c);
    }

    return coverages;
}

var _isPrimaryNameInArray = function(arr, primaryName) {

    for (var i = 0; i < arr.length; i++) {
        if (arr[i].primaryName.toLowerCase() == primaryName.toLowerCase()) {
            return true;
        }
    }
    return false;
}

var getBusinessContentQuote =  function(primaryName, province, coverage) {
    var mainList = business_content_coverage || []

    var coverage_limit = "coverageLimit-UP_TO_25K";
    if (coverage <= 25000) {
        coverage_limit = "coverageLimit-UP_TO_50K";
    } else if (coverage <= 100000) {
        coverage_limit = "coverageLimit-UP_TO_100K";
    } else if (coverage <= 250000) {
        coverage_limit = "coverageLimit-UP_TO_250K";
    }

    for (i = 0; i < mainList.length; i++) {
        var pn = mainList[i].primaryName.toLowerCase();
        var pv = mainList[i].province_code;

        if (primaryName.toLowerCase() == pn && pv.includes(province)) {
            return mainList[i][coverage_limit];
        }
    }
}

var getInterruptionCoverage = function(primaryName, province, revenue) {
    var mainList = business_interruption_coverage || []
    var results = getRatesForLiability(mainList, primaryName, province, revenue);
    return (results.length && results[0].quote) || null;
}


var getCommercialGeneralLiabilityQuoteByCoverage =  function(primaryName, province, revenue) {
    var mainList = commercial_general_liability || []
    return getRatesForLiability(mainList, primaryName, province, revenue);
}

var getCommercialGeneralLiabilityQuote =  function(primaryName, province, revenue, coverage) {
    var mainList = commercial_general_liability || []
    var results = getRatesForLiability(mainList, primaryName, province, revenue);
    if (results && results.length) {
        var coverage_str = "UP_TO_2M";
        if (coverage) {
            if (coverage > 2000000) {
                coverage_str = "UP_TO_5M";
            }
        }
        for(var i = 0; i < results.length; i++) {
            if (results[i].coverageLimit == coverage_str) {
                return results[i].quote;
            }
        }
    }
    return 0;
}

var getCyberLiabilityQuote =  function(primaryName, province, revenue) {
    var mainList = data_privacy_liability || []
    var results = getRatesForLiability(mainList, primaryName, province, revenue);
    return (results.length && results[0].quote) || null;
}

var getInstallationQuote =  function(primaryName, province, revenue) {
    var mainList = installation_coverage || []
    var results = getRatesForLiability(mainList, primaryName, province, revenue);
    return (results.length && results[0].quote) || null;
}

var getBusinessErrorsQuote =  function(primaryName, province, coverage) {
    var mainList = business_errors_coverage || []

    var coverage_limit = "coverageLimit-UP_TO_1M";
    if (coverage <= 1000000) {
        coverage_limit = "coverageLimit-UP_TO_1M";
    } else if (coverage <= 200000) {
        coverage_limit = "coverageLimit-UP_TO_2M";
    }

    for (i = 0; i < mainList.length; i++) {
        var pn = mainList[i].primaryName;
        var pv = mainList[i].province_code;

        if (primaryName.toLowerCase() == pn.toLowerCase() && pv.includes(province)) {
            return {quote: mainList[i][coverage_limit], coverageLimit: mainList[i].coverageLimit};}
    }
}

var getToolsQuote =  function(primaryName, province, coverage) {
    var mainList = tools_coverage || []

    var coverage_limit = "coverageLimit-UP_TO_25K";
    if (coverage <= 25000) {
        coverage_limit = "coverageLimit-UP_TO_50K";
    } else if (coverage <= 100000) {
        coverage_limit = "coverageLimit-UP_TO_100K";
    } else if (coverage <= 250000) {
        coverage_limit = "coverageLimit-UP_TO_250K";
    }

    for (i = 0; i < mainList.length; i++) {
        var pn = mainList[i].primaryName;
        var pv = mainList[i].province_code;

        if (primaryName.toLowerCase() == pn.toLowerCase() && pv.includes(province)) {
            return mainList[i][coverage_limit];
        }
    }
}

var getRatesForLiability =  function(mainList, primaryName, province, revenue) {
    var revenue_lookup = "revenueRange-UP_TO_50K";
    if (revenue <= 50000) {
        revenue_lookup = "revenueRange-UP_TO_50K";
    } else if (revenue <= 100000) {
        revenue_lookup = "revenueRange-UP_TO_100K";
    } else if (revenue <= 250000) {
        revenue_lookup = "revenueRange-UP_TO_250K";
    } else if (revenue <= 500000) {
        revenue_lookup = "revenueRange-UP_TO_500K";
    }

    var results = [];
    for (i = 0; i < mainList.length; i++) {
        var pn = mainList[i].primaryName;
        var pv = mainList[i].province_code;

        if (primaryName.toLowerCase() == pn.toLowerCase() && pv.includes(province)) {
            var result = {quote: mainList[i][revenue_lookup], coverageLimit: mainList[i].coverageLimit};
            results.push(result);
        }
    }
    return results;
}


var getRatesForLiability =  function(mainList, primaryName, province, revenue) {
    var revenue_lookup = "revenueRange-UP_TO_50K";
    if (revenue <= 50000) {
        revenue_lookup = "revenueRange-UP_TO_50K";
    } else if (revenue <= 100000) {
        revenue_lookup = "revenueRange-UP_TO_100K";
    } else if (revenue <= 250000) {
        revenue_lookup = "revenueRange-UP_TO_250K";
    } else if (revenue <= 500000) {
        revenue_lookup = "revenueRange-UP_TO_500K";
    }

    var results = [];
    for (i = 0; i < mainList.length; i++) {
        var pn = mainList[i].primaryName;
        var pv = mainList[i].province_code;

        if (primaryName.toLowerCase() == pn.toLowerCase() && pv.includes(province)) {
            var result = {quote: mainList[i][revenue_lookup], coverageLimit: mainList[i].coverageLimit};
            results.push(result);
        }
    }
    return results;
}
