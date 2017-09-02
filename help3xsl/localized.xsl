<?xml version="1.0" encoding="UTF-8"?>

<!--
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->
<!--
Stylesheet map language-dependent parameters and translation
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="getContents">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='en-US'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Conteúdo</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Conteúdo</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Contents</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getIndex">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='en-US'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Index</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getSearch">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='en-US'"><xsl:text>Find</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Find</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Find</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Pesquisar</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Pesquisar</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Find</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getLanguage">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='en-US'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Language</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>
<!-- Token for Google search WIP -->
<xsl:template name="getToken">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='en-US'"><xsl:text>123456</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>123456</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>123456</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>1234567890</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>

