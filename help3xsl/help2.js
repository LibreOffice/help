/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://www.mozilla.org/MPL/2.0/.
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
            appendThemeParam(itemlink[i]);
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

// Append Theme parameter to a link if the user has an explicit preference.
// The fragment (#bookmark) must stay at the very end of the URL.
function appendThemeParam(itemlink) {
    var theme = getExplicitTheme();
    if (!theme) return;

    var href = itemlink.getAttribute("href");
    if (href === null || href.startsWith("http")) return;
    if (href.indexOf("Theme=") !== -1) return;

    var hash = '';
    var idx = href.indexOf('#');
    if (idx !== -1) {
        hash = href.substring(idx);
        href = href.substring(0, idx);
    }

    var separator = href.indexOf("?") !== -1 ? "&" : "?";
    itemlink.setAttribute("href", href + separator + "Theme=" + theme + hash);
}

// fixURL() only walks #DisplayArea. Header, treeview, pagination and
// module links need the Theme parameter as well, otherwise the choice
// is lost as soon as the user leaves the article area.
function propagateThemeGlobally() {
    var links = document.querySelectorAll('a[href]');
    for (var i = 0; i < links.length; i++) {
        appendThemeParam(links[i]);
    }
}

// Rewrite links that already carry an outdated Theme value
function refreshThemeParams(newTheme) {
    var links = document.querySelectorAll('a[href*="Theme="]');
    for (var i = 0; i < links.length; i++) {
        links[i].setAttribute('href',
            links[i].getAttribute('href')
                .replace(/([?&])Theme=(dark|light)/, '$1Theme=' + newTheme));
    }
    propagateThemeGlobally();
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
    if (!modulesNav) return;
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

/* ============================================================
 *  THEME MANAGEMENT
 *  Priority: URL param > localStorage > prefers-color-scheme
 *
 *  Under file:// Chromium treats every document as an opaque
 *  origin, so localStorage is not shared between help pages.
 *  The Theme URL parameter is therefore the primary carrier and
 *  localStorage is only an extra layer (works on Firefox and
 *  whenever the help is served over http://).
 *  ============================================================ */

var THEME_STORAGE_KEY = 'theme';
var themeMediaQuery = window.matchMedia('(prefers-color-scheme: dark)');

function getStoredTheme() {
    try { return localStorage.getItem(THEME_STORAGE_KEY); }
    catch(e) { return null; }
}

function saveTheme(theme) {
    try { localStorage.setItem(THEME_STORAGE_KEY, theme); }
    catch(e) {}
}

function clearStoredTheme() {
    try { localStorage.removeItem(THEME_STORAGE_KEY); }
    catch(e) {}
}

// Theme explicitly chosen by the user, or null when the page is
// still following the operating system preference. Only explicit
// choices are propagated to other pages.
function getExplicitTheme() {
    var urlTheme = getParameterByName("Theme");
    if (urlTheme === 'dark' || urlTheme === 'light') {
        return urlTheme;
    }
    var saved = getStoredTheme();
    if (saved === 'dark' || saved === 'light') {
        return saved;
    }
    return null;
}

// The theme class lives on <html>: it exists before <body> is parsed,
// so the script can run from <head> without a flash of the wrong theme.
function applyTheme(theme) {
    var root = document.documentElement;
    root.classList.remove('dark-mode', 'light-mode');
    root.classList.add(theme + '-mode');
}


// Determine effective theme from all sources
function resolveTheme() {
    var explicit = getExplicitTheme();
    if (explicit) {
        return explicit;
    }
    // Fall back to the OS preference
    return themeMediaQuery.matches ? 'dark' : 'light';
}

function bindThemeToggle() {
    var toggleBtn = document.getElementById('theme-toggle');
    if (!toggleBtn || toggleBtn.dataset.themeBound) return;
    toggleBtn.dataset.themeBound = '1';

    toggleBtn.addEventListener('click', function() {
        var isDark = document.documentElement.classList.contains('dark-mode');
        var newTheme = isDark ? 'light' : 'dark';
        applyTheme(newTheme);
        saveTheme(newTheme);
        // Update URL without reload so links on this page reflect the change
        var url = new URL(window.location.href);
        url.searchParams.set('Theme', newTheme);
        window.history.replaceState({}, '', url);
        // Keep every link on this page in sync with the new choice
        refreshThemeParams(newTheme);
    });
}

function initTheme() {
    applyTheme(resolveTheme());

    // React to OS preference changes only when user has no explicit preference
    themeMediaQuery.addEventListener('change', function() {
        if (!getExplicitTheme()) {
            applyTheme(themeMediaQuery.matches ? 'dark' : 'light');
        }
    });

    // The toggle button may not exist yet when this file is parsed
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', bindThemeToggle);
    } else {
        bindThemeToggle();
    }
}


// Apply theme early to avoid flash of wrong theme
initTheme();

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
    if (modules) {
        modules.removeAttribute('hidden');
    }
    if (langs) {
        langs.removeAttribute('hidden');
    }
}

const href = window.location.href;
const lang = getParameterByName("Language", href) || document.querySelector("html").getAttribute("lang");
setupModules(lang);
setupLanguages(href);

// Must run after the innerHTML injections above, so the freshly
// created module and language links also carry the Theme parameter.
propagateThemeGlobally();

// Late safety net: links created after page load (bookmark search,
// Xapian results) get the parameter at click time.
document.addEventListener('click', function(e) {
    var link = e.target.closest ? e.target.closest('a[href]') : null;
    if (link) appendThemeParam(link);
}, true);

/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
