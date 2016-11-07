/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

function loadXMLDoc(filename, response)
{
    if (window.ActiveXObject)
    {
        xhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    else
    {
        xhttp = new XMLHttpRequest();
    }

    xhttp.open("GET", filename, false);
    try {
        xhttp.responseType = "msxml-document"
    } catch(err) {} // Helping IE11

    xhttp.send("");
    if (response == 1) {
        return xhttp.responseXML;
    }

    return xhttp.responseText;
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

function displayResult(file, moduleName, language, system)
{
    var xml = loadXMLDoc(file, 1);
    var xsl = loadXMLDoc('online_transform.xsl', 1);
    var xsltProcessor;
    var resultDocument;
    var bookmarkHTML;
    var urlVars = getUrlVars(file);
    var module = urlVars["DbPAR"];
    moduleName = moduleName || module;
    var language = urlVars["Language"];
    var system = urlVars["System"];
    var usedb = urlVars["UseDB"];
    document.getElementById("DisplayArea").innerHTML= null;
    document.getElementById("BottomLeft").innerHTML= null;

    if (window.ActiveXObject || xhttp.responseType == "msxml-document") {
        // code for IE
        ex = xml.transformNode(xsl);
        document.getElementById("DisplayArea").innerHTML = ex;
    }
    else if (document.implementation && document.implementation.createDocument) {
        // code for Chrome, Firefox, Opera, etc.
        xsltProcessor = new XSLTProcessor();

        if (module){xsltProcessor.setParameter(null, "appl", module);}
        if (language){xsltProcessor.setParameter(null, "Language", language);}
        if (system){xsltProcessor.setParameter(null, "System", system);}

        $(document).on('click', '#BottomLeft a, #DisplayArea a', function(e) {
                e.preventDefault();
                $('#search-bar').val('');
                var xml = loadXMLDoc($(this).attr('href'), 1);
                var resultDocument = xsltProcessor.transformToFragment(xml,  document);
                $("#DisplayArea").html($(resultDocument).find('#DisplayArea').html());
                return false;
                });

        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToFragment(xml,  document);
        $("#DisplayArea").html($(resultDocument).find('#DisplayArea').html());
        // Handle bookmar panel
        $("#BottomLeft").load('bookmark_'+moduleName+'.html');
    }
}

var debouncer = null;
$(document).ready(function() {
        $('#search-bar').keyup(function() {
                if(debouncer) {
                clearTimeout(debouncer);
                }
                debouncer = setTimeout(function(){
                        $("#BottomLeft ul li" ).show();
                        if($('#search-bar').val()) {
                        $("#BottomLeft ul a:not(:contains('" + $('#search-bar').val() + "'))" ).parent().hide();
                        }
                        }, 500);
                });
        });

//http://papermashup.com/read-url-get-variables-withjavascript/

function getUrlVars(file) {
    var vars = {};
    var parts = file.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {vars[key] = value;});
    //var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {vars[key] = value;});
    return vars;
}

/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
