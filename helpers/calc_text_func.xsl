<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

<xsl:param name="func" select="BASE"/>

<xsl:template match="/">
  <xsl:for-each select="//section/h2[text() = $func ]">
  	
  	<xsl:call-template name="section"/>
  </xsl:for-each>
</xsl:template> 

<xsl:template name="section">
  <helpdocument version="1.0">
  <xsl:comment>
    * This file is part of the LibreOffice project.
    *
    * This Source Code Form is subject to the terms of the Mozilla Public
    * License, v. 2.0. If a copy of the MPL was not distributed with this
    * file, You can obtain one at http://mozilla.org/MPL/2.0/.
    *
  </xsl:comment>
  <meta>
    <topic id="calcfunc_{../@id}" indexer="include" status="PUBLISH">
        <title id="tit"><xsl:value-of select="text()"/> Function</title>
        <filename>/text/scalc/01/func_<xsl:value-of select="../@id"/>.xhp</filename>
    </topic>
  </meta>
  <body>
  
    <xsl:copy-of select="preceding-sibling::*"/>
<section id="func_{../@id}">
    <h1 id="{@id}">
      <variable id="{../@id}_h1">
        <link href="text/scalc/01/func_{../@id}.xhp"><xsl:value-of select="text()"/></link>
      </variable>
    </h1>
   <xsl:copy-of select="following-sibling::*[1]"/>

</section>
    <xsl:copy-of select="following-sibling::*[1]/following-sibling::*"/>

  </body>
</helpdocument>
</xsl:template>

</xsl:stylesheet>
