<?xml version="1.0" encoding="UTF-8"?>

<!--
* This file is part of the LibreOffice project.
*
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->
<!--
Stylesheet to create the localized noscript error page.
xsltproc noscript.xsl <browserhelp.xhp>
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="brand.xsl"/>
<xsl:output indent="yes" method="html"/>
    <xsl:param name="productname"/>
    <xsl:param name="productversion"/>

<xsl:template match="/">
<html>
<head>
</head>
<body>
<div style="margin: 20px">
<h1 style="color: red;">
<xsl:call-template name="brand">
<xsl:with-param name="string"><xsl:value-of select="//variable[@id='noscriptmsg']"/></xsl:with-param>
</xsl:call-template>
</h1>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
