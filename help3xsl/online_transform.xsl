<?xml version="1.0" encoding="UTF-8"?>
<!--
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * This file incorporates work covered by the following license notice:
 *
 *   Licensed to the Apache Software Foundation (ASF) under one or more
 *   contributor license agreements. See the NOTICE file distributed
 *   with this work for additional information regarding copyright
 *   ownership. The ASF licenses this file to you under the Apache
 *   License, Version 2.0 (the "License"); you may not use this file
 *   except in compliance with the License. You may obtain a copy of
 *   the License at http://www.apache.org/licenses/LICENSE-2.0 .
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="yes" method="html" doctype-system= "about:legacy-compat"/>

<!--
############################
# Variables and Parameters #
############################
//-->

<xsl:param name="productversion"/>


<!-- General Usage -->
<xsl:variable name="am" select="'&amp;'"/>
<xsl:variable name="sl" select="'/'"/>
<xsl:variable name="qt" select="'&quot;'"/>

<!-- For calculating pixel sizes -->
<xsl:variable name="dpi" select="'96'"/>
<xsl:variable name="dpcm" select="'38'"/>
<xsl:variable name="dpmm" select="'3.8'"/>

<!-- Product brand variables used in the help files -->
<xsl:variable name="brand1" select="'$[officename]'"/>
<xsl:variable name="brand2" select="'$[officeversion]'"/>
<xsl:variable name="brand3" select="'%PRODUCTNAME'"/>
<xsl:variable name="brand4" select="'%PRODUCTVERSION'"/>

<!-- meta data variables from the help file -->
<xsl:variable name="filename" select="/helpdocument/meta/topic/filename"/>
<xsl:variable name="title" select="/helpdocument/meta/topic/title"/>

<!-- Module and the corresponding switching values-->
<xsl:param name="Database" select="'swriter'"/>
<xsl:variable name="module" select="$Database"/>
<xsl:variable name="appl">
    <xsl:choose>
        <xsl:when test="$module = 'swriter'"><xsl:value-of select="'WRITER'"/></xsl:when>
        <xsl:when test="$module = 'scalc'"><xsl:value-of select="'CALC'"/></xsl:when>
        <xsl:when test="$module = 'sdraw'"><xsl:value-of select="'DRAW'"/></xsl:when>
        <xsl:when test="$module = 'simpress'"><xsl:value-of select="'IMPRESS'"/></xsl:when>
        <xsl:when test="$module = 'schart'"><xsl:value-of select="'CHART'"/></xsl:when>
        <xsl:when test="$module = 'sbasic'"><xsl:value-of select="'BASIC'"/></xsl:when>
        <xsl:when test="$module = 'smath'"><xsl:value-of select="'MATH'"/></xsl:when>
    </xsl:choose>
</xsl:variable>

  <!-- the other parameters given by the help caller -->
<xsl:param name="System" select="'WIN'"/>
<xsl:param name="productname" select="'LibreOffice'"/>

<xsl:variable name="pversion">
	<xsl:value-of select="translate($productversion,' ','')"/>
</xsl:variable>
<!-- this is were the images are -->

<xsl:param name="imgtheme" select="''"/>
<xsl:param name="Id" />
<xsl:param name="Language"/>
<xsl:param name="root"/>
<xsl:variable name="lang" select="$Language"/>
<xsl:variable name="urlpre" select="$root"/>

<!-- generic Icon alt text -->
<xsl:variable name="alttext" select="concat($root,'text/shared/00/icon_alt.xhp')"/>

<xsl:param name="ExtensionId" select="''"/>
<xsl:param name="ExtensionPath" select="''"/>


  <!-- parts of help and image urls -->
<!--<xsl:variable name="help_url_prefix" select="'vnd.sun.star.help://'"/>-->
<xsl:variable name="help_url_prefix" select="''"/>

<xsl:variable name="img_url_internal" select="$productversion"/>
<xsl:variable name="img_url_prefix" select="concat($productversion,'/media',$imgtheme,'/')"/>
<xsl:variable name="urlpost" select="concat('?Language=',$lang,$am,'System=',$System,$am,'UseDB=no')"/>
<!-- <xsl:variable name="urlpre" select="$help_url_prefix" /> -->
<xsl:variable name="linkprefix" select="concat($productversion,'/',$lang,'/')"/>
<!--<xsl:variable name="linkpostfix" select="$urlpost"/>-->
<xsl:variable name="linkpostfix" select="''"/>

<!-- images for notes, tips and warnings -->
<xsl:variable name="note_img" select="concat($img_url_prefix,'helpimg/note.png')"/>
<xsl:variable name="tip_img" select="concat($img_url_prefix,'helpimg/tip.png')"/>
<xsl:variable name="warning_img" select="concat($img_url_prefix,'helpimg/warning.png')"/>

<!--
########################
# Schema.org variables #
######################## 
//-->

<!--
#############
# Templates #
#############
//-->

<!-- Create the document skeleton -->
<xsl:template match="/">
    <xsl:variable name="htmlpage"><xsl:call-template name="filehtml"><xsl:with-param name="file" select="$filename"/></xsl:call-template></xsl:variable>
    <xsl:variable name="titleL10N">
        <xsl:call-template name="brand"><xsl:with-param name="string"><xsl:value-of select="$title"/></xsl:with-param></xsl:call-template>
    </xsl:variable>
    <html>
    <head>
        <!--<base href="file:///home/tdf/git/core/helpcontent2/source/html/"/> -->
        <base href="/"/>
        <title><xsl:value-of select="$titleL10N"/></title>
        <link href="{$productversion}/default.css" rel="Stylesheet" type="text/css" />
        <script type="text/javascript" src="{$productversion}/jquery-3.1.1.min.js"></script>
        <script type="text/javascript" src="{$productversion}/help.js"></script>
        <!-- Piwik -->
        <script type="text/javascript">
            <![CDATA[
            var _paq = _paq || [];
            /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
            _paq.push(['trackPageView']);
            _paq.push(['enableLinkTracking']);
            (function() {
            var u="//piwik.documentfoundation.org/";
            _paq.push(['setTrackerUrl', u+'piwik.php']);
            _paq.push(['setSiteId', '68']);
            var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
            g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
            })();
            ]]>
        </script>
        <!-- End Piwik Code -->
        <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width,initial-scale=1"/>
    </head>
    <body lang="{$lang}" itemscope="true" itemtype="http://schema.org/TechArticle">
    <meta itemprop="version" content="{$productversion}"/>
    <meta itemprop="inLanguage" content="{$lang}"/>
    <meta itemprop="datePublished" content="2017"/>
    <meta itemprop="headline" content="$titleL10N"/>
    <header>
        <nav>
            <select name="modules">
                <option id="M_CALC" value="{$productversion}/{$lang}/text/scalc/main0000.html?DbPAR=CALC">Calc</option>
                <option id="M_WRITER" value="{$productversion}/{$lang}/text/swriter/main0000.html?DbPAR=WRITER">Writer</option>
                <option id="M_IMPRESS" value="{$productversion}/{$lang}/text/simpress/main0000.html?DbPAR=IMPRESS">Impress</option>
                <option id="M_DRAW" value="{$productversion}/{$lang}/text/sdraw/main0000.html?DbPAR=DRAW">Draw</option>
                <option id="M_CHART" value="{$productversion}/{$lang}/text/schart/main0000.html?DbPAR=CHART">Chart</option>
                <option id="M_BASIC" value="{$productversion}/{$lang}/text/sbasic/shared/main0601.html?DbPAR=BASIC">Basic</option>
                <option id="M_MATH" value="{$productversion}/{$lang}/text/smath/main0000.html?DbPAR=MATH">Math</option>
                <option id="M_BASE" value="{$productversion}/{$lang}/text/shared/explorer/database/main.html?DbPAR=BASE">Base</option>
            </select>
            <select name="system">
                <option id="S_WIN" value="{$productversion}/{$lang}{$htmlpage}?System=WIN">Windows</option>
                <option id="S_UNIX" value="{$productversion}/{$lang}{$htmlpage}?System=UNIX">Linux</option>
                <option id="S_MAC" value="{$productversion}/{$lang}{$htmlpage}?System=MAC">Mac</option>
            </select>
            <select name="language">
                <option value="{$productversion}/en-US{$htmlpage}">EN-US</option>
                <option value="{$productversion}/am{$htmlpage}">AM</option>
                <option value="{$productversion}/ar{$htmlpage}">AR</option>
                <option value="{$productversion}/ast{$htmlpage}">AST</option>
                <option value="{$productversion}/bg{$htmlpage}">BG</option>
                <option value="{$productversion}/bn{$htmlpage}">BN</option>
                <option value="{$productversion}/bn-IN{$htmlpage}">BN-IN</option>
                <option value="{$productversion}/bo{$htmlpage}">BO</option>
                <option value="{$productversion}/bs{$htmlpage}">BS</option>
                <option value="{$productversion}/ca{$htmlpage}">CA</option>
                <option value="{$productversion}/ca-valencia{$htmlpage}">CA-Valencia</option>
                <option value="{$productversion}/cs{$htmlpage}">CS</option>
                <option value="{$productversion}/da{$htmlpage}">DA</option>
                <option value="{$productversion}/de{$htmlpage}">DE</option>
                <option value="{$productversion}/dz{$htmlpage}">DZ</option>
                <option value="{$productversion}/el{$htmlpage}">EL</option>
                <option value="{$productversion}/en-GB{$htmlpage}">EN-GB</option>
                <option value="{$productversion}/en-ZA{$htmlpage}">EN-ZA</option>
                <option value="{$productversion}/eo{$htmlpage}">EO</option>
                <option value="{$productversion}/es{$htmlpage}">ES</option>
                <option value="{$productversion}/et{$htmlpage}">ET</option>
                <option value="{$productversion}/eu{$htmlpage}">EU</option>
                <option value="{$productversion}/fi{$htmlpage}">FI</option>
                <option value="{$productversion}/fr{$htmlpage}">FR</option>
                <option value="{$productversion}/gl{$htmlpage}">GL</option>
                <option value="{$productversion}/gu{$htmlpage}">GU</option>
                <option value="{$productversion}/he{$htmlpage}">HE</option>
                <option value="{$productversion}/hi{$htmlpage}">HI</option>
                <option value="{$productversion}/hr{$htmlpage}">HR</option>
                <option value="{$productversion}/hu{$htmlpage}">HU</option>
                <option value="{$productversion}/id{$htmlpage}">ID</option>
                <option value="{$productversion}/is{$htmlpage}">IS</option>
                <option value="{$productversion}/it{$htmlpage}">IT</option>
                <option value="{$productversion}/ja{$htmlpage}">JA</option>
                <option value="{$productversion}/ka{$htmlpage}">KA</option>
                <option value="{$productversion}/km{$htmlpage}">KM</option>
                <option value="{$productversion}/ko{$htmlpage}">KO</option>
                <option value="{$productversion}/lo{$htmlpage}">LO</option>
                <option value="{$productversion}/lt{$htmlpage}">LT</option>
                <option value="{$productversion}/lv{$htmlpage}">LV</option>
                <option value="{$productversion}/mk{$htmlpage}">MK</option>
                <option value="{$productversion}/nb{$htmlpage}">NB</option>
                <option value="{$productversion}/ne{$htmlpage}">NE</option>
                <option value="{$productversion}/nl{$htmlpage}">NL</option>
                <option value="{$productversion}/nn{$htmlpage}">NN</option>
                <option value="{$productversion}/om{$htmlpage}">OM</option>
                <option value="{$productversion}/pl{$htmlpage}">PL</option>
                <option value="{$productversion}/pt{$htmlpage}">PT</option>
                <option value="{$productversion}/pt-BR{$htmlpage}">PT-BR</option>
                <option value="{$productversion}/ro{$htmlpage}">RO</option>
                <option value="{$productversion}/ru{$htmlpage}">RU</option>
                <option value="{$productversion}/sid{$htmlpage}">SID</option>
                <option value="{$productversion}/sk{$htmlpage}">SK</option>
                <option value="{$productversion}/sl{$htmlpage}">SL</option>
                <option value="{$productversion}/sq{$htmlpage}">SQ</option>
                <option value="{$productversion}/sv{$htmlpage}">SV</option>
                <option value="{$productversion}/ta{$htmlpage}">TA</option>
                <option value="{$productversion}/tg{$htmlpage}">TG</option>
                <option value="{$productversion}/tr{$htmlpage}">TR</option>
                <option value="{$productversion}/ug{$htmlpage}">UG</option>
                <option value="{$productversion}/uk{$htmlpage}">UK</option>
                <option value="{$productversion}/vi{$htmlpage}">VI</option>
                <option value="{$productversion}/zh-CN{$htmlpage}">ZH-CN</option>
                <option value="{$productversion}/zh-TW{$htmlpage}">ZH-TW</option>
            </select>
            <script type="text/javascript">
                <![CDATA[
                document.addEventListener('DOMContentLoaded',function() {
                document.querySelector('select[name="modules"]').onchange=changeModuleHandler;
                document.querySelector('select[name="system"]').onchange=changeSystemHandler;
                document.querySelector('select[name="language"]').onchange=changeLangHandler;
                },false);

                function changeModuleHandler(event) {
                // You can use “this” to refer to the selected element.
                var system = getParameterByName("System");
                window.open('/'+event.target.value + '&System=' + system,'_self');
                }
                function changeSystemHandler(event) {
                // You can use “this” to refer to the selected element.
                var module = getParameterByName("DbPAR");
                window.open('/'+event.target.value + '&DbPAR=' + module,'_self');
                }
                function changeLangHandler(event) {
                // You can use “this” to refer to the selected element.
                var system = getParameterByName("System");
                var module = getParameterByName("DbPAR");
                window.open('/' + event.target.value  + '?DbPAR=' + module + '&System=' + system ,'_self');
                }
                ]]>
            </script>
        </nav>
        <h1>LibreOffice <xsl:value-of select="$productversion"/><br/>Help Online</h1>
    </header>
    <section id="tabs">
        <article data-title="{$titleL10N}">
            <div id="DisplayArea" itemprop="articleBody">
                <xsl:apply-templates select="/helpdocument/body"/>
            </div>
        </article>
        <article id="Index" data-title="Index">
            <div id="SearchBox"><p>&#32;&#x1f50e;&#32;<input type="text" id="search-bar"/></p></div>
            <div id="Bookmarks">
                <ul id="bookmarkCALC" hidden="true"></ul>
                <ul id="bookmarkCHART" hidden="true"></ul>
                <ul id="bookmarkWRITER" hidden="true"></ul>
                <ul id="bookmarkDRAW" hidden="true"></ul>
                <ul id="bookmarkIMPRESS" hidden="true"></ul>
                <ul id="bookmarkMATH" hidden="true"></ul>
                <ul id="bookmarkBASE" hidden="true"></ul>
                <ul id="bookmarkSHARED"></ul>
                <ul id="bookmarkBASIC" hidden="true"></ul>
            </div>
        </article>
        <article data-title="Search">
            <div id="TopRight">
                <script type="text/javascript">
                    <![CDATA[
                    (function() {
                    var cx = '010161382024564278136:oejldkqc20o';
                    var gcse = document.createElement('script');
                    gcse.type = 'text/javascript';
                    gcse.async = true;
                    gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
                    var s = document.getElementsByTagName('script')[0];
                    s.parentNode.insertBefore(gcse, s);
                    })();
                    ]]>
                </script>
                <xsl:text disable-output-escaping="yes">&lt;gcse:search&gt;&lt;/gcse:search&gt;</xsl:text>
            </div>
            <a href="#" onClick="myTabs.next(); return false">Come back to first tab</a>
        </article>
        <article data-title="Contents">
            <h2>Tree</h2>
            <p>TBD</p>
            <a href="#" onClick="myTabs.next(); return false">Finished ? Go to the next tab</a>
        </article>
    </section>
    <footer>
        <p><a href="http://www.libreoffice.org/imprint" target="_blank">Impressum (Legal Info)</a> | <a href="http://www.libreoffice.org/privacy" target="_blank">Privacy Policy</a> | <a href="http://www.documentfoundation.org/statutes.pdf" target="_blank">Statutes (non-binding English translation)</a> - <a href="http://www.documentfoundation.org/satzung.pdf" target="_blank">Satzung (binding German version)</a> | Copyright information: Unless otherwise specified, all text and images on this website are licensed under the <a href="http://creativecommons.org/licenses/by-sa/3.0/" target="_blank">Creative Commons Attribution-Share Alike 3.0 License</a>. This does not include the source code of LibreOffice, which is licensed under the <a href="http://www.libreoffice.org/download/license/" target="_blank">Mozilla Public License v2.0</a>. “LibreOffice” and “The Document Foundation” are registered trademarks of their corresponding registered owners or are in actual use as trademarks in one or more countries. Their respective logos and icons are also subject to international copyright laws. Use thereof is explained in our <a href="http://wiki.documentfoundation.org/TradeMark_Policy" target="_blank">trademark policy</a>. LibreOffice was based on OpenOffice.org.</p>
    </footer>
    <footer>
        <div class="debug">
            <h3 class="bug">Help content debug info:</h3>
            <p>This page is: <xsl:value-of select="$filename"/></p>
            <p>Title is: <xsl:value-of select="$title"/></p>
            <p id="bm_module"></p>
            <p id="bm_system"></p>
        </div>
    </footer>
    <script type="text/javascript">
        <![CDATA[
        var module = getParameterByName("DbPAR");
        setModule(module);
        var system = getParameterByName("System");
        setSystem(system);
        fixURL(module,system);
        document.getElementById("bm_module").innerHTML ="Module is: "+module;
        document.getElementById("bm_system").innerHTML ="System is: "+system;
        ]]>
    </script>
    <script type="text/javascript" src="{$productversion}/{$lang}/bookmarks.js"/>
    <script type="text/javascript" src="{$productversion}/tabs.js"></script>
    <script>
        var myTabs = new tabs(document.getElementById("tabs"), "article", "h2").responsive("myTabs", {
        prev: "Previous",
        next: "Next"
        });
    </script>

</body>
</html>
</xsl:template>

<!-- AHELP -->
<xsl:template match="ahelp">
	<xsl:if test="not(@visibility='hidden')"><span class="avis"><xsl:apply-templates /></span></xsl:if>
</xsl:template>

<!-- ALT -->
<xsl:template match="alt"/>

<!-- MATHML -->
<xsl:template match="math">
<div class="mathml"><xsl:apply-templates /></div>
</xsl:template>

<!-- BOOKMARK -->
<xsl:template match="bookmark">
	<a name="{@id}"></a>
	<xsl:choose>
		<xsl:when test="starts-with(@branch,'hid')" />
		<xsl:otherwise><xsl:apply-templates /></xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="bookmark" mode="embedded" />

<!-- BOOKMARK_VALUE -->
<xsl:template match="bookmark_value">
    <xsl:element name="meta">
        <xsl:attribute name="itemprop">keywords</xsl:attribute>
        <xsl:attribute name="content"><xsl:value-of select="translate(.,';',',')"/></xsl:attribute>
    </xsl:element>
</xsl:template>

<!-- BR -->
<xsl:template match="br"><br /></xsl:template>

<!-- CAPTION -->
<xsl:template match="caption" />

<!-- CASE -->
<xsl:template match="case"><xsl:call-template name="insertcase" /></xsl:template>
<xsl:template match="case" mode="embedded">
	<xsl:call-template name="insertcase">
		<xsl:with-param name="embedded" select="'yes'"/>
	</xsl:call-template>
</xsl:template>

<!-- CASEINLINE -->
<xsl:template match="caseinline"><xsl:call-template name="insertcase" /></xsl:template>
<xsl:template match="caseinline" mode="embedded">
	<xsl:call-template name="insertcase">
		<xsl:with-param name="embedded" select="'yes'"/>
	</xsl:call-template>
</xsl:template>

<!-- COMMENT -->
<xsl:template match="comment" />
<xsl:template match="comment" mode="embedded"/>

<!-- CREATED -->
<xsl:template match="created" />

<!-- DEFAULT -->
<xsl:template match="default"><xsl:call-template name="insertdefault" /></xsl:template>
<xsl:template match="default" mode="embedded">
	<xsl:call-template name="insertdefault">
		<xsl:with-param name="embedded" select="'yes'"/>
	</xsl:call-template>
</xsl:template>

<!-- DEFAULTINLINE -->
<xsl:template match="defaultinline"><xsl:call-template name="insertdefault" /></xsl:template>
<xsl:template match="defaultinline" mode="embedded">
	<xsl:call-template name="insertdefault">
		<xsl:with-param name="embedded" select="'yes'"/>
	</xsl:call-template>
</xsl:template>

<!-- EMBED -->
<xsl:template match="embed"><xsl:call-template name="resolveembed"/></xsl:template>
<xsl:template match="embed" mode="embedded"><xsl:call-template name="resolveembed"/></xsl:template>

<!-- EMBEDVAR -->
<xsl:template match="embedvar"><xsl:call-template name="resolveembedvar"/></xsl:template>
<xsl:template match="embedvar" mode="embedded"><xsl:call-template name="resolveembedvar"/></xsl:template>

<!-- EMPH -->
<xsl:template match="emph">
	<span class="emph"><xsl:apply-templates /></span>
</xsl:template>
<xsl:template match="emph" mode="embedded">
	<span class="emph"><xsl:apply-templates /></span>
</xsl:template>

<!-- SUB -->
<xsl:template match="sub">
	<sub><xsl:apply-templates /></sub>
</xsl:template>
<xsl:template match="sub" mode="embedded">
	<sub><xsl:apply-templates /></sub>
</xsl:template>

<!-- SUP -->
<xsl:template match="sup">
	<sup><xsl:apply-templates /></sup>
</xsl:template>
<xsl:template match="sup" mode="embedded">
	<sup><xsl:apply-templates /></sup>
</xsl:template>

<!-- FILENAME -->
<xsl:template match="filename"/>

<!-- HISTORY -->
<xsl:template match="history" />

<!-- IMAGE -->
<xsl:template match="image"><xsl:call-template name="insertimage"/></xsl:template>
<xsl:template match="image" mode="embedded"><xsl:call-template name="insertimage"/></xsl:template>

<!-- ITEM -->
<xsl:template match="item"><span class="{@type}"><xsl:apply-templates /></span></xsl:template>
<xsl:template match="item" mode="embedded"><span class="{@type}"><xsl:apply-templates /></span></xsl:template>

<!-- LINK -->
<xsl:template match="link">
	<xsl:choose> <!-- don't insert the heading link to itself -->
		<xsl:when test="(concat('/',@href) = /helpdocument/meta/topic/filename) or (@href = /helpdocument/meta/topic/filename)">
			<xsl:apply-templates />
		</xsl:when>
		<xsl:when test="contains(child::embedvar/@href,'/00/00000004.xhp#wie')"> <!-- special treatment of howtoget links -->

			<xsl:call-template name="insert_howtoget">
				<xsl:with-param name="linkhref" select="@href"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="createlink" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="link" mode="embedded">
	<xsl:call-template name="createlink"/>
</xsl:template>

<!-- LIST -->
<xsl:template match="list">
	<xsl:choose>
		<xsl:when test="@type='ordered'">
			<ol>
				<xsl:if test="@startwith">
					<xsl:attribute name="start"><xsl:value-of select="@startwith"/></xsl:attribute>
				</xsl:if>
				<xsl:apply-templates />
			</ol>
		</xsl:when>
		<xsl:otherwise>
			<ul><xsl:apply-templates /></ul>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="list" mode="embedded">
	<xsl:choose>
		<xsl:when test="@type='ordered'">
			<ol>
				<xsl:if test="@startwith">
					<xsl:attribute name="start"><xsl:value-of select="@startwith"/></xsl:attribute>
				</xsl:if>
				<xsl:apply-templates mode="embedded"/>
			</ol>
		</xsl:when>
		<xsl:otherwise>
			<ul><xsl:apply-templates mode="embedded"/></ul>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- LISTITEM -->
<xsl:template match="listitem">
	<li><xsl:apply-templates /></li>
</xsl:template>

<xsl:template match="listitem" mode="embedded">
	<li><xsl:apply-templates mode="embedded"/></li>
</xsl:template>

<!-- META, SEE HEADER -->
<xsl:template match="meta" />

<!-- OBJECT (UNUSED) -->
<xsl:template match="object"><xsl:call-template name="insertobject"/></xsl:template>
<xsl:template match="object" mode="embedded"><xsl:call-template name="insertobject"/></xsl:template>

<!-- PARAGRAPH -->
<xsl:template match="paragraph">
	<xsl:choose>

		<xsl:when test="@role='heading'">
			<xsl:call-template name="insertheading">
				<xsl:with-param name="level" select="@level"/>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="contains(' note warning tip ',@role)">
			<xsl:call-template name="insertnote">
				<xsl:with-param name="type" select="@role" />
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="contains(descendant::embedvar/@href,'/00/00000004.xhp#wie')"> <!-- special treatment of howtoget links -->
			<xsl:apply-templates />
		</xsl:when>

		<xsl:when test="@role='bascode'">
			<xsl:call-template name="insertbascode" />
		</xsl:when>

		<xsl:when test="@role='logocode'">
			<xsl:call-template name="insertlogocode" />
		</xsl:when>

		<xsl:otherwise>
			<xsl:call-template name="insertpara" />
		</xsl:otherwise>

	</xsl:choose>
</xsl:template>

<xsl:template match="paragraph" mode="embedded">
		<xsl:choose>

		<xsl:when test="@role='heading'">	<!-- increase the level of headings that are embedded -->
<!-- 			 <xsl:variable name="level"><xsl:value-of select="number(@level)+1"/></xsl:variable> -->
			<xsl:call-template name="insertheading">
                <xsl:with-param name="embedded" select="'yes'"/>
                <xsl:with-param name="level" select="@level"/>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="contains(' note warning tip ',@role)">
			<xsl:call-template name="insertnote">
				<xsl:with-param name="type" select="@role" />
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="contains(descendant::embedvar/@href,'/00/00000004.xhp#wie')"> <!-- special treatment of howtoget links -->
			<xsl:apply-templates />
		</xsl:when>

		<xsl:otherwise>
			<xsl:call-template name="insertpara" />
		</xsl:otherwise>

	</xsl:choose>
</xsl:template>


<!-- SECTION -->
<xsl:template match="section">
	<a name="{@id}"></a>

		<xsl:choose>

			<xsl:when test="@id='relatedtopics'">
				<div class="relatedtopics">
					<!--<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'text/shared/00/00000004.xhp',$urlpost)"/></xsl:variable>-->
					<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'text/shared/00/00000004.xhp')"/></xsl:variable>
					<xsl:variable name="anchor"><xsl:value-of select="'related'"/></xsl:variable>
					<xsl:variable name="doc" select="document($href)"/>
                                        <p class="related" itemprop="mentions">
						<xsl:apply-templates select="$doc//variable[@id=$anchor]"/>
					</p>
					<div class="relatedbody" itemprop="mentions">
						<xsl:apply-templates />
					</div>
				</div>
			</xsl:when>

			<xsl:when test="@id='howtoget'">
				<xsl:call-template name="insert_howtoget" />
			</xsl:when>

			<xsl:otherwise>
						<xsl:apply-templates/>
			</xsl:otherwise>

		</xsl:choose>

</xsl:template>


<!-- SECTION -->
<xsl:template match="section" mode="embedded">
	<a name="{@id}"></a>
	<xsl:apply-templates mode="embedded"/>
</xsl:template>

<!-- SORT -->
<xsl:template match="sort" >
	<xsl:apply-templates><xsl:sort select="descendant::paragraph"/></xsl:apply-templates>
</xsl:template>
<xsl:template match="sort" mode="embedded">
	<xsl:apply-templates><xsl:sort select="descendant::paragraph"/></xsl:apply-templates>
</xsl:template>

<!-- SWITCH -->
<xsl:template match="switch"><xsl:apply-templates /></xsl:template>
<xsl:template match="switch" mode="embedded"><xsl:apply-templates /></xsl:template>

<!-- SWITCHINLINE -->
<xsl:template match="switchinline"><xsl:apply-templates /></xsl:template>
<xsl:template match="switchinline" mode="embedded"><xsl:apply-templates mode="embedded"/></xsl:template>

<!-- TABLE -->
<xsl:template match="table"><xsl:call-template name="inserttable"/></xsl:template>
<xsl:template match="table" mode="embedded"><xsl:call-template name="inserttable"/></xsl:template>

<!-- TABLECELL -->
<xsl:template match="tablecell"><td valign="top"><xsl:apply-templates /></td></xsl:template>
<xsl:template match="tablecell" mode="icontable"><td valign="top"><xsl:apply-templates/></td></xsl:template>
<xsl:template match="tablecell" mode="embedded"><td valign="top"><xsl:apply-templates mode="embedded"/></td></xsl:template>

<!-- TABLEROW -->
<xsl:template match="tablerow"><tr><xsl:apply-templates /></tr></xsl:template>
<xsl:template match="tablerow" mode="icontable"><tr><xsl:apply-templates mode="icontable"/></tr></xsl:template>
<xsl:template match="tablerow" mode="embedded"><tr><xsl:apply-templates mode="embedded"/></tr></xsl:template>

<!-- TITLE -->
<xsl:template match="title"/>

<!-- TOPIC -->
<xsl:template match="topic"/>

<!-- VARIABLE -->
<xsl:template match="variable"><a name="{@id}"></a><xsl:apply-templates /></xsl:template>
<xsl:template match="variable" mode="embedded"><a name="{@id}"></a><xsl:apply-templates mode="embedded"/></xsl:template>

<xsl:template match="text()">
	<xsl:call-template name="brand">
		<xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="text()" mode="embedded">
	<xsl:call-template name="brand">
		<xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- In case of missing help files -->
<xsl:template match="help-id-missing"><xsl:value-of select="$Id"/></xsl:template>

<!--
###################
# NAMED TEMPLATES #
###################
//-->

<!-- Branding -->
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


<!-- Insert Paragraph -->
<xsl:template name="insertpara">
	<xsl:variable name="role">
		<xsl:choose>
			<xsl:when test="ancestor::table">
				<xsl:value-of select="concat(@role,'intable')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@role"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<p id="{@id}" class="{$role}"><xsl:apply-templates /></p>
</xsl:template>

<!-- Insert Basic code snippet  -->
<xsl:template name="insertbascode">
	<pre itemscope="true" itemtype="http://schema.org/SoftwareSourceCode" itemprop="codeSampleType" content="snippet"><xsl:apply-templates /></pre>
</xsl:template>

<!-- Insert Logo code snippet  -->
<xsl:template name="insertlogocode">
	<pre><xsl:apply-templates /></pre>
</xsl:template>

<!-- Insert "How to get Link" -->
<xsl:template name="insert_howtoget">
	<xsl:param name="linkhref" />
	<xsl:variable name="archive" select="'shared'"/>
	<!--<xsl:variable name="tmp_href"><xsl:value-of select="concat($urlpre,'text/shared/00/00000004.xhp',$urlpost)"/></xsl:variable>-->
	<xsl:variable name="tmp_href"><xsl:value-of select="concat($urlpre,'text/shared/00/00000004.xhp')"/></xsl:variable>
	<xsl:variable name="tmp_doc" select="document($tmp_href)"/>
	<table class="howtoget" width="100%" border="1" cellpadding="3" cellspacing="0">
		<tr>
			<td>
				<p class="howtogetheader"><xsl:apply-templates select="$tmp_doc//variable[@id='wie']"/></p>
				<div class="howtogetbody">
				<xsl:choose>
					<xsl:when test="$linkhref = ''"> <!-- new style -->
						<xsl:apply-templates/>
					</xsl:when>
					<xsl:otherwise> <!-- old style -->
						<xsl:variable name="href"><xsl:value-of select="concat($urlpre,substring-before($linkhref,'#'))"/></xsl:variable>
						<xsl:variable name="anc"><xsl:value-of select="substring-after($linkhref,'#')"/></xsl:variable>
						<xsl:variable name="docum" select="document($href)"/>

						<xsl:call-template name="insertembed">
							<xsl:with-param name="doc" select="$docum" />
							<xsl:with-param name="anchor" select="$anc" />
						</xsl:call-template>

					</xsl:otherwise>
				</xsl:choose>
				</div>
			</td>
		</tr>
	</table>
	<br/>
</xsl:template>

<!-- Create a link -->
<xsl:template name="createlink">
	<xsl:choose>
		<xsl:when test="starts-with(@href,'http://') or starts-with(@href,'https://')">  <!-- web links -->
			<a href="{@href}"><xsl:apply-templates /></a>
		</xsl:when>
		<xsl:when test="contains(@href,'#')"> <!-- internal links with bookmark -->
			<xsl:variable name="anchor"><xsl:value-of select="concat('#',substring-after(@href,'#'))"/></xsl:variable>
			<xsl:variable name="href"><xsl:value-of select="concat($linkprefix,substring-before(@href, 'xhp'),'html',$anchor,$linkpostfix)"/></xsl:variable>
			<a href="{$href}"><xsl:apply-templates /></a>
		</xsl:when>
		<xsl:otherwise>			
			<xsl:variable name="href"><xsl:value-of select="concat($linkprefix,substring-before(@href, 'xhp'),'html',$linkpostfix)"/></xsl:variable>
			<a href="{$href}"><xsl:apply-templates /></a>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Insert Note, Warning, or Tip -->
<xsl:template name="insertnote">
	<xsl:param name="type" /> <!-- note, tip, or warning -->
	<xsl:variable name="imgsrc">
		<xsl:choose>
			<xsl:when test="$type='note'"><xsl:value-of select="$note_img"/></xsl:when>
			<xsl:when test="$type='tip'"><xsl:value-of select="$tip_img"/></xsl:when>
			<xsl:when test="$type='warning'"><xsl:value-of select="$warning_img"/></xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="dbpostfix"><xsl:call-template name="createDBpostfix"><xsl:with-param name="archive" select="'shared'"/></xsl:call-template></xsl:variable>
	<xsl:variable name="alt">
		<xsl:variable name="href"><xsl:value-of select="$alttext"/></xsl:variable>
		<xsl:variable name="anchor"><xsl:value-of select="concat('alt_',$type)"/></xsl:variable>
		<xsl:variable name="doc" select="document($href)"/>
		<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
	</xsl:variable>
<!-- 	<p class="debug">image source: <xsl:value-of select="$imgsrc"/></p> -->
	<div class="{$type}">
		<table border="0" class="{$type}" cellspacing="0" cellpadding="5">
			<tr>
				<td><img src="{$imgsrc}" alt="{$alt}" title="{$alt}"/></td>
				<td><xsl:apply-templates /></td>
			</tr>
		</table>
	</div>
	<br/>
</xsl:template>

<!-- Insert a heading -->
<xsl:template name="insertheading">
        <xsl:param name="level" />
        <xsl:param name="embedded" />
        <xsl:element name="{concat('h',$level)}">
                <xsl:if test="$level = '1' or $level='2'">
                        <xsl:attribute name="itemprop"><xsl:text>articleSection</xsl:text></xsl:attribute>
                </xsl:if>
                <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
                <xsl:choose>
                    <xsl:when test="$embedded = 'yes'">
                        <xsl:apply-templates mode="embedded"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates />
                    </xsl:otherwise>
                </xsl:choose>
        </xsl:element>
</xsl:template>

<!-- Evaluate a case or caseinline switch -->
<xsl:template name="insertcase">
	<xsl:param name="embedded" />
	<xsl:choose>
		<xsl:when test="parent::switch[@select='sys'] or parent::switchinline[@select='sys']">
				<xsl:choose>
					<xsl:when test="$embedded = 'yes'">
						<span hidden="true" itemprop="system" value="{@select}"><xsl:apply-templates mode="embedded"/></span>
					</xsl:when>
					<xsl:otherwise>
						<span  hidden="true" itemprop="system" value="{@select}"><xsl:apply-templates /></span>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:when>
		<xsl:when test="parent::switch[@select='appl'] or parent::switchinline[@select='appl']">
				<xsl:choose>
					<xsl:when test="$embedded = 'yes'">
						<span  hidden="true" itemprop="appl" value="{@select}"><xsl:apply-templates mode="embedded"/></span>
					</xsl:when>
					<xsl:otherwise>
						<span  hidden="true" itemprop="appl" value="{@select}"><xsl:apply-templates /></span>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:when>
		<xsl:when test="parent::switch[@select='distrib'] or parent::switchinline[@select='distrib']">
				<xsl:choose>
					<xsl:when test="$embedded = 'yes'">
						<span  hidden="true" itemprop="distrib" value="{@select}"><xsl:apply-templates mode="embedded"/></span>
					</xsl:when>
					<xsl:otherwise>
						<span  hidden="true" itemprop="distrib" value="{@select}"><xsl:apply-templates /></span>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- Evaluate a default or defaultinline switch -->
<xsl:template name="insertdefault">
	<xsl:param name="embedded" />
	<xsl:choose>
		<xsl:when test="parent::switch[@select='sys'] or parent::switchinline[@select='sys']">
			<xsl:if test="not(../child::case[@select=$System]) and not(../child::caseinline[@select=$System])">
				<xsl:choose>
					<xsl:when test="$embedded = 'yes'">
						<span hidden="true" itemprop="system" value="WIN"><xsl:apply-templates mode="embedded"/></span>
					</xsl:when>
					<xsl:otherwise>
						<span hidden="true" itemprop="system" value="WIN"><xsl:apply-templates /></span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:when>
		<xsl:when test="parent::switch[@select='appl'] or parent::switchinline[@select='appl']">
			<xsl:if test="not(../child::case[@select=$appl]) and not(../child::caseinline[@select=$appl])">
				<xsl:choose>
					<xsl:when test="$embedded = 'yes'">
						<span hidden="true" itemprop="appl" value="SHARED"><xsl:apply-templates mode="embedded"/></span>
					</xsl:when>
					<xsl:otherwise>
						<span hidden="true" itemprop="appl" value="SHARED"><xsl:apply-templates /></span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:when>
		<xsl:when test="parent::switch[@select='distrib'] or parent::switchinline[@select='distrib']">
			<xsl:if test="not(../child::case[@select=$distrib]) and not(../child::caseinline[@select=$distrib])">
				<xsl:choose>
					<xsl:when test="$embedded = 'yes'">
						<span hidden="true" itemprop="distrib" value="DEFDIST"><xsl:apply-templates mode="embedded"/></span>
					</xsl:when>
					<xsl:otherwise>
						<span hidden="true" itemprop="distrib" value="DEFDIST"><xsl:apply-templates /></span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- evaluate embeds -->
<xsl:template name="insertembed">
	<xsl:param name="doc" />
	<xsl:param name="anchor" />
	<!-- different embed targets (also falsely used embed instead embedvar) -->
	<xsl:choose>
		<xsl:when test="$doc//section[@id=$anchor]"> <!-- first test for a section of that name -->
			<xsl:apply-templates select="$doc//section[@id=$anchor]" mode="embedded"/>
		</xsl:when>
		<xsl:when test="$doc//paragraph[@id=$anchor]"> <!-- then test for a para of that name -->
			<p class="embedded">
				<xsl:apply-templates select="$doc//paragraph[@id=$anchor]" mode="embedded"/>
			</p>
		</xsl:when>
		<xsl:when test="$doc//variable[@id=$anchor]"> <!-- then test for a variable of that name -->
			<p class="embedded">
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</p>
		</xsl:when>
		<xsl:otherwise> <!-- then give up -->
			<p class="bug">D'oh! You found a bug (<xsl:value-of select="@href"/> not found).</p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Insert an image -->
<xsl:template name="insertimage">
  <xsl:variable name="src">
    <xsl:choose>
         <xsl:when test="starts-with(@src,'media/screenshots/')">
            <xsl:choose>
                <xsl:when test="@localize='true'">
                    <xsl:variable name="tmp0" select="substring-before(@src, '/ui')"/>
                    <xsl:variable name="tmp1" select="substring-after(@src, '/ui/')"/>
                    <xsl:variable name="tmp2" select="substring-before($tmp1,'/')"/>
                    <xsl:variable name="tmp3" select="substring-after($tmp1,'/')"/>
                    <xsl:value-of select="concat('/',$productversion,'/', $tmp0,'/ui/', $tmp2, '/',$lang,'/',$tmp3)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('/',$productversion,'/',@src)"/>
                </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="starts-with(@src,'media/')">
             <xsl:value-of select="concat('/',$productversion,'/',@src)"/>
         </xsl:when>
         <xsl:when test="not(starts-with(@src,'media/'))">
             <xsl:value-of select="concat('/',$productversion,'/media/icon-themes/',@src)"/>
         </xsl:when>
         <xsl:otherwise>
             <xsl:value-of select="concat('/',$productversion,@src)"/>
         </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
<!-- <p class="debug">Image: <xsl:value-of select="$src"/></p>-->
  <xsl:variable name="alt"><xsl:value-of select="./alt"/></xsl:variable>
  <xsl:variable name="width">
        <xsl:call-template name="convert2px"><xsl:with-param name="value" select="@width"/></xsl:call-template>
  </xsl:variable>
  <xsl:variable name="height">
        <xsl:call-template name="convert2px"><xsl:with-param name="value" select="@height"/></xsl:call-template>
  </xsl:variable>
  <xsl:variable name="istyle"><xsl:value-of select="concat('width:',$width,';','height:',$height,';')"/></xsl:variable>
  <img src="{$src}" alt="{$alt}" title="{$alt}" style="{$istyle}"></img>
</xsl:template>

<!-- Insert an object -->
<xsl:template name="insertobject">
  <xsl:variable name="data">
       <xsl:value-of select="concat($img_url_prefix,@data)"/>
  </xsl:variable>
  <p class="debug">Object: <xsl:value-of select="$data"/></p>
  <xsl:variable name="type"><xsl:value-of select="@type"/></xsl:variable>
  <xsl:variable name="width">
        <xsl:call-template name="convert2px"><xsl:with-param name="value" select="@width"/></xsl:call-template>
  </xsl:variable>
  <xsl:variable name="height">
        <xsl:call-template name="convert2px"><xsl:with-param name="value" select="@height"/></xsl:call-template>
  </xsl:variable>
  <xsl:choose>
        <xsl:when test="starts-with($type,'video')">
          <div id="mediadiv">
            <video src="{$data}" type="{$type}" width="{$width}" height="{$height}" controls="'1'"></video>
          </div>
        </xsl:when>
        <xsl:when test="starts-with($type,'audio')">
          <div id="mediadiv">
            <audio src="{$data}" type="{$type}" controls="'1'"></audio>
          </div>
        </xsl:when>
        <xsl:otherwise>
           <object width="{$width}" height="{$height}" data="{$data}" type="{$type}"></object>
        </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- changing measure to pixel -->
<xsl:template name="convert2px">
        <xsl:param name="value"/>
        <xsl:choose>
                <xsl:when test="contains($value, 'cm')">
                     <xsl:value-of select="concat(round(number(substring-before($value, 'cm')) * $dpcm),'px')"/>
                </xsl:when>
                <xsl:when test="contains($value, 'mm')">
                     <xsl:value-of select="concat(round(number(substring-before($value, 'mm')) * $dpmm),'px')"/>
                </xsl:when>
                <xsl:when test="contains($value, 'in')">
                     <xsl:value-of select="concat(round(number(substring-before($value, 'in')) * $dpi),'px')"/>
                </xsl:when>
                <xsl:when test="contains($value, 'px')">
                     <xsl:value-of select="$value"/>
                </xsl:when>
                <xsl:otherwise>
<!--                      <xsl:message>measure_conversion.xsl: Find no conversion for <xsl:value-of select="$value"/> to 'px'!</xsl:message> -->
                     <xsl:value-of select="concat($value, 'px')"/>
                </xsl:otherwise>
       </xsl:choose>
</xsl:template>

<!-- Insert a Table -->
<xsl:template name="inserttable">
	<xsl:variable name="imgsrc">	<!-- see if we are in an image table -->
		<xsl:value-of select="tablerow/tablecell[1]/paragraph[1]/image/@src"/>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="count(descendant::tablecell)=1">
			<table border="0" class="onecell" cellpadding="0" cellspacing="0">
				<xsl:apply-templates />
		 </table>
		</xsl:when>

		<xsl:when test="descendant::tablecell[1]/descendant::image">
                    <table border="0" class="icontable" cellpadding="5" cellspacing="0">
				<xsl:apply-templates mode="icontable"/>
		    </table>
		</xsl:when>

		<xsl:when test="@class='wide'">
			<table border="1" class="{@class}" cellpadding="0" cellspacing="0" width="100%" >
				<xsl:apply-templates />
		        </table>
		</xsl:when>

		<xsl:when test="not(@class='')">
			<table border="1" class="{@class}" cellpadding="0" cellspacing="0" >
				<xsl:apply-templates />
		        </table>
		</xsl:when>

		<xsl:otherwise>
			<table border="1" class="border" cellpadding="0" cellspacing="0" >
				<xsl:apply-templates />
		        </table>
		</xsl:otherwise>
	</xsl:choose>
	<br/>
</xsl:template>

<xsl:template name="resolveembed">
	<div class="embedded">
		<xsl:variable name="href"><xsl:value-of select="concat($urlpre,substring-before(@href,'#'))"/></xsl:variable>
		<xsl:variable name="anc"><xsl:value-of select="substring-after(@href,'#')"/></xsl:variable>
		<xsl:variable name="docum" select="document($href)"/>

		<xsl:call-template name="insertembed">
			<xsl:with-param name="doc" select="$docum" />
			<xsl:with-param name="anchor" select="$anc" />
		</xsl:call-template>

	</div>
</xsl:template>

<xsl:template name="resolveembedvar">
	<xsl:if test="not(@href='text/shared/00/00000004.xhp#wie')"> <!-- special treatment if howtoget links -->
		<xsl:variable name="archive"><xsl:value-of select="concat(substring-before(substring-after(@href,'text/'),'/'),'/')"/></xsl:variable>
		<xsl:variable name="dbpostfix"><xsl:call-template name="createDBpostfix"><xsl:with-param name="archive" select="$archive"/></xsl:call-template></xsl:variable>
		<xsl:variable name="href"><xsl:value-of select="concat($urlpre,substring-before(@href,'#'))"/></xsl:variable>
		<xsl:variable name="anchor"><xsl:value-of select="substring-after(@href,'#')"/></xsl:variable>
		<xsl:variable name="doc" select="document($href)"/>
		<xsl:choose>
			<xsl:when test="$doc//variable[@id=$anchor]"> <!-- test for a variable of that name -->
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</xsl:when>
			<xsl:otherwise> <!-- or give up -->
				<span class="bug">[<xsl:value-of select="@href"/> not found].</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

<!-- Apply -->
<xsl:template name="apply">
	<xsl:param name="embedded" />
	<xsl:choose>
		<xsl:when test="$embedded = 'yes'">
			<xsl:apply-templates mode="embedded"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="createDBpostfix">
	<xsl:param name="archive"/>
	<xsl:variable name="newDB">
		<xsl:choose>
			<xsl:when test="(substring($archive,1,6) = 'shared')"><xsl:value-of select="$Database"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-before($archive,'/')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:value-of select="concat($am,'DbPAR=',$newDB)"/>
</xsl:template>

<xsl:template name="filehtml">
   <xsl:param name="file"/>
   <xsl:value-of select="concat(substring-before($file,'.xhp'),'.html')"/>
</xsl:template>

</xsl:stylesheet>
