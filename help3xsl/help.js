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
try {xhttp.responseType = "msxml-document"} catch(err) {} // Helping IE11
xhttp.send("");
if (response == 1){return xhttp.responseXML;}
return xhttp.responseText;
}


function displayResult(file, moduleName, language, system)
{
var xml = loadXMLDoc(file, 1);
var xsl = loadXMLDoc('/online_transform.xsl', 1);
var xsltProcessor;
var resultDocument;
var bookmarkHTML;
var urlVars = getUrlVars(file);
  var module = urlVars["DbPAR"];
  var language = urlVars["Language"];
  var system = urlVars["System"];
  var usedb = urlVars["UseDB"];
  document.getElementById("DisplayArea").innerHTML= null; 
  document.getElementById("BottomLeft").innerHTML= null; 
// code for IE
if (window.ActiveXObject || xhttp.responseType == "msxml-document")
  {
  ex = xml.transformNode(xsl);
  document.getElementById("DisplayArea").innerHTML = ex;
  }
// code for Chrome, Firefox, Opera, etc.
else if (document.implementation && document.implementation.createDocument)
  {
    xsltProcessor = new XSLTProcessor();

    if (module){xsltProcessor.setParameter(null, "appl", module);}
    if (language){xsltProcessor.setParameter(null, "Language", language);}
    if (system){xsltProcessor.setParameter(null, "System", system);}

    $(document).on('click', '#BottomLeft a', function(e) {
      e.preventDefault();
      var xml = loadXMLDoc($(this).attr('href'), 1);
      var resultDocument = xsltProcessor.transformToFragment(xml,  document);
      $("#DisplayArea").html($(resultDocument).find('#DisplayArea').html());
      return false;
    });

    xsltProcessor.importStylesheet(xsl);
    resultDocument = xsltProcessor.transformToFragment(xml,  document);
    $("#DisplayArea").html($(resultDocument).find('#DisplayArea').html());
    // Handle bookmar panel
    $("#BottomLeft").load('/bookmark_'+moduleName+'.html');
  }
}

$(document).ready(function() {
  $('#search-bar').keyup(function() {
    $("#BottomLeft ul li" ).show();
    if($(this).val()) {
      $("#BottomLeft ul a:not(:contains('" + $(this).val() + "'))" ).parent().hide();
    }
  });
});

//http://papermashup.com/read-url-get-variables-withjavascript/

function getUrlVars(file) {
var vars = {};
var parts = file.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {vars[key] = value;});
//var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {vars[key] = value;});
return vars;
}
