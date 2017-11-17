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

    for (var i = 0; i<n; i++) {
        setURLParam(itemlink[i], pSystem, pAppl)
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

function getSystem (){
    var system="Unknown OS";
    if (navigator.appVersion.indexOf("Win")!=-1) system="WIN";
    if (navigator.appVersion.indexOf("Mac")!=-1) system="MAC";
    if (navigator.appVersion.indexOf("X11")!=-1) system="UNIX";
    if (navigator.appVersion.indexOf("Linux")!=-1) system="UNIX";
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

var debouncer = null;
$(document).ready(function() {
    $('#search-bar').keyup(function() {
        if (debouncer) {
            clearTimeout(debouncer);
        }
        debouncer = setTimeout(function(){
            if ($('#search-bar').val()) {
                var toShow = $('#Index ul a').filter(function(){
                    return $(this).text().toLowerCase().indexOf($('#search-bar').val().toLowerCase()) > -1;
                });
                toShow.parent().show();
                $("#Index ul a").not(toShow).parent().hide();
            }
            else {
                $("#Index ul li" ).show();
            }
        }, 200);
    });

    //maintain only one panel open
    $('input[name="accordion-menu"]').on('change', function(){
        $('input[name="accordion-menu"]').not(this).prop('checked', false);
    });
    //focus Google Search input clicking on Find panel
    $('#accordion-2').on('change', function(){
        if($(this).is(':checked')){
            $('#gsc-i-id1').focus();
        }
    });
    //focus index search input clicking on Index panel
    $('#accordion-3').on('change', function(){
        if($(this).is(':checked')){
            $('#search-bar').focus();
        }
    });
});
/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
