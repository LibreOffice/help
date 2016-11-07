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
xsltproc get_bookmark.xsl file.xhp
-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="yes" method="html"/>

<!--
############################
# Variables and Parameters #
############################
//-->
<xsl:variable name="filename" select="/helpdocument/meta/topic/filename"/>
<!-- Product brand variables used in the help files -->
<xsl:variable name="brand1" select="'$[officename]'"/>
<xsl:variable name="brand2" select="'$[officeversion]'"/>
<xsl:variable name="brand3" select="'%PRODUCTNAME'"/>
<xsl:variable name="brand4" select="'%PRODUCTVERSION'"/>
<xsl:param name="productname" select="'LibreOffice'"/>
<xsl:param name="productversion" select="'5.2'"/>
<!--
#############
# Templates #
#############
//-->

<!-- Extract the bookmarks-->
<xsl:template match="/">
      <xsl:for-each select="//bookmark[@branch='index']">
           <xsl:variable name="href" select="concat($filename,'#',@id)"/>
           <xsl:for-each select="bookmark_value">
		     <li><a href="{$href}" target="_top">
                     <xsl:apply-templates>
                           <xsl:value-of select="."/>
                     </xsl:apply-templates>
                     </a></li><xsl:text>&#xA;</xsl:text>
           </xsl:for-each>
      </xsl:for-each>
</xsl:template>

<!-- Branding -->
<xsl:template match="text()">
	<xsl:call-template name="brand">
		<xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="brand" >
	<xsl:param name="string"/>

    <xsl:choose>

        <xsl:when test="contains($string,$brand1)">
           <xsl:variable name="newstr">
                <xsl:value-of select="substring-before($string,$brand1)"/>
                <xsl:value-of select="$productname"/>
                <xsl:value-of select="substring-after($string,$brand1)"/>
           </xsl:variable>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="$newstr"/>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="contains($string,$brand2)">
		    <xsl:variable name="newstr">
                <xsl:value-of select="substring-before($string,$brand2)"/>
                <xsl:value-of select="$pversion"/>
                <xsl:value-of select="substring-after($string,$brand2)"/>
           </xsl:variable>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="$newstr"/>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="contains($string,$brand3)">
			<xsl:variable name="newstr">
                <xsl:value-of select="substring-before($string,$brand3)"/>
                <xsl:value-of select="$productname"/>
                <xsl:value-of select="substring-after($string,$brand3)"/>
           </xsl:variable>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="$newstr"/>
			</xsl:call-template>
		</xsl:when>

        <xsl:when test="contains($string,$brand4)">
			    <xsl:variable name="newstr">
                <xsl:value-of select="substring-before($string,$brand4)"/>
                <xsl:value-of select="$pversion"/>
                <xsl:value-of select="substring-after($string,$brand4)"/>
           </xsl:variable>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="$newstr"/>
			</xsl:call-template>
		</xsl:when>

        <xsl:otherwise>
			<xsl:value-of select="$string"/>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

</xsl:stylesheet>
