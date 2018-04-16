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
        };
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
// Pagination and fuzzy search
var fuseshown = document.getElementsByClassName("fuseshown");
var indexkids = document.getElementsByClassName("index")[0].children;
var liElements = Array.prototype.slice.call(fuseshown).map(function(elm) {
    var item = elm;
    var linktext = item.textContent;
    var fuseObject = {
        item: item,
        linktext: linktext
    };
    return fuseObject;
});
var fuse = new Fuse(liElements, {
    keys: ["linktext"],
    distance: 60,
    location: 0,
    threshold: 0.2,
    tokenize: true,
    matchAllTokens: true,
    maxPatternLength: 24,
    minMatchCharLength: 2
});
var modules = ['CALC', 'WRITER', 'IMPRESS', 'DRAW', 'BASE', 'MATH', 'CHART', 'BASIC', 'SHARED'];

function addIds() {
    for (var i = 0, len = indexkids.length; i < len; i++) {
        indexkids[i].removeAttribute("id");
    }
    modules.forEach(function(module) {
        var fuseshownModule = document.getElementsByClassName("fuseshown " + module)[0];
        if (typeof fuseshownModule !== 'undefined') {
            fuseshownModule.setAttribute("id", module);
        }
    });
}
var search = document.getElementById('search-bar');
var filter = function() {
    var target = search.value.trim();
    if (target.length < 1) {
        liElements.forEach(function(obj) {
            obj.item.classList.add('fuseshown');
            obj.item.classList.remove('fusehidden');
        });
        Paginator(document.getElementsByClassName("index")[0]);
        addIds();
        return;
    }
    var results = fuse.search(target);
    liElements.forEach(function(obj) {
        obj.item.classList.add('fusehidden');
        obj.item.classList.remove('fuseshown');
    });
    results.forEach(function(obj) {
        obj.item.classList.add('fuseshown');
        obj.item.classList.remove('fusehidden');
    });
    Paginator(document.getElementsByClassName("index")[0]);
    addIds();
};

function debounce(fn, wait) {
    var timeout;
    return function() {
        clearTimeout(timeout);
        timeout = setTimeout(function() {
            fn.apply(this, arguments);
        }, (wait || 150));
    };
}
Paginator(document.getElementsByClassName("index")[0]);
search.addEventListener('keyup', debounce(filter, 300));
addIds();
// copy useful content to clipboard on mouse click
var copyable = document.getElementsByClassName("input");
for (var i = 0, len = copyable.length; i < len; i++) {
    (function() {
        var item = copyable[i];

        function changeColor(item, color, colorToChangeBackTo) {
            item.style.backgroundColor = color;
            setTimeout(function() {
                item.style.backgroundColor = colorToChangeBackTo;
            }, 150);
        }
        item.onclick = function() {
            document.execCommand("copy");
            changeColor(item, "#18A303", "transparent");
        };
        item.addEventListener("copy", function(event) {
            event.preventDefault();
            if (event.clipboardData) {
                event.clipboardData.setData("text/plain", item.textContent);
            }
        });
    }());
}
// auto-expand contents per subitem
var pathname = window.location.pathname;
var pathRegex = /text\/.*\.html$/;
var linkIndex = 0;
var contentMatch = pathname.match(pathRegex);
function linksMatch(content) {
    var linkMatch = new RegExp(content);
    var links = document.getElementById("Contents").getElementsByTagName("a");
    for (var i = 0, len = links.length; i < len; i++) {
        if (links[i].href.match(linkMatch)) {
            return i;
        }
    }
}
linkIndex = linksMatch(contentMatch);
if (typeof linkIndex !== "undefined") {
    var current = document.getElementById("Contents").getElementsByTagName("a")[linkIndex];
    var cItem = current.parentElement;
    var parents = [];
    while (cItem.parentElement && !cItem.parentElement.matches("#Contents") && parents.indexOf(cItem.parentElement) == -1) {
        parents.push(cItem = cItem.parentElement);
    }
    var liParents = [].filter.call(parents, function(item) {
        return item.matches("li");
    });
    for (var i = 0, len = liParents.length; i < len; i++) {
        var input = liParents[i].querySelectorAll(':scope > input');
        document.getElementById(input[0].id).checked = true;
    }
    current.classList.add('contents-current');
}
/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
