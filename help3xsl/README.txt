-----------------------------------------------------------------
Helpcontent displayed in a browser directly from XML
-----------------------------------------------------------------

This README shows how to display Helpcontent2 XML pages (XHP) directly rendered in a modern browser.

-----------------------------------------------------------------
How to build the LibreOffice Browser help
-----------------------------------------------------------------

new switches in autogen.input

--with-help=html
   generates local help
--with-help=online
   generates online help
--with-lang=lang1 lang2 ...
   help for lang1,  lang2, ...
--with-help=ALL
   help for all supported languages

$> make helpcontent2.clean && make helpcontent2

-----------------------------------------------------------------
Deploying online Help
-----------------------------------------------------------------
Build Help with autogen.input containing
--with-help=online
--with-lang=<l1> <l2> or ALL

$> make helpcontent2.clean && make helpcontent2

$> cd instdir/help
$> tar -czf help.tar.gz index.html help.html 6.1/

upload 'help.tar.gz' to web server root.

Note: the current (6.1) tar'ed file 'help.tar.gz' is ~250MB size



