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

index.html: 
-----------
The entry web page in the root folder of the server. Displays the #TopLeft <div> with links to LibreOffice modules help libraries.

online_transform.xsl:
--------------------
the XSL transform file. Transform XHP files into HTML files.

This file is a modification of xmlhelper/util/main_transform.xsl, which was designed for xmlhelp XSL processor.

The XSLT online_transform.xsl is used inside help.js. 

help.js
-------
This javascript file: 
1. takes XHP files and online_transform.xsl and generates the HTML contents to be displayed in #DisplayArea <div>. 
2. picks the bookmarks file and displays in #BottomLeft <div> area.
3. displays the XHP file patch and bookmark in the #TopRight <div> area

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

1) Media files: Media files in helpcontent2 are located in module 
icons-themes/ . It is necessary to copy core/icon-themes/galaxy into the media/ folder 

Note: For the moment, only Galaxy icon them is fully supported.

2) Run the getbookmark.sh script to generate the bookmark index for the
LibreOffice Modules

----------------------------------------------------------------- 
Folder layout.
----------------------------------------------------------------- 

Root folder:source/
			default.css
			online_transform.xsl
			index.html
			help.js
			jquery<version>-min.js
			media/
				movies/
				screenshots/
			text/


Notes:
1. the online_transform.xsl is main_transform.xsl of HC2 modified to accomodate the layout of the screen, It has 4 <div> hooked in each of the 4 corners of the browser screen to allow resizing.
2. the lower-right <div> displays the help content
3. the upper-left <div> has entries to change help books/modules
4. the upper right <div> is available to place a search mechanism
5. the lower-left <div> is available to inser a index with javascript
6. index.html is just a top landing page.
7. default.css is the css used in helpconten2/languages
8. plenty of simplification/tweak is possible in the XSLT.
9. The whole HC can be tranformed in html with XSLTPROC or any other XSL processor, provided the reference to the XSL file is fixed, and the xsl file be aware of the specifics of the XSL processor.
10. Works with Firefox, Chrome, Rekonq.
11. References to media are incomplete. That will require a change in the urls of the media inside the help pages, thus forking from HC2
