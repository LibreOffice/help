/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

function loadXMLDoc(filename, handler)
{
    if (window.ActiveXObject)
    {
        xhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    else
    {
        xhttp = new XMLHttpRequest();
    }

    xhttp.open("GET", filename);
    xhttp.onload = handler;
    try {
        xhttp.responseType = "msxml-document"
    } catch(err) {} // Helping IE11

    xhttp.send();
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

function displayXML(xml, xsl, urlVars, moduleName, language, system) {
    var xsltProcessor;
    var resultDocument;
    var bookmarkHTML;
    var module = urlVars["DbPAR"];
    moduleName = moduleName || module;
    var language = urlVars["Language"];
    var system = urlVars["System"];
    var usedb = urlVars["UseDB"];
    document.getElementById("DisplayArea").innerHTML= null;
    document.getElementById("BottomLeft").innerHTML= null;
    document.getElementById("TopRight").innerHTML= null;

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

                var fileName = $(this).attr('href');

                loadXMLDoc(fileName, function() {
                    var xmlDoc = this.responseXML;
                    if (xmlDoc != null) {
                        var resultDocument = xsltProcessor.transformToFragment(xmlDoc,  document);
                        $("#DisplayArea").html($(resultDocument).find('#DisplayArea').html());
                        $("#TopRight").html('<p class="bug">Contents displayed is: ' + fileName + '</p>');
                    }
                    else {
                        console.log('Cannot load ' + fileName);
                    }
                });
                return false;
            });

        xsltProcessor.importStylesheet(xsl);
        resultDocument = xsltProcessor.transformToFragment(xml,  document);
        $("#DisplayArea").html($(resultDocument).find('#DisplayArea').html());
        // Handle bookmar panel
        $("#BottomLeft").load('bookmark_'+moduleName+'.html');
        $("#TopRight").html('<p class="bug">Contents displayed is: '+$(this).attr('href')+'</p>');
    }
}

function displayResult(file, moduleName, language, system) {
    // load the XSLT
    loadXMLDoc('online_transform.xsl', function() {
        var xsl = this.responseXML;

        // load the actual XHP file
        if (xsl != null) {
            loadXMLDoc(file, function(){
                var xml = this.responseXML;
                if (xml != null) {
                    displayXML(xml, xsl, getUrlVars(file), moduleName, language, system);
                }
                else {
                    console.log('Cannot load ' + file);
                }
            });
        }
        else {
            console.log('Cannot load online_transform.xsl');
        }
    });
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

//http://papermashup.com/read-url-get-variables-withjavascript/

function getUrlVars(file) {
    var vars = {};
    var parts = file.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {vars[key] = value;});
    //var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {vars[key] = value;});
    return vars;
}

/* vim:set shiftwidth=4 softtabstop=4 expandtab cinoptions=b1,g0,N-s cinkeys+=0=break: */
