/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */
// Used to set Application in caseinline=APP
function setApplSpan(SpanID) {
    var module = getParameterByName("DbPAR");
    if (module === null) {
        module = "WRITER";
    }
    var y = document.getElementById(SpanID).getElementsByTagName("SPAN");
    var n = y.length;
    var foundSystem = false;
    for (i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith(module)){
            y[i].removeAttribute("hidden");
            foundSystem=true;
        }
    }
    for (i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith("default")){
            if(!foundSystem){
                y[i].removeAttribute("hidden");
            }
        }
    }
}
// Used to set system in case, caseinline=SYSTEM
function setSystemSpan(spanID) {
    var system = getParameterByName("System");
    // if no System in URL, get browser system
    if (system === null) {
        system = getSystem();
    }
    var y = document.getElementById(spanID).getElementsByTagName("SPAN");
    var n = y.length;
    var foundSystem = false;
    for (i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith(system)){
            y[i].removeAttribute("hidden");
            foundSystem=true;
        }
    }
    for (i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith("default")){
            if(!foundSystem){
                y[i].removeAttribute("hidden");
            }
        }
    }
}
// Find spans that need the switch treatment and give it to them
var spans = document.querySelectorAll("[class^=switch]");
var n = spans.length;
for (z = 0; z < n; z++) {
    var id = spans[z].getAttribute("id");
    if (id === null) {
        continue;
    }
    else if (id.startsWith("swlnsys")) {
        setSystemSpan(id);
    } else {
        setApplSpan(id);
    }
}
/* add &DbPAR= and &System= to the links in DisplayArea div */
/* skip for object files */
function fixURL(module, system) {
    var itemlink = document.getElementById("DisplayArea").getElementsByTagName("a");
    var pSystem = (system === null) ? getSystem() : system;
    var pAppl = (module === null) ? "WRITER" : module;
    var n = itemlink.length;
    for (var i = 0; i < n; i++) {
        if (itemlink[i].getAttribute("class") != "objectfiles"){
        setURLParam(itemlink[i], pSystem, pAppl);
        }
    }
}
//Set the params inside URL
function setURLParam(itemlink, pSystem, pAppl) {
    var href = itemlink.getAttribute("href");
    if (href !== null) {
        // skip external links
        if (!href.startsWith("http")) {
            // handle bookmark.
            if (href.lastIndexOf('#') != -1) {
                var postf = href.substring(href.lastIndexOf('#'), href.length);
                var pref = href.substring(0, href.lastIndexOf('#'));
                itemlink.setAttribute("href", pref + "?" + '&DbPAR=' + pAppl + '&System=' + pSystem + postf);
            } else {
                itemlink.setAttribute("href", href + "?" + '&DbPAR=' + pAppl + '&System=' + pSystem);
            }
        }
    }
}

function getSystem() {
    var system = "Unknown OS";
    if (navigator.appVersion.indexOf("Win") != -1) system = "WIN";
    if (navigator.appVersion.indexOf("Mac") != -1) system = "MAC";
    if (navigator.appVersion.indexOf("X11") != -1) system = "UNIX";
    if (navigator.appVersion.indexOf("Linux") != -1) system = "UNIX";
    return system;
}

function getParameterByName(name, url) {
    if (!url) {
        url = window.location.href;
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)");
    var results = regex.exec(url);
    if (!results) {
        return null;
    }
    if (!results[2]) {
        return '';
    }
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function existingLang(lang) {
    if (lang === undefined) {
        return 'en-US';
    }

    if (languagesSet.has(lang)) {
        return lang;
    }

    lang = lang.replace(/[-_].*/, '');
    if (languagesSet.has(lang)) {
        return lang;
    }

    return 'en-US';
}

function setupModules(target, lang) {
    var modulesNav = document.getElementById('modules-nav');
    if (!modulesNav.classList.contains('loaded')) {
        var html =
            '<a href="' + target + lang + '/text/swriter/main0000.html?DbPAR=WRITER"><div class="writer-icon"></div>Writer</a>' +
            '<a href="' + target + lang + '/text/scalc/main0000.html?DbPAR=CALC"><div class="calc-icon"></div>Calc</a>' +
            '<a href="' + target + lang + '/text/simpress/main0000.html?DbPAR=IMPRESS"><div class="impress-icon"></div>Impress</a>' +
            '<a href="' + target + lang + '/text/sdraw/main0000.html?DbPAR=DRAW"><div class="draw-icon"></div>Draw</a>' +
            '<a href="' + target + lang + '/text/shared/explorer/database/main.html?DbPAR=BASE"><div class="base-icon"></div>Base</a>' +
            '<a href="' + target + lang + '/text/smath/main0000.html?DbPAR=MATH"><div class="math-icon"></div>Math</a>' +
            '<a href="' + target + lang + '/text/schart/main0000.html?DbPAR=CHART"><div class="chart-icon"></div>Chart</a>' +
            '<a href="' + target + lang + '/text/sbasic/shared/main0601.html?DbPAR=BASIC"><div class="basic-icon"></div>Basic</a>';
        modulesNav.innerHTML = html;
        modulesNav.classList.add('loaded');
    }
}

function setupLanguages(target, page) {
    var langNav = document.getElementById('langs-nav');
    if (!langNav.classList.contains('loaded')) {
        var html = '';
        languagesSet.forEach(function(lang) {
            html += '<a href="' + target + lang + page + '">' + ((lang in languageNames)? languageNames[lang]: lang) + '</a>';
        });
        langNav.innerHTML = html;
        langNav.classList.add('loaded');
    }
}

// Test, if we are online
if (document.body.getElementsByTagName('meta')) {
    var _paq = _paq || [];
    /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
    _paq.push(['disableCookies']);
    _paq.push(['trackPageView']);
    _paq.push(['enableLinkTracking']);
    (function() {
    var u="//piwik.documentfoundation.org/";
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', '68']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
    })();
    var system = getParameterByName("System");
} else {
    var system = getSystem();
}

var module = getParameterByName("DbPAR");
var helpID = getParameterByName("HID");
fixURL(module,system);
var dbg = getParameterByName("Debug");
if (dbg == null) { dbg=0; }
document.getElementById("DEBUG").style.display = (dbg == 0) ? "none":"block";
document.getElementById("bm_module").innerHTML ="Module is: "+module;
document.getElementById("bm_system").innerHTML ="System is: "+system;
document.getElementById("bm_HID").innerHTML ="HID is: "+helpID;

// Mobile devices need the modules and langs on page load
if (Math.max(document.documentElement.clientWidth, window.innerWidth || 0) < 960) {
    var e = new Event('change');
    var modules = document.getElementById('modules');
    var langs = document.getElementById('langs');
    modules.dispatchEvent(e);
    langs.dispatchEvent(e);
}
/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
