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

<xsl:param name="app"/>
<xsl:param name="local"/>
<xsl:param name="Language"/>
<xsl:param name="productname" select="'LibreOffice'"/>
<xsl:param name="productversion"/>

<xsl:output indent="yes" method="text"/>
<xsl:variable name="online" select="$local!='yes'"/>
<xsl:variable name="target">
    <xsl:choose>
        <xsl:when test="$online"><xsl:value-of select="concat($productversion,'/')"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="''"/></xsl:otherwise>
    </xsl:choose>
</xsl:variable>

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
<!-- Product brand variables used in the help files -->
<xsl:variable name="brand1" select="'$[officename]'"/>
<xsl:variable name="brand2" select="'$[officeversion]'"/>
<xsl:variable name="brand3" select="'%PRODUCTNAME'"/>
<xsl:variable name="brand4" select="'%PRODUCTVERSION'"/>
<!--
#############
# Templates #
#############
//-->

<!-- Extract the bookmarks-->
<xsl:template match="/">
    <xsl:for-each select="//bookmark[@branch='index']">
        <xsl:variable name="hrefhtml" select="substring-before($filename,'xhp')"/>
        <xsl:variable name="href" select="concat($target,$Language,'/',$hrefhtml,'html?DbPAR=',$app,'#',@id)"/>
        <xsl:for-each select="bookmark_value">
        <xsl:text disable-output-escaping="yes"><![CDATA[<a target="_top" href="]]></xsl:text>
        <xsl:value-of select="$href"/>
        <xsl:text disable-output-escaping="yes"><![CDATA[" class="fuseshown ]]></xsl:text>
        <xsl:value-of select="$app"/>
        <xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
            <xsl:call-template name="replace"><xsl:with-param name="text" select="."/></xsl:call-template>
            <xsl:text disable-output-escaping="yes"><![CDATA[</a>\]]>&#xA;</xsl:text>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<xsl:template name="replace">
    <xsl:param name="text"/>
    <xsl:call-template name="brand">
        <xsl:with-param name="string">
            <xsl:call-template name="apostrophe">
                <xsl:with-param name="string">
                    <xsl:choose>
                        <xsl:when test="contains($text,';')">
                            <xsl:value-of select="substring-before($text,';')"/>
                            <xsl:text disable-output-escaping="yes"><![CDATA[ -- ]]></xsl:text>
                            <xsl:value-of select="substring-after($text,';')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$text"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:with-param>
    </xsl:call-template>
</xsl:template>

<!-- weird characters inside bookmarks, replace by HTML entities-->
<xsl:template name="apostrophe">
    <xsl:param name="string"/>
    <xsl:variable name="apost">&apos;</xsl:variable><!-- apostrophe -->
    <xsl:choose>
        <xsl:when test="contains($string,$apost)">
            <xsl:variable name="newstr">
                <xsl:value-of select="substring-before($string,$apost)"/>
                <xsl:text disable-output-escaping="yes"><![CDATA[&]]>#39;</xsl:text>
                <xsl:value-of select="substring-after($string,$apost)"/>
            </xsl:variable>
            <xsl:call-template name="apostrophe">
                <xsl:with-param name="string" select="$newstr"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$string"/>
        </xsl:otherwise>
    </xsl:choose>
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
