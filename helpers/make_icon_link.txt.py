#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
#
# Generate XSL equivalent for Colibre icon images from link.txt
#

import sys

try:
   # open file stream
   file_icon = open(sys.argv[1], "r")

except IOError:
   print("There was an error reading", file_icon)
   sys.exit()
try:
   # open file stream
   file_xsl = open(sys.argv[2], "w+")

except IOError:
   print("There was an error writing", file_xsl)
   sys.exit()

file_xsl.write('<?xml version="1.0" encoding="UTF-8"?>\n');
file_xsl.write('<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">\n');
file_xsl.write('<xsl:template name="linktxt">\n');
file_xsl.write('<xsl:param name="src1"/>\n');
file_xsl.write('<xsl:choose>\n')

for line in file_icon:
    if line[0] != "#" :
        if line.find('png',0, len(line)) != -1 :
            a = "\'" + line.split()[0] + "\'";
            b = line.split()[1].replace(".png",".svg");
            file_xsl.write('<xsl:when test="$src1=' + a + '"><xsl:text>'+ b + '</xsl:text></xsl:when>\n');

file_xsl.write('<xsl:otherwise><xsl:value-of select="$src1"/></xsl:otherwise>\n');
file_xsl.write('</xsl:choose>\n');
file_xsl.write('</xsl:template>\n');
file_xsl.write('</xsl:stylesheet>\n');

file_xsl.close()
file_icon.close()
sys.exit()
