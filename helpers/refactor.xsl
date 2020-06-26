<?xml version="1.0" encoding="UTF-8"?>
<!--
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<!-- remove colspan="" rowspan="" in tablecell -->
<xsl:template match="//tablecell[@colspan='' and @rowspan='']">
<tablecell>
<xsl:if test="@id"><xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute></xsl:if>
<xsl:if test="@width"><xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute></xsl:if>
<xsl:if test="@unit"><xsl:attribute name="unit"><xsl:value-of select="@unit"/></xsl:attribute></xsl:if>
<xsl:if test="@class"><xsl:attribute name="class"><xsl:value-of select="@class"/></xsl:attribute></xsl:if>
<xsl:if test="@localize"><xsl:attribute name="localize"><xsl:value-of select="@localize"/></xsl:attribute></xsl:if>
<xsl:apply-templates/>
</tablecell>
</xsl:template>

<xsl:template match="node()|@*">
    <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
</xsl:template>

<!-- PARAGRAPH -->
<xsl:template match="paragraph">
    <xsl:choose>
         <xsl:when test="@role='heading'">
            <xsl:call-template name="insertheading">
                <xsl:with-param name="level" select="@level"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:when test="@role='note' or @role='tip' or @role='warning'">
            <xsl:call-template name="insertnote">
                <xsl:with-param name="type" select="@role" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
            </xsl:copy>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
<!-- Insert a heading -->
<xsl:template name="insertheading">
        <xsl:param name="level" />
        <xsl:element name="{concat('h',$level)}">
                <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
                <xsl:apply-templates />
        </xsl:element>
</xsl:template>
<!-- Insert Note, Warning, or Tip -->
<xsl:template name="insertnote">
    <xsl:param name="type" /> <!-- note, tip, or warning -->
    <xsl:element name="{$type}">
        <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:apply-templates />
    </xsl:element>
</xsl:template>
</xsl:stylesheet>
