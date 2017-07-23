/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

// Used to set Apllication in caseinlie=APP
function setModule(module){
    if (module == null){module="WRITER"}
    document.getElementById("bookmark"+module).hidden=false;
    var itemspan = document.getElementsByTagName("span");
    var n = itemspan.length;
    for (var i = 0; i < n; i++){
        if (itemspan[i].getAttribute("value") == module){
            itemspan[i].removeAttribute("hidden");
        }
    }
}

// Used to set system in caseinline=SYSTEM
function setSystem(system){
    var itemspan = document.getElementsByTagName("span");
    if (system == null){system="WIN"}
    var n = itemspan.length;
    for (var i = 0; i < n; i++){
        if (itemspan[i].getAttribute("value") == system){
            itemspan[i].removeAttribute("hidden");
        }
    }
}
/* add &DbPAR= and &System= to the links in DisplayArea div */
function fixURL(module, system){
    var itemlink = document.getElementById("DisplayArea").getElementsByTagName("a");
    var pSystem = (system == null) ? "WIN" : system;
    var pAppl = (module == null) ? "WRITER" : module;
    var n = itemlink.length;
    var item;
    for (var i = 0; i<n; i++) {setURLParam(itemlink[i], pSystem, pAppl)
    }
}
//Set the params inside URL
function setURLParam (itemlink, pSystem, pAppl) {
    var href = itemlink.getAttribute("href");
    if (href != null){
        // skip external links
        if (!href.startsWith("http")) {
            // handle bookmark.
            if (href.lastIndexOf('#') != -1) {
                var postf = href.substring(href.lastIndexOf('#'),href.length);
                var pref = href.substring(0, href.lastIndexOf('#'));
                itemlink.setAttribute("href", pref + "?" + '&DbPAR=' + pAppl + '&System=' + pSystem + postf);
            }else{
                itemlink.setAttribute("href", href + "?" + '&DbPAR=' + pAppl + '&System=' + pSystem);
            }
        }
    }
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

var debouncer = null;
$(document).ready(function() {
    $('#search-bar').keyup(function() {
        if (debouncer) {
            clearTimeout(debouncer);
        }
        debouncer = setTimeout(function(){
            if ($('#search-bar').val()) {
                $("#Index ul a:not(:contains('" + $('#search-bar').val() + "'))" ).parent().hide();
                $("#Index ul a:contains('" + $('#search-bar').val() + "')" ).parent().show();
            }
            else {
                $("#Index ul li" ).show();
            }
        }, 200);
    });
});
/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
