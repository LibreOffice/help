----------------------------------------------------------------- 
Helpcontent displayed in a browser directly from XML 
----------------------------------------------------------------- 

This README shows how to display Helpcontent2 XML pages (XHP) directly rendered in a modern browser. 

----------------------------------------------------------------- 
Background 
----------------------------------------------------------------- 

The XML files must be transformed into HTML files with the help of a style sheet file (XSL).

In the current helpcontent2, the processing is done in xmlhelp/ module, an ancient XSLT processor developed circa 2005 (OpenOffice.org 1.5)

Modern browsers such as Firefox, Chrome and Rekonq are capable to execute the transformation direcly in the client, by getting an URL that returns a XML file that contains the reference of the necessary XSL style sheet.

How to display Helpcontent2 in a browser

1. Open the browser
2. Open the file index.html in source/ folder
3. Navigate in pages

----------------------------------------------------------------- 
File descriptions
----------------------------------------------------------------- 

default.css: 
-------------
the cascading style sheet for HTML formatting.

online_transform.xsl:
--------------------
the XSL transform file. Transform XHP files into HTML files.

This file is a modification of xmlhelper/util/main_transform.xsl, which was designed for xmlhelp XSL processor.

help.js
-------
This javascript file: 
1. modifies href attributes in <a> of #DisplayArea to handle &DbPAR and &System params
2. picks the bookmarks file and displays in #BottomLeft <div> area.
3. Reads URL params.

-----------------------------------------------------------------
New ‘Object’ tag
-----------------------------------------------------------------

The filter online_transform.xsl now support the <object> tag defined for XHP files to allow a generic object in the browser. The <object> tag now maps to the folowing HTML5 tags:
Maps to HTML5 <video> tag:

<section id="video">
  <object id="1232312" type ="video/ogg" data="movies/testvideo.ogv" height="480px" width="640px"/>
</section>

Maps to HTML5 <audio> tag:
<section id="audio">
  <object id="1232312" type ="audio/ogg" data="audio/testaudio.wav" height="" width=""/>
</section>

Maps to HTML5 <object> tag:

  <object id="1232312" type ="{mimetype}" data="object/testobject.swf" height="" width=""/>

----------------------------------------------------------------- 
How to build the LibreOffice Browser help 
----------------------------------------------------------------- 

1) run help-to-html.sh in helpcontent2/source/ folder. A previous language build must exist in workdir/HelpTranslatePartHelp/ . 
The script will build all existing languages available in this folder. See help-to-html.sh script and adjust path.


2) copy folder html/ to your root web server.


