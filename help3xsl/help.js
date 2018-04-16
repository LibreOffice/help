/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

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
