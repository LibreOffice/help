<?xml version="1.0" encoding="UTF-8"?>

<!--
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->
<!--
Stylesheet to extract index bookmarks from xhp files and output a link to
the xhp file.
Usage:
xsltproc get_bookmark.xsl <file.xhp>
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="yes" method="text"/>

<!--
############################
# Variables and Parameters #
############################
//-->
<xsl:variable name="fname" select="/helpdocument/meta/topic/filename"/>
<xsl:variable name="filename">
    <xsl:choose>
        <xsl:when test="starts-with($fname, '/')">
            <xsl:value-of select="substring($fname, 2)"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$fname"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>
<!--
#############
# Templates #
#############
//-->

<!-- Extract the bookmarks branches x filename-->
<!--Special case for questions marks chars, that interferes in passing
parameters in URLS-->
<xsl:template match="/">
    <xsl:variable name="href" select="concat(substring-before($filename,'xhp'),'html')"/>
    <xsl:for-each select="//bookmark[@branch!='index']">
        <xsl:variable name="aux" select="substring-after(@branch,'hid/')"/>
        <xsl:text>'</xsl:text>
        <xsl:choose>
            <xsl:when test="not(contains($aux,'?'))"><xsl:value-of select="$aux"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="concat(substring-before($aux,'?'),'%3F',substring-after($aux,'?'))"/></xsl:otherwise>
        </xsl:choose>
        <xsl:text>':'</xsl:text>
	<xsl:value-of select="concat($href,'#',@id)"/><xsl:text>',&#xA;</xsl:text>
    </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
