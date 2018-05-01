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
        <xsl:when test="$lang='ca'"><xsl:text>Contingut</xsl:text></xsl:when>
        <xsl:when test="$lang='ca-valencia'"><xsl:text>Contingut</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Obsah</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Indhold</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Inhalte</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Περιεχόμενα</xsl:text></xsl:when>
        <xsl:when test="$lang='en-US'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Contents</xsl:text></xsl:when>
        <xsl:when test="$lang='eo'"><xsl:text>Enhavo</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Contenido</xsl:text></xsl:when>
        <xsl:when test="$lang='fi'"><xsl:text>Sisällys</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Contenu</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Contido</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Sadržaj</xsl:text></xsl:when>
        <xsl:when test="$lang='hu'"><xsl:text>Tartalom</xsl:text></xsl:when>
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
        <xsl:when test="$lang='ca'"><xsl:text>Índex</xsl:text></xsl:when>
        <xsl:when test="$lang='ca-valencia'"><xsl:text>Índex</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Rejstřík</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Indeks</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Stichworte</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Ευρετήριο</xsl:text></xsl:when>
        <xsl:when test="$lang='en-US'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='eo'"><xsl:text>Indekso</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:when test="$lang='fi'"><xsl:text>Hakemisto</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Index</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Índice</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Indeks</xsl:text></xsl:when>
        <xsl:when test="$lang='hu'"><xsl:text>Tárgymutató</xsl:text></xsl:when>
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

<xsl:template name="getLogo">
    <xsl:param name="lang"/>
    <xsl:param name="version"/>
    <xsl:choose>
        <xsl:when test="$lang='am'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>እርዳታ</xsl:text></xsl:when>
        <xsl:when test="$lang='ar'"><xsl:text>مساعدة %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='as'"><xsl:text>%PRODUCTNAME</xsl:text> <xsl:value-of select="$version"/> <xsl:text>সহায়</xsl:text></xsl:when>
        <xsl:when test="$lang='ast'"><xsl:text>Ayuda de %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='be'"><xsl:text>Даведка %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='bg'"><xsl:text>Помощ за %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='bn'"><xsl:text>%PRODUCTNAME</xsl:text> <xsl:value-of select="$version"/> <xsl:text>সহায়িকা </xsl:text></xsl:when>
        <xsl:when test="$lang='bn-IN'"><xsl:text>%PRODUCTNAME</xsl:text> <xsl:value-of select="$version"/> <xsl:text>সহায়িকা </xsl:text></xsl:when>
        <xsl:when test="$lang='bo'"><xsl:text>%PRODUCTNAME</xsl:text> <xsl:value-of select="$version"/> <xsl:text>རོགས་རམ་སྒེའུ་ཁུང་ </xsl:text></xsl:when>
        <xsl:when test="$lang='br'"><xsl:text>Skoazell %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='brx'"><xsl:text>%PRODUCTNAME</xsl:text> <xsl:value-of select="$version"/> <xsl:text>मदत</xsl:text></xsl:when>
        <xsl:when test="$lang='bs'"><xsl:text>Pomoć za %PRODUCTNAME</xsl:text> <xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='ca'"><xsl:text>Ajuda del %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='ca-valencia'"><xsl:text>Ajuda del %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Nápověda %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='cy'"><xsl:text>Cymorth %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text>Hjælp</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Hilfe für %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='dz'"><xsl:text>%PRODUCTNAME</xsl:text> <xsl:value-of select="$version"/> <xsl:text>རོགས་རམ། </xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Βοήθεια του %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='eo'"><xsl:text>Helpo de %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Ayuda de %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='et'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>abi</xsl:text></xsl:when>
        <xsl:when test="$lang='eu'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>Laguntza</xsl:text></xsl:when>
        <xsl:when test="$lang='fi'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>Ohje</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Aide %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Axuda do %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='gu'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>મદદ</xsl:text></xsl:when>
        <xsl:when test="$lang='hi'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>मदद</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>pomoć</xsl:text></xsl:when>
        <xsl:when test="$lang='hu'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>Súgó</xsl:text></xsl:when>
        <xsl:when test="$lang='id'"><xsl:text>Bantuan %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='is'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>Hjálp</xsl:text></xsl:when>
        <xsl:when test="$lang='it'"><xsl:text>Guida di %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='ja'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>ヘルプ</xsl:text></xsl:when>
        <xsl:when test="$lang='ka'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>დახმარება</xsl:text></xsl:when>
        <xsl:when test="$lang='km'"><xsl:text>ជំនួយ %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='ko'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>도움말</xsl:text></xsl:when>
        <xsl:when test="$lang='lt'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>žinynas</xsl:text></xsl:when>
        <xsl:when test="$lang='lv'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>Palīdzība</xsl:text></xsl:when>
        <xsl:when test="$lang='mk'"><xsl:text>Помош за %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='nb'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>Hjelp</xsl:text></xsl:when>
        <xsl:when test="$lang='ne'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>मद्दत</xsl:text></xsl:when>
        <xsl:when test="$lang='nl'"><xsl:text>Help voor %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='nn'"><xsl:text>Hjelp for %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='om'"><xsl:text>Gargaarsa %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='pl'"><xsl:text>Pomoc %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Ajuda do %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Ajuda do %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='ro'"><xsl:text>Manualul %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='ru'"><xsl:text>Справка %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='si'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text> උදව්</xsl:text></xsl:when>
        <xsl:when test="$lang='sid'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/> <xsl:text>Kaa'lo</xsl:text></xsl:when>
        <xsl:when test="$lang='sk'"><xsl:text>Pomocník %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>Pomoč %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='sq'"><xsl:text>Ndihma për %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='sv'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text>-hjälp</xsl:text></xsl:when>
        <xsl:when test="$lang='ta'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text>உதவி</xsl:text></xsl:when>
        <xsl:when test="$lang='tg'"><xsl:text>Кӯмаки %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='tr'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text>Yardım</xsl:text></xsl:when>
        <xsl:when test="$lang='ug'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text> ياردەم كۆزنىكى</xsl:text></xsl:when>
        <xsl:when test="$lang='uk'"><xsl:text>Довідка %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='vi'"><xsl:text>Trợ giúp %PRODUCTNAME </xsl:text><xsl:value-of select="$version"/></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text> 帮助</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-TW'"><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text> 說明</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>%PRODUCTNAME </xsl:text><xsl:value-of select="$version"/><xsl:text> Help</xsl:text></xsl:otherwise>
    </xsl:choose>
</xsl:template>
<xsl:template name="getModules">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='am'"><xsl:text>ክፍል</xsl:text></xsl:when>
        <xsl:when test="$lang='ast'"><xsl:text>Aplicación</xsl:text></xsl:when>
        <xsl:when test="$lang='bg'"><xsl:text>Модул</xsl:text></xsl:when>
        <xsl:when test="$lang='bn'"><xsl:text>মডিউল</xsl:text></xsl:when>
        <xsl:when test="$lang='bs'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='ca'"><xsl:text>Aplicació</xsl:text></xsl:when>
        <xsl:when test="$lang='ca-valencia'"><xsl:text>Aplicació</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Άρθρωμα</xsl:text></xsl:when>
        <xsl:when test="$lang='eo'"><xsl:text>Aplikaĵo</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Aplicación</xsl:text></xsl:when>
        <xsl:when test="$lang='et'"><xsl:text>Moodul</xsl:text></xsl:when>
        <xsl:when test="$lang='eu'"><xsl:text>Modulua</xsl:text></xsl:when>
        <xsl:when test="$lang='fi'"><xsl:text>Moduuli</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Aplicación</xsl:text></xsl:when>
        <xsl:when test="$lang='gu'"><xsl:text>મોડ્યુલ</xsl:text></xsl:when>
        <xsl:when test="$lang='hi'"><xsl:text>मॉडयूल</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='hu'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='id'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='is'"><xsl:text>Eining</xsl:text></xsl:when>
        <xsl:when test="$lang='it'"><xsl:text>Modulo</xsl:text></xsl:when>
        <xsl:when test="$lang='ja'"><xsl:text>モジュール</xsl:text></xsl:when>
        <xsl:when test="$lang='km'"><xsl:text>ម៉ូឌុល</xsl:text></xsl:when>
        <xsl:when test="$lang='ko'"><xsl:text>모듈</xsl:text></xsl:when>
        <xsl:when test="$lang='lv'"><xsl:text>Modulis</xsl:text></xsl:when>
        <xsl:when test="$lang='mk'"><xsl:text>Модул</xsl:text></xsl:when>
        <xsl:when test="$lang='ne'"><xsl:text>मोड्युल</xsl:text></xsl:when>
        <xsl:when test="$lang='nn'"><xsl:text>Modular</xsl:text></xsl:when>
        <xsl:when test="$lang='om'"><xsl:text>Mojuulii</xsl:text></xsl:when>
        <xsl:when test="$lang='pl'"><xsl:text>Moduł</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Módulo</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Módulo</xsl:text></xsl:when>
        <xsl:when test="$lang='ru'"><xsl:text>Модуль</xsl:text></xsl:when>
        <xsl:when test="$lang='sid'"><xsl:text>Mojule</xsl:text></xsl:when>
        <xsl:when test="$lang='sk'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>Modul</xsl:text></xsl:when>
        <xsl:when test="$lang='sq'"><xsl:text>Moduli</xsl:text></xsl:when>
        <xsl:when test="$lang='ta'"><xsl:text>நிரல்கூறு</xsl:text></xsl:when>
        <xsl:when test="$lang='tg'"><xsl:text>Модул</xsl:text></xsl:when>
        <xsl:when test="$lang='tr'"><xsl:text>Modül</xsl:text></xsl:when>
        <xsl:when test="$lang='ug'"><xsl:text>بۆلەك</xsl:text></xsl:when>
        <xsl:when test="$lang='uk'"><xsl:text>Модуль</xsl:text></xsl:when>
        <xsl:when test="$lang='vi'"><xsl:text>Mô đun</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>组件</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-TW'"><xsl:text>模組</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>Module</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getLanguage">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='ast'"><xsl:text>Llingua</xsl:text></xsl:when>
        <xsl:when test="$lang='be'"><xsl:text>Мова</xsl:text></xsl:when>
        <xsl:when test="$lang='bg'"><xsl:text>Език</xsl:text></xsl:when>
        <xsl:when test="$lang='ca'"><xsl:text>Llengua</xsl:text></xsl:when>
        <xsl:when test="$lang='ca-valencia'"><xsl:text>Llengua</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>Jazyk</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>Sprog</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>Sprache</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>Γλώσσα</xsl:text></xsl:when>
        <xsl:when test="$lang='en-US'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='en-GB'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='en-ZA'"><xsl:text>Language</xsl:text></xsl:when>
        <xsl:when test="$lang='eo'"><xsl:text>Lingvo</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:when test="$lang='fi'"><xsl:text>Kieli</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>Langue</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Idioma</xsl:text></xsl:when>
        <xsl:when test="$lang='hr'"><xsl:text>Jezik</xsl:text></xsl:when>
        <xsl:when test="$lang='hu'"><xsl:text>Nyelv</xsl:text></xsl:when>
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
        <xsl:when test="$lang='en-US'"><xsl:text>var cx = '010161382024564278136:stzujqtpnve';</xsl:text></xsl:when>
        <xsl:when test="$lang='ca'"><xsl:text>var cx = '010161382024564278136:lcrnyzte-bs';</xsl:text></xsl:when>
        <xsl:when test="$lang='ca-valencia'"><xsl:text>var cx = '010161382024564278136:lcrnyzte-bs';</xsl:text></xsl:when>
        <xsl:when test="$lang='cs'"><xsl:text>var cx = '010161382024564278136:ruz0pcebqyi';</xsl:text></xsl:when>
        <xsl:when test="$lang='da'"><xsl:text>var cx = '010161382024564278136:icywq-zn8hi';</xsl:text></xsl:when>
        <xsl:when test="$lang='de'"><xsl:text>var cx = '010161382024564278136:5xb_5bltsto';</xsl:text></xsl:when>
        <xsl:when test="$lang='el'"><xsl:text>var cx = '010161382024564278136:6ihy44_5qqu';</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>var cx = '010161382024564278136:cdcn_oz4txg';</xsl:text></xsl:when>
        <xsl:when test="$lang='fi'"><xsl:text>var cx = '010161382024564278136:op1o8h6jnu8';</xsl:text></xsl:when>
        <xsl:when test="$lang='fr'"><xsl:text>var cx = '010161382024564278136:mimp7dbi-eq';</xsl:text></xsl:when>
        <xsl:when test="$lang='hu'"><xsl:text>var cx = '010161382024564278136:imtiawlmhnk';</xsl:text></xsl:when>
        <xsl:when test="$lang='it'"><xsl:text>var cx = '010161382024564278136:xdxa9y906g0';</xsl:text></xsl:when>
        <xsl:when test="$lang='ja'"><xsl:text>var cx = '010161382024564278136:7wxg-zakzmu';</xsl:text></xsl:when>
        <xsl:when test="$lang='ko'"><xsl:text>var cx = '010161382024564278136:czaiuh5qxzu';</xsl:text></xsl:when>
        <xsl:when test="$lang='nl'"><xsl:text>var cx = '010161382024564278136:ndba33-gnzq';</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>var cx = '010161382024564278136:1x2uk8j-rbw';</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>var cx = '010161382024564278136:1x2uk8j-rbw';</xsl:text></xsl:when>
        <xsl:when test="$lang='ru'"><xsl:text>var cx = '010161382024564278136:syzgysikzms';</xsl:text></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>var cx = '010161382024564278136:5varjpouixi';</xsl:text></xsl:when>
        <xsl:when test="$lang='tr'"><xsl:text>var cx = '010161382024564278136:gzcz3ueyhkw';</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>var cx = '010161382024564278136:vkf9curztm8';</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-TW'"><xsl:text>var cx = '010161382024564278136:_goysgr6ptm';</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>var cx = '010161382024564278136:stzujqtpnve';</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="getTooltip">
    <xsl:param name="lang"/>
    <xsl:attribute name="data-tooltip">
        <xsl:choose>
            <xsl:when test="$lang='ast'">Faiga clic nel testu para copialo nel cartafueyu</xsl:when>
            <xsl:when test="$lang='ca'">Feu clic al text per a copiar-lo al porta-retalls</xsl:when>
            <xsl:when test="$lang='ca-valencia'">Feu clic al text per a copiar-lo al porta-retalls</xsl:when>
            <xsl:when test="$lang='eo'">Alklaku la tekston por kopii ĝin al la tondejo</xsl:when>
            <xsl:when test="$lang='es'">Pulse en el texto para copiarlo en el portapapeles</xsl:when>
            <xsl:when test="$lang='fi'">Klikkaa kopioidaksesi leikepöydälle</xsl:when>
            <xsl:when test="$lang='gl'">Prema no texto para copialo no portarretallos</xsl:when>
            <xsl:when test="$lang='pt'">Clique no texto para copiar para a área de transferência</xsl:when>
            <xsl:when test="$lang='pt-BR'">Clique no texto para copiar para a área de transferência</xsl:when>
            <xsl:otherwise>Click on text to copy to clipboard</xsl:otherwise>
        </xsl:choose>
    </xsl:attribute>
</xsl:template>

<xsl:template name="getDonation">
    <xsl:param name="lang"/>
    <xsl:choose>
        <xsl:when test="$lang='ast'"><xsl:text>Si esta páxina resultó-y útil, puede sofitanos con una donación.</xsl:text></xsl:when>
        <xsl:when test="$lang='ca'"><xsl:text>Si aquesta pàgina us ha sigut útil, podeu col·laborar-hi amb una donació.</xsl:text></xsl:when>
        <xsl:when test="$lang='ca-valencia'"><xsl:text>Si esta pàgina us ha sigut útil, podeu col·laborar-hi amb una donació.</xsl:text></xsl:when>
        <xsl:when test="$lang='eo'"><xsl:text>Se ĉi tiu paĝo estis utila por vi, vi povas subteni nin.</xsl:text></xsl:when>
        <xsl:when test="$lang='es'"><xsl:text>Si esta página le ha sido útil, puede apoyarnos con una donación.</xsl:text></xsl:when>
        <xsl:when test="$lang='gl'"><xsl:text>Si esta páxina resultoulle útil, pode apoiarnos cunha doazón.</xsl:text></xsl:when>
        <xsl:when test="$lang='nb'"><xsl:text>Hvis du har funnet denne siden nyttig kan du bidra.</xsl:text></xsl:when>
        <xsl:when test="$lang='pt'"><xsl:text>Se esta página lhe foi útil, dê-nos seu apoio!</xsl:text></xsl:when>
        <xsl:when test="$lang='pt-BR'"><xsl:text>Se esta página lhe foi útil, dê-nos seu apoio!</xsl:text></xsl:when>
        <xsl:when test="$lang='sl'"><xsl:text>Če vam je stran v pomoč, nam lahko pomagate!</xsl:text></xsl:when>
        <xsl:when test="$lang='zh-CN'"><xsl:text>如果这个页面对您有帮助，请支持我们！</xsl:text></xsl:when>
        <xsl:otherwise><xsl:text>If this page has been helpful, you can support us!</xsl:text></xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>

