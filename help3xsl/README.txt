Helpcontent displayed in a browser
==================================

This directory contains files needed to convert the XHP files to html, and
also the html and css files needed for the actual rendering in the web
browser.

Building and translation of the XHP files is now integrated into the
LibreOffice build process based on gbuild.  If you want to use it, configure
LibreOffice with one of the:

  --with-help=html   (for the local html files)
  --with-help=online (for the html files that can be uploaded to a webserver)

Using the online version
------------------------

When you have configured with --with-help=online, the result of the build is
in

  instdir/help

You want to upload to your webserver like:

  rsync -avz instdir/help/ username@webserver:/srv/www/htdocs/

Then you also need to setup a link 'latest' on the server, like

  ln -s 6.1 latest

and make sure that symlinks are allowed in the webserver configuration.

File descriptions
-----------------

index2.html:

This is the starting point for help when F1 is pressed. The control 'target' is passed in
and then the javascript here does the lookup of the hid2file.js map. If the target is found then that
HTML file is given to the browser with the module and other parameters added, otherwise it substitutes
a default, which is the modules main page.

* default.css:

  the cascading style sheet for HTML formatting.

* online_transform.xsl:

  the XSL transform file. Transform XHP files into HTML files.

  This file is a modification of xmlhelp/util/main_transform.xsl, which was designed for xmlhelp XSL processor.

* help.js

  This javascript file:

  1. modifies href attributes in <a> of #DisplayArea to handle &DbPAR and &System params
  2. picks the bookmarks file and displays in #BottomLeft <div> area.
  3. Reads URL params.

New ‘Object’ tag
----------------

The filter online_transform.xsl now support the <object> tag defined for XHP files to allow a generic object in the browser. The <object> tag now maps to the following HTML5 tags:
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
