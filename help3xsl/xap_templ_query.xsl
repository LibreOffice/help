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
    <xsl:output indent="yes" method="text"/>
<xsl:template match="/">
<![CDATA[$httpheader{Content-Type,text/html; charset=utf-8}<!DOCTYPE html><html lang="]]><xsl:value-of select="$lang"/><![CDATA[">
$set{flag_spelling,$ne{$cgi{SPELL},0}}
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
<body bgcolor="#ffffff">
<form name=P method=get
action="$html{$or{$env{SCRIPT_NAME},omega}}" target="_top">
<center>
<input id="omega-autofocus" type=search name=P value="$html{$query}" size=65 autofocus>
<script>
if (!("autofocus" in document.createElement("input")))
 document.getElementById("omega-autofocus").focus();
</script>
<input type=submit value="Search">
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
$if{$field{language},Language: <b>$html{$field{language}}</b><br>}
$if{$field{size},<span title="$html{$field{size}} bytes">Size: <b>$html{$filesize{$field{size}}}</b></span><br>}
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
</body>
</html>
$log{query.log}]]>
</xsl:template>
</xsl:stylesheet>
