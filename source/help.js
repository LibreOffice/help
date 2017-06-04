/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

function setModule(module){
if (module == null){module="SHARED"}

document.getElementById("bookmark"+module).hidden=false;
var itemspan = document.getElementsByTagName("span");
var n = itemspan.length;
for (var i = 0; i < n; i++){
   if (itemspan[i].getAttribute("value") == module){
      itemspan[i].removeAttribute("hidden");
   }
}
}
function setSystem(system){
var itemspan = document.getElementsByTagName("span");
if (system == null){system="DEFSYS"}
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
  var n = itemlink.length;
  var pSystem = (system == null) ? "":"&System="+system;
  var pAppl = (module == null) ? "":"&DbPAR="+module;
  for (var i = 0; i<n; i++) {
      if(true){
      var href = itemlink[i].getAttribute("href");
      if (href != null){
          if (!href.startsWith("http")) {
              var pre = href.substring(0,href.indexOf('?'));
              if (href.lastIndexOf('#') > 0){
              var post = href.substring(href.lastIndexOf('#'),href.length);
              }
              else{
                  post='';
              }
              var url = pre+'?'+pAppl+pSystem+post;
              itemlink[i].setAttribute("href",url);
          }
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
                $("#BottomLeft ul a:not(:contains('" + $('#search-bar').val() + "'))" ).parent().hide();
                $("#BottomLeft ul a:contains('" + $('#search-bar').val() + "')" ).parent().show();
            }
            else {
                $("#BottomLeft ul li" ).show();
            }
        }, 200);
    });
});

/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
