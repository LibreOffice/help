<?xml version="1.0" encoding="UTF-8"?>

<!--
* This file is part of the LibreOffice project.
*
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->
<!--
Stylesheet to create the localized xapian template.
Based on the query template from xapian
Usage:
xsltproc xap_template_query.xsl <file.xhp>
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="lang"/>
    <xsl:param name="productname"/>
    <xsl:param name="productversion"/>
    <xsl:output indent="yes" method="text"/>
    <xsl:variable name="target" select="concat('/',$productversion,'/')"/>
    <!-- Strings for the help UI page -->
    <xsl:variable name ="ui_contents"><xsl:apply-templates select="//variable[@id='contents']"/></xsl:variable>
    <xsl:variable name ="ui_index"><xsl:apply-templates select="//variable[@id='index']"/></xsl:variable>
    <xsl:variable name ="ui_pholderall"><xsl:apply-templates select="//variable[@id='pholderall']"/></xsl:variable>
    <xsl:variable name ="ui_pholderchosen"><xsl:apply-templates select="//variable[@id='pholderchosen']"/></xsl:variable>
    <xsl:variable name ="ui_module"><xsl:apply-templates select="//variable[@id='module']"/></xsl:variable>
    <xsl:variable name ="ui_language"><xsl:apply-templates select="//variable[@id='language']"/></xsl:variable>
    <xsl:variable name ="ui_donate"><xsl:apply-templates select="//variable[@id='donate']"/></xsl:variable>
    <xsl:variable name ="ui_logo"><xsl:apply-templates select="//variable[@id='LibreOfficeHelp']"/></xsl:variable>
    <xsl:variable name ="ui_selectmodule"><xsl:apply-templates select="//variable[@id='selectmodule']"/></xsl:variable>
    <xsl:variable name ="ui_selectlang"><xsl:apply-templates select="//variable[@id='selectlanguage']"/></xsl:variable>
    <xsl:variable name ="ui_search"><xsl:apply-templates select="//variable[@id='searchhelpcontents']"/></xsl:variable>

    <xsl:variable name="brand3" select="'%PRODUCTNAME'"/>
    <xsl:variable name="brand4" select="'%PRODUCTVERSION'"/>


<xsl:template match="/">
<![CDATA[$httpheader{Content-Type,text/html; charset=utf-8}<!DOCTYPE html><html lang="]]><xsl:value-of select="$lang"/><![CDATA[">
<base href="]]><xsl:value-of select="$target"/><![CDATA["/>
$set{flag_spelling,$ne{$cgi{SPELL},0}}
$set{stemmer,$if{$cgi{STEMMER},$cgi{STEMMER},none}}
$set{flag_spelling_correction,true}
$set{thousand,$.}$set{decimal,.}
$setmap{prefix,,$split{ S B F},title,S,author,A,topic,B}
${
$def{PREV,
$if{$ne{$topdoc,0},<input type=image name="&lt;" alt="&lt;"
src="/images/xapian-omega/prev.png" height=30 width=30>,
<img alt="" src="/images/xapian-omega/prevoff.png" height=30 width=30>}
}

$def{NEXT,
$if{$ne{$last,$msize},<input type=image name="&gt;" alt="&gt;"
src="/images/xapian-omega/next.png" height=30 width=30>,
<img alt="" src="/images/xapian-omega/nextoff.png" height=30 width=30>}
}

$def{P,<input type=image name="$1" value="$1" src="/images/xapian-omega/page-$2.png" $opt{a} alt="$1">}
$def{PAGE,$if{$gt{$1,9},$if{$gt{$1,99},$P{$1,$div{$1,100}}}$P{$1,$mod{$div{$1,10},10}}}$P{$1,$mod{$1,10}}}

$def{S,<img src="/images/xapian-omega/page-$2s.png" $opt{a} alt=$1>}
$def{SPAGE,$if{$gt{$1,9},$if{$gt{$1,99},$S{$1,$div{$1,100}}}$S{$1,$mod{$div{$1,10},10}}}$S{$1,$mod{$1,10}}}
}

$def{PREV,$if{$ne{$topdoc,0},<input type=submit name="&lt;" value="]]><xsl:apply-templates select="//variable[@id='xap_previous']"/><![CDATA[">}}

$def{PAGE,<input type=submit name="[" value="$1">}

$def{SPAGE,<input type=submit name="[" value="$1" disabled=disabled>}

    $def{NEXT,$if{$ne{$last,$msize},<input type=submit name="&gt;" value="]]><xsl:apply-templates select="//variable[@id='xap_next']"/><![CDATA[">}}

<head>
<title>$if{$query,Omega Search: $html{$query},Omega Search}</title>
<!--$if{$opt{topterms},$include{inc/toptermsjs}}-->
<link rel="shortcut icon" href="media/navigation/favicon.ico"/>
<link  type="text/css" href="normalize.css" rel="Stylesheet"/>
<link  type="text/css" href="default.css" rel="Stylesheet"/>
<link  type="text/css" href="prism.css" rel="Stylesheet"/>
<script type="text/javascript" src="polyfills.js"></script>
<script type="text/javascript" src="languages.js"></script>
<script type="text/javascript" src="]]><xsl:value-of select="$lang"/><![CDATA[/langnames.js"></script>
<script type="text/javascript" src="flexsearch.debug.js"></script>
<script type="text/javascript" src="prism.js"></script>
<script type="text/javascript" src="help2.js" defer=""></script>
<script type="text/javascript" src="a11y-toggle.js" defer=""></script>
<script type="text/javascript" src="paginathing.js" defer=""></script>
<script type="text/javascript" src="]]><xsl:value-of select="$lang"/><![CDATA[/bookmarks.js" defer=""></script>
<script type="text/javascript" src="]]><xsl:value-of select="$lang"/><![CDATA[/contents.js" defer=""></script>
<script type="text/javascript" src="help.js" defer=""></script>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<style>
input[type=image] {
  border: 0px;
  }
</style>
<script type="text/javascript">
function f2(n) {return (n>9?"":"0")+n;}
function write_date(time_t) {
var d=new Date();d.setTime(time_t*1000);
var D=d.getFullYear()+"-"+f2(d.getMonth()+1)+"-"+f2(d.getDate());
var T=f2(d.getHours())+":"+f2(d.getMinutes())+":"+f2(d.getSeconds());
document.write("<span title=\""+D+" "+T+"\">]]><xsl:apply-templates select="//variable[@id='xap_modified']"/><![CDATA[<br><b>"+D+"</b></span>");
}
</script>
</head>
<body>
<div id="TopLeftHeader">
    <header>
        <div class="logo-container">
            <a class="logo" href="]]><xsl:value-of select="$lang"/><![CDATA[/text/shared/05/new_help.html">
                <div class="symbol"></div>
                <p>]]><xsl:value-of select="$ui_logo"/><![CDATA[</p>
            </a>
        </div>
    </header>
</div>
<div class="modules">
    <button type="button" data-a11y-toggle="modules-nav" id="modules" onclick="setupModules(']]><xsl:value-of select="$lang"/><![CDATA[');">]]><xsl:value-of select="$ui_module"/><![CDATA[
    </button>
    <nav id="modules-nav"/><!-- is filled in via setupModules() on demand -->
</div>
<aside class="rightside">
    <input id="accordion-1" name="accordion-menu" type="checkbox"/>
    <label for="accordion-1">]]><xsl:value-of select="$ui_contents"/><![CDATA[</label>
    <div id="Contents" class="contents-treeview"></div>
</aside>
<aside class="leftside">
    <div id="Index">
        <div class="index-label">]]><xsl:value-of select="$ui_index"/><![CDATA[ &#32;&#x1f50e;&#xfe0e;&#32;</div>
        <div id="Bookmarks">
            <input id="search-bar" type="text" class="search" placeholder="]]><xsl:value-of select="$ui_pholderchosen"/><![CDATA["/>
            <nav class="index"></nav>
        </div>
    </div>
</aside>
<div id="DonationFrame">
    <div class="donation">
        <p><a href="https://www.libreoffice.org/donate/?pk_campaign=help" target ="_blank">]]><xsl:value-of select="$ui_donate"/><![CDATA[</a></p>
    </div>
</div>
<div id="SearchFrame">
    <div class="xapian-omega-search">
    </div>
</div>
<div id="DisplayArea">
    <form name="P" method="get" action="]]><xsl:value-of select="$lang"/><![CDATA[/search" target="_top">
<center>
<input id="omega-autofocus" type=search name=P value="$html{$query}" size=40 autofocus>
<script>
if (!("autofocus" in document.createElement("input")))
 document.getElementById("omega-autofocus").focus();
</script>
<input type="submit" class="xapian-omega-search-button" value="&#x1f50d;"/>
<hr>
<input type=radio name=DEFAULTOP value=and $if{$eq{$defaultop,and},checked}>]]><xsl:apply-templates select="//variable[@id='xap_match_all']"/><![CDATA[
<input type=radio name=DEFAULTOP value=or $if{$eq{$defaultop,or},checked}>]]><xsl:apply-templates select="//variable[@id='xap_match_any']"/><![CDATA[
$if{$opt{topterms},
 <div title="Suggested terms to add to your query"
 style="text-align:left;background:#cfc;border:1px solid green;padding:2px;font:11px verdana$. arial$. helvetica$. sans-serif;">
 $map{$topterms,<span style="white-space:nowrap"><input type=checkbox name=X value="$html{$prettyterm{$_}}" onClick="C(this)">$html{$prettyterm{$_}}</span> }
 <br><noscript><input type=hidden name=ADD value=1></noscript>
 </div>
}
<br>
$if{$suggestion,]]><xsl:apply-templates select="//variable[@id='xap_didyoumean']"/><![CDATA[ <a href="$html{$or{$env{SCRIPT_NAME},omega}?P=$url{$suggestion}$if{$ne{$hitsperpage,10},&HITSPERPAGE=$hitsperpage}$if{$cgi{COLLAPSE},&COLLAPSE=$url{$cgi{COLLAPSE}}}$map{$relevants,&R=$_}$if{$cgi{THRESHOLD},&THRESHOLD=$url{$cgi{THRESHOLD}}}$map{$cgilist{B},&B=$url{$_}}&SPELL=0}">$html{$suggestion}</a><br>}

$or{$html{$error},
$if{$eq{$msize,0},
$if{$query,]]><xsl:apply-templates select="//variable[@id='xap_no_match']"/><![CDATA[,
<hr>]]><xsl:apply-templates select="//variable[@id='xap_searching_doc']"/><![CDATA[
},
$if{$not{$msizeexact},
$nice{$add{$topdoc,1}}-$nice{$last} ]]><xsl:apply-templates select="//variable[@id='xap_about']"/><![CDATA[,
 $if{$and{$eq{$last,$msize},$eq{$topdoc,0}},
 ]]><xsl:apply-templates select="//variable[@id='xap_allmatches']"/><![CDATA[ ,
 $nice{$add{$topdoc,1}}$if{$ne{$add{$topdoc,1},$last},-$nice{$last}} ]]><xsl:apply-templates select="//variable[@id='xap_exactly']"/><![CDATA[}
}
<hr>

</center>
$if{$map{$queryterms,$set{U,$unstem{$_}}$set{F_$opt{U},$add{$opt{F_$opt{U}},$freq{$_}}}},$list{$unique{$map{$queryterms,$set{U,$unstem{$_}}$list{$html{$unique{$opt{U}}},<b>,</b>/<b>,</b>}:&nbsp;$nice{$opt{F_$opt{U}}}}},]]><xsl:apply-templates select="//variable[@id='xap_term_frequencies']"/><![CDATA[ ,$. ,}}
<br><small>]]><xsl:apply-templates select="//variable[@id='xap_searchtimes']"/><![CDATA[</small>
<table>
$hitlist{<tr><td valign=top>
${<img src="/images/xapian-omega/score-$div{$percentage,10}.png" alt="$percentage%" height=16 width=32>}
<div title="$percentage%" style='float:left;width:60px;height:10px;border:1px solid black;margin-top:4px;'>
<div style='width:$div{$mul{$percentage,6},10}px; height:10px; background-color: red;'>
</div></div>
<div style='float:left;margin-top:2px;font-size:x-small;'>
$if{$and{$field{modtime},$ne{$field{modtime},-1}},
<script type="text/javascript">write_date($add{$field{modtime}});</script>
<noscript>
<span title="$html{$date{$field{modtime},%Y-%m-%d %H:%M:%S}}">
]]><xsl:apply-templates select="//variable[@id='xap_modified']"/><![CDATA[<br><b>$html{$date{$field{modtime},%Y-%m-%d}}</b></span>
</noscript><br>
}
$if{$field{language},]]><xsl:apply-templates select="//variable[@id='xap_lang']"/><![CDATA[<b>$html{$field{language}}</b><br>}
$if{$field{size},<span title="$html{$field{size}} bytes">]]><xsl:apply-templates select="//variable[@id='xap_size']"/><![CDATA[<b>$html{$filesize{$field{size}}}</b></span><br>}
<div title="]]><xsl:apply-templates select="//variable[@id='xap_relevant']"/><![CDATA[" style="float:left;background-color:#cfc;border:1px solid green;margin-top:2px;">
<input type=checkbox name=R value=$id$if{$relevant, checked}>
</div>
</div>
</td>
<td><b><a href="$html{$field{url}}">$html{$or{$field{caption},$field{title},$prettyurl{$field{url}},Untitled}}</a></b><br>
<small>$snippet{$field{sample}}</small><br>
<a href="$html{$field{url}}">$html{$prettyurl{$field{url}}}</a><br>
<small>
]]><xsl:apply-templates select="//variable[@id='xap_matching']"/><![CDATA[
<i>$list{$map{$terms,$html{$prettyterm{$_}}},</i>$. <i>,</i> and <i>}</i></small>${for lynx:}<p></td></tr>}
</table>

<br><center>

${suppress next, prev, and page links if there's only one page}
$if{$ne{$lastpage,1},
$set{a,$if{$opt{pagelink_height}, HEIGHT=$opt{pagelink_height}}$if{$opt{pagelink_width}, WIDTH=$opt{pagelink_width}}}

${1-W ... X-(this)-Y ...}
$set{w,$min{3,$add{$thispage,-1}}}
$set{x,$max{$add{$opt{w},1},$add{$thispage,-3}}}
$set{y,$min{$lastpage,$add{$thispage,8}}}
$PREV
$map{$range{1,$opt{w}},$PAGE{$_}}
$if{$ne{$add{$opt{w},1},$opt{x}},...}
$map{$range{$opt{x},$add{$thispage,-1}},$PAGE{$_}}
$SPAGE{$thispage}
$map{$range{$add{$thispage,1},$opt{y}},$PAGE{$_}}
$if{$ne{$opt{y},$lastpage},...}
$NEXT
}
}}
</center><br>
$if{$ne{$topdoc,0},<input type=hidden name=TOPDOC value=$topdoc>}
$if{$ne{$hitsperpage,10},<input type=hidden name=HITSPERPAGE value=$hitsperpage>}
$if{$cgi{COLLAPSE},<input type=hidden name=COLLAPSE value="$html{$cgi{COLLAPSE}}">}
$if{$queryterms,<input type=hidden name=xP value="$html{$queryterms}">}
<input type=hidden name=xFILTERS value="$html{$filters}">
$list{$relevants,<input type=hidden name=R value=",.,">}
$if{$cgi{THRESHOLD},<input type=hidden name=THRESHOLD value="$html{$cgi{THRESHOLD}}">}
${Preserve any B filters used - this needs modifying if you modify this template
  to have B on radio buttons, SELECT, etc}
$map{$cgilist{B},<input type=hidden name=B value="$html{$_}">}
</form>
<hr><div align=right><i><small><a href="https://xapian.org/">$html{$version}</a></small></i></div>
    <footer>
        <p><a href="https://www.libreoffice.org/imprint" target="_blank">Impressum (Legal Info)</a> | <a href="https://www.libreoffice.org/privacy" target="_blank">Privacy Policy</a> | <a href="https://www.documentfoundation.org/statutes.pdf" target="_blank">Statutes (non-binding English translation)</a> - <a href="https://www.documentfoundation.org/satzung.pdf" target="_blank">Satzung (binding German version)</a> | Copyright information: Unless otherwise specified, all text and images on this website are licensed under the <a href="https://www.libreoffice.org/download/license/" target="_blank">Mozilla Public License v2.0</a>. “LibreOffice” and “The Document Foundation” are registered trademarks of their corresponding registered owners or are in actual use as trademarks in one or more countries. Their respective logos and icons are also subject to international copyright laws. Use thereof is explained in our <a href="https://wiki.documentfoundation.org/TradeMark_Policy" target="_blank">trademark policy</a>. LibreOffice was based on OpenOffice.org.</p>
    </footer>
</body>
</html>
$log{query.log}
</div>
]]>
</xsl:template>

<xsl:template match="text()">
    <xsl:call-template name="brand">
        <xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
    </xsl:call-template>
</xsl:template>

<!-- Branding -->
<xsl:template name="brand" >
    <xsl:param name="string"/>
    <xsl:choose>
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
                <xsl:value-of select="$productversion"/>
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
