----------------------------------------------------------------- 
Helpcontent displayed in a browser directly from XML 
----------------------------------------------------------------- 

This folder contains components for displaying the Helpcontent2 XML 
pages (XHP) from a webserver and also directly rendered in a modern 
browser. 

----------------------------------------------------------------- 
Background 
----------------------------------------------------------------- 

The XML files must be transformed into HTML files with the help of 
a style sheet file (XSL).

In the current helpcontent2, the processing is done in xmlhelp/ 
module, an ancient XSLT processor developed circa 2005 
(OpenOffice.org 1.5)

Modern browsers such as Firefox, Chrome and Rekonq are capable to 
execute the transformation direcly in the client, by getting an URL 
that returns a XML file that contains the reference of the necessary 
XSL style sheet.

This is the objective of this exercise.

----------------------------------------------------------------- 
File descriptions
----------------------------------------------------------------- 

default.css: 
-------------
the cascading style sheet for HTML formatting.

index.html: 
-----------
A dummy entry web page in the root folder of the server.

online_transform.xsl:
--------------------
the XSL transform file. This file is a modification of 
xmlhelper/util/main_transform.xsl, which was designed for xmlhelp 
XSL processor.

The XSLT online_transform.xsl is highly parametrizable and has params 
and variables ready to handle the proper paths and URLs of the server.

----------------------------------------------------------------- 
How to build the help website
----------------------------------------------------------------- 

Each XHP file of helpcontent2/ must have a reference to the XSL file 
online_transform.xsl, placed in the root folder of the help website.

Therefore it is necessary to copy all XHP files in a temporary folder 
and change the first line, through the script in addxsl2xhp.sh

Media files: Media files in helpcontent2 are located in module 
icons-themes/ . It is necessary to create a media/ folder in the 
webserver and copy the icon-themes folders and files in the right place.

But media in XHP files also depends on the icon theme defined in the 
LibreOffice View options. This issue is not addressed at the moment.

XHP file modified by addxsl2xml.sh script must exist in text/ folder 
in the root folder of the webserver.

----------------------------------------------------------------- 
Folder layout.
----------------------------------------------------------------- 

Root folder
		/
		default.css
		online_transform.xsl
		index.html
		media/
		text/


Notes:
1) The folder text/ is exactly the same as in helpcontent2/ minus the 
first line. The first line has the <xml> declaration followed by the 
<xsl> declaration. NOTHING MORE.

2) the online_transform.xsl is main_transform.xsl of HC2 modified to 
accomodate the layout of the screen, It has 4 <div> hooked in each of 
the 4 corners of the browser screen to allow resizing.

3) the lower-right <div> displays the help content

4) the upper-left <div> has entries to change help books/modules

5) the upper right <div> is available to place a search mechanism

6) the lower-left <div> is available to inser a index with javascript

7) index.html is just a top landing page.

8) default.css is the css used in helpconten2/languages

9) plenty of simplification/tweak is possible in the XSLT.

10) The whole HC can be tranformed in html with XSLTPROC or any other 
XSL processor, provided the reference to the XSL file is fixed, and 
the xsl file be aware of the specifics of the XSL processor.

11) Help pages can be acessed by 
http://<url>/help_file.xhp#<bookmark | section | whatever ID>

12) Works with Firefox, Chrome, Rekonq. MS Edge does not understand 
xml+xsl at first glance, likely to need some config, I guess.

13) References to media are incomplete. That will require a change 
in the urls of the media inside the help pages, thus forking from HC2
