/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */
// Used to set Application in caseinline=APP
function setApplSpan(spanZ) {
    let module = getParameterByName("DbPAR");
    if (module === null) {
        module = "SHARED";
    }
    let y = spanZ.getElementsByTagName("SPAN");
    let n = y.length;
    let foundAppl = false;
    for (i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith(module)){
            y[i].hidden = false;
            foundAppl=true;
        }
    }
    for (i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith("default")){
            y[i].hidden = true;
            if(!foundAppl){
                y[i].hidden = false;
            }
        }
    }
}
// Used to set system in case, caseinline=SYSTEM
function setSystemSpan(spanZ) {
    // if no System in URL, get browser system
    let system = getParameterByName("System");
    if (system === null) {
        system = getSystem();
    }
    let y = spanZ.getElementsByTagName("SPAN");
    let n = y.length;
    let foundSystem = false;

    for (let i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith(system)){
            y[i].hidden = false;
            foundSystem=true;
        }
    }
    for (let i = 0; i < n; i++) {
        if (y[i].getAttribute("id") === null){
            continue;
        }
        else if( y[i].getAttribute("id").startsWith("default")){
            y[i].hidden = true;
            if(!foundSystem){
                y[i].hidden = false;
            }
        }
    }
}

/* add &DbPAR= and &System= to the links in DisplayArea div */
/* skip for object files */
function fixURL(module, system) {
    if ((DisplayArea = document.getElementById("DisplayArea")) === null) return;
    var itemlink = DisplayArea.getElementsByTagName("a");
    var pSystem = (system === null) ? getSystem() : system;
    var pAppl = (module === null) ? "SHARED" : module;
    var n = itemlink.length;
    for (var i = 0; i < n; i++) {
        if (itemlink[i].getAttribute("class") != "objectfiles") {
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

// This is used when arriving the first time via the application
// or direct access to web root, e.g. a web search. It should not
// be used outside of online context as then we can not guarantee
// en-US as a fallback language.
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

function setupModules(lang) {
    var modulesNav = document.getElementById('modules-nav');
    if (!modulesNav.classList.contains('loaded')) {
        let html =
            '<a href="' + lang + '/text/shared/05/new_help.html?DbPAR=SHARED"><div class="office-icon"></div>%PRODUCTNAME</a>' +
            '<a href="' + lang + '/text/swriter/main0000.html?DbPAR=WRITER"><div class="writer-icon"></div>Writer</a>' +
            '<a href="' + lang + '/text/scalc/main0000.html?DbPAR=CALC"><div class="calc-icon"></div>Calc</a>' +
            '<a href="' + lang + '/text/simpress/main0000.html?DbPAR=IMPRESS"><div class="impress-icon"></div>Impress</a>' +
            '<a href="' + lang + '/text/sdraw/main0000.html?DbPAR=DRAW"><div class="draw-icon"></div>Draw</a>' +
            '<a href="' + lang + '/text/sdatabase/main.html?DbPAR=BASE"><div class="base-icon"></div>Base</a>' +
            '<a href="' + lang + '/text/smath/main0000.html?DbPAR=MATH"><div class="math-icon"></div>Math</a>' +
            '<a href="' + lang + '/text/schart/main0000.html?DbPAR=CHART"><div class="chart-icon"></div>Chart</a>' +
            '<a href="' + lang + '/text/sbasic/shared/main0601.html?DbPAR=BASIC"><div class="basic-icon"></div>Basic</a>';
        modulesNav.innerHTML = html;
        modulesNav.classList.add('loaded');
    }
}

function setupLanguages(url) {
    let langNav = document.getElementById('langs-nav');
    if (!langNav) return;
    let page = url.substring(url.search('/text/'));
    if (!langNav.classList.contains('loaded')) {
        let html = '';
        languagesSet.forEach(function(lang) {
            html += '<a href="' + lang + page + '">' + ((lang in languageNames)? languageNames[lang]: lang) + '</a>';
        });
        langNav.innerHTML = html;
        langNav.classList.add('loaded');
    }
}

function debugInfo(dbg) {
    if (dbg == null) return;
    document.getElementById("DEBUG").style.display = "block";
    document.getElementById("bm_module").innerHTML = "Module is: "+module;
    document.getElementById("bm_system").innerHTML = "System is: "+system;
    document.getElementById("bm_HID").innerHTML = "HID is: "+helpID;
}

// Find spans that need the switch treatment and give it to them
function impl_Switches(){

    let spans = document.querySelectorAll("[class^=switch]");
    let n = spans.length;
    for (let z = 0; z < n; z++) {
        let id = spans[z].getAttribute("id");
        if (id === null) {
            continue;
        }
        else if (id.startsWith("swlnsys")) {
            setSystemSpan(spans[z]);
        } else {
        setApplSpan(spans[z]);
        }
    }
}
// Main
let module = getParameterByName("DbPAR");
let system = getParameterByName("System");
let helpID = getParameterByName("HID");
impl_Switches();
fixURL(module,system);
// only used in xhp pages with <help-id-missing/> tags
let missingElement = document.getElementById("bm_HID2");
if(missingElement != null){missingElement.innerHTML = helpID;}

debugInfo(getParameterByName("Debug"));

// Mobile devices need the modules and langs displayed on page load
if (Math.max(document.documentElement.clientWidth, window.innerWidth || 0) < 960) {
    let modules = document.getElementById('modules-nav');
    let langs = document.getElementById('langs-nav');
    modules.removeAttribute('hidden');
    if (langs) {
        langs.removeAttribute('hidden');
    }
}

const href = window.location.href;
const lang = getParameterByName("Language", href) || document.querySelector("html").getAttribute("lang");
setupModules(lang);
setupLanguages(href);

/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
