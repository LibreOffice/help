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
        <xsl:when test="$lang='ast'"><xsl:text>Conteníu</xsl:text></xsl:when>
        <xsl:when test="$lang='be'"><xsl:text>Змест</xsl:text></xsl:when>
        <xsl:when test="$lang='bg'"><xsl:text>Съдържание</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Obsah</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Indhold</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Inhalte</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Περιεχόμενα</xsl:text></xsl:when>
        <xsl:when test="$lang='en-US'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Contenido</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Contenu</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Contido</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Sadržaj</xsl:text></xsl:when>
        <xsl:when test="$lang='is'"><xsl:text>Efni</xsl:text></xsl:when>
        <xsl:when test="$lang='it'"><xsl:text>Argomenti</xsl:text></xsl:when>
        <xsl:when test="$lang='ja'"><xsl:text>目次</xsl:text></xsl:when>
        <xsl:when test="$lang='lt'"><xsl:text>Turinys</xsl:text></xsl:when>
        <xsl:when test="$lang='nb'"><xsl:text>Innhold</xsl:text></xsl:when>
        <xsl:when test="$lang='nl'"><xsl:text>Inhoud</xsl:text></xsl:when>
        <xsl:when test="$lang='nn'"><xsl:text>Innhald</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Conteúdo</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Conteúdo</xsl:text></xsl:when>
        <xsl:when test="$lang='ru'"><xsl:text>Содержание</xsl:text></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>Vsebina</xsl:text></xsl:when>
        <xsl:when test="$lang='sq'"><xsl:text>Përmbajtja</xsl:text></xsl:when>
        <xsl:when test="$lang='tr'"><xsl:text>İçindekiler</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>目录</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-TW'"><xsl:text>目錄</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Contents</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getIndex">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='ast'"><xsl:text>Índiz</xsl:text></xsl:when>
        <xsl:when test="$lang='be'"><xsl:text>Індэкс</xsl:text></xsl:when>
        <xsl:when test="$lang='bg'"><xsl:text>Индекс</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Rejstřík</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Indeks</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Stichworte</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Ευρετήριο</xsl:text></xsl:when>
        <xsl:when test="$lang='en-US'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Índex</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Indeks</xsl:text></xsl:when>
        <xsl:when test="$lang='is'"><xsl:text>Atriðaskrá</xsl:text></xsl:when>
        <xsl:when test="$lang='it'"><xsl:text>Indice</xsl:text></xsl:when>
        <xsl:when test="$lang='ja'"><xsl:text>索引</xsl:text></xsl:when>
        <xsl:when test="$lang='lt'"><xsl:text>Rodyklė</xsl:text></xsl:when>
        <xsl:when test="$lang='nb'"><xsl:text>Stikkordsliste</xsl:text></xsl:when>
        <xsl:when test="$lang='nl'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='nn'"><xsl:text>Stikkordliste</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:when test="$lang='ru'"><xsl:text>Индекс / Указатель</xsl:text></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>Kazalo</xsl:text></xsl:when>
        <xsl:when test="$lang='sq'"><xsl:text>Indeksi</xsl:text></xsl:when>
        <xsl:when test="$lang='tr'"><xsl:text>Dizin</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>索引</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-TW'"><xsl:text>索引</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Index</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getSearch">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='ast'"><xsl:text>Alcontrar</xsl:text></xsl:when>
        <xsl:when test="$lang='be'"><xsl:text>Пошук</xsl:text></xsl:when>
        <xsl:when test="$lang='bg'"><xsl:text>Търсене</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Najít</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Find</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Suchen</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Εύρεση</xsl:text></xsl:when>
        <xsl:when test="$lang='en-US'"><xsl:text>Find</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Find</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Find</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Buscar</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Recherche</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Buscar</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Pronađi</xsl:text></xsl:when>
        <xsl:when test="$lang='is'"><xsl:text>Leita</xsl:text></xsl:when>
        <xsl:when test="$lang='it'"><xsl:text>Cerca</xsl:text></xsl:when>
        <xsl:when test="$lang='ja'"><xsl:text>検索</xsl:text></xsl:when>
        <xsl:when test="$lang='lt'"><xsl:text>Paieška</xsl:text></xsl:when>
        <xsl:when test="$lang='nb'"><xsl:text>Finn</xsl:text></xsl:when>
        <xsl:when test="$lang='nl'"><xsl:text>Zoeken</xsl:text></xsl:when>
        <xsl:when test="$lang='nn'"><xsl:text>Finn</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Pesquisar</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Localizar</xsl:text></xsl:when>
        <xsl:when test="$lang='ru'"><xsl:text>Искать</xsl:text></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>Najdi</xsl:text></xsl:when>
        <xsl:when test="$lang='sq'"><xsl:text>Gjej</xsl:text></xsl:when>
        <xsl:when test="$lang='tr'"><xsl:text>Bul</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>搜索</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-TW'"><xsl:text>尋找</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Find</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getLanguage">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='ast'"><xsl:text>Llingua</xsl:text></xsl:when>
        <xsl:when test="$lang='be'"><xsl:text>Мова</xsl:text></xsl:when>
        <xsl:when test="$lang='bg'"><xsl:text>Език</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Jazyk</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Sprog</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Sprache</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Γλώσσα</xsl:text></xsl:when>
        <xsl:when test="$lang='en-US'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Langue</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Jezik</xsl:text></xsl:when>
        <xsl:when test="$lang='is'"><xsl:text>Tungumál</xsl:text></xsl:when>
        <xsl:when test="$lang='it'"><xsl:text>Lingua</xsl:text></xsl:when>
        <xsl:when test="$lang='ja'"><xsl:text>言語</xsl:text></xsl:when>
        <xsl:when test="$lang='lt'"><xsl:text>Kalba</xsl:text></xsl:when>
        <xsl:when test="$lang='nb'"><xsl:text>Språk</xsl:text></xsl:when>
        <xsl:when test="$lang='nl'"><xsl:text>Tal</xsl:text></xsl:when>
        <xsl:when test="$lang='nn'"><xsl:text>Språk</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:when test="$lang='ru'"><xsl:text>Язык</xsl:text></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>Jezik</xsl:text></xsl:when>
        <xsl:when test="$lang='sq'"><xsl:text>Gjuha</xsl:text></xsl:when>
        <xsl:when test="$lang='tr'"><xsl:text>Dil</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>语言</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-TW'"><xsl:text>語言</xsl:text></xsl:when>
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

