<?xml version="1.0" encoding="UTF-8"?>

<!-- 
                   =============
                   DEBUG VERSION
									 =============
 
//-->

<!--***********************************************************************
  This is the main transformation style sheet for transforming.
  Only use with OOo 2.0
  Owner: fpe@openoffice.org
  =========================================================================
  Changes Log
    May 24 2004 Created
    Aug 24 2004 Fixed for help2 CWS
    Aug 27 2004 Added css link, fixed missing embed-mode for variable
                Removed width/height for images
***********************************************************************//-->

<!--***********************************************************************

 *
 *  The Contents of this file are made available subject to the terms of
 *  either of the following licenses
 *
 *         - GNU Lesser General Public License Version 2.1
 *         - Sun Industry Standards Source License Version 1.1
 *
 *  Sun Microsystems Inc., October, 2000
 *
 *  GNU Lesser General Public License Version 2.1
 *  =============================================
 *  Copyright 2000 by Sun Microsystems, Inc.
 *  901 San Antonio Road, Palo Alto, CA 94303, USA
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License version 2.1, as published by the Free Software Foundation.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 *  MA  02111-1307  USA
 *
 *
 *  Sun Industry Standards Source License Version 1.1
 *  =================================================
 *  The contents of this file are subject to the Sun Industry Standards
 *  Source License Version 1.1 (the "License"); You may not use this file
 *  except in compliance with the License. You may obtain a copy of the
 *  License at http://www.openoffice.org/license.html.
 *
 *  Software provided under this License is provided on an "AS IS" basis,
 *  WITHOUT WARRUNTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING,
 *  WITHOUT LIMITATION, WARRUNTIES THAT THE SOFTWARE IS FREE OF DEFECTS,
 *  MERCHANTABLE, FIT FOR A PARTICULAR PURPOSE, OR NON-INFRINGING.
 *  See the License for the specific provisions governing your rights and
 *  obligations concerning the Software.
 *
 *  The Initial Developer of the Original Code is: Sun Microsystems, Inc..
 *
 *  Copyright: 2000 by Sun Microsystems, Inc.
 *
 *  All Rights Reserved.
 *
 *  Contributor(s): _______________________________________
 *
 *
 ************************************************************************-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output indent="yes" method="html"/>

<!--
############################
# Variables and Parameters #
############################
//-->

<!-- General Usage -->
<xsl:variable name="am" select="'&amp;'"/>
<xsl:variable name="sl" select="'/'"/>
<xsl:variable name="qt" select="'&quot;'"/>

<!-- generic Icon alt text -->
<xsl:variable name="alttext" select="'text/shared/00/icon_alt.xhp'"/>

<!-- For calculating pixel sizes -->
<xsl:variable name="dpi" select="'96'"/>
<xsl:variable name="dpcm" select="'38'"/>

<!-- Product brand variables used in the help files -->
<xsl:variable name="brand1" select="'$[officename]'"/>
<xsl:variable name="brand2" select="'$[officeversion]'"/>
<xsl:variable name="brand3" select="'%PRODUCTNAME'"/>
<xsl:variable name="brand4" select="'%PRODUCTVERSION'"/>

<!-- meta data variables from the help file -->
<xsl:variable name="filename" select="/helpdocument/meta/topic/filename"/>
<xsl:variable name="topic_id" select="/helpdocument/meta/topic/@id"/>
<xsl:variable name="topic_status" select="/helpdocument/meta/topic/@status"/>
<xsl:variable name="title" select="/helpdocument/meta/topic/title"/>
<xsl:variable name="lang" select="/helpdocument/meta/topic/title/@xml-lang"/>

<!-- Module and the corresponding switching values-->
<xsl:param name="module" select="'swriter'"/>
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
<xsl:param name="productname" select="'Office'"/>
<xsl:param name="productversion" select="''"/>
<!-- this is were the images are -->
<xsl:param name="imgrepos" select="''"/>
<xsl:param name="Id" />
<!-- (lame) distinction between OS and Commercial -->
<xsl:param name="distrib">
	<xsl:choose>
		<xsl:when test="starts-with($productname,'OpenOffice')">
			<xsl:value-of select="'OPENSOURCE'"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="'COMMERCIAL'"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:param>

<!-- parts of help and image urls -->

<xsl:variable name="help_url_prefix" select="'vnd.sun.star.help://'"/>
<xsl:variable name="img_url_prefix" select="concat('vnd.sun.star.pkg://',$imgrepos,'/')"/>
<xsl:variable name="urlpost" select="concat('?Language=',$lang,$am,'System=',$System,$am,'UseDB=no')"/>
<xsl:variable name="urlpre" select="$help_url_prefix" /> 
<xsl:variable name="linkprefix" select="$urlpre"/>
<xsl:variable name="linkpostfix" select="$urlpost"/>


<!-- DEBUG: 
<xsl:variable name="help_url_prefix" select="''"/>
<xsl:variable name="img_url_prefix" select="''"/>
<xsl:variable name="urlpost" select="''"/>
<xsl:variable name="urlpre" select="$help_url_prefix" /> 
<xsl:variable name="linkprefix" select="$urlpre"/>
<xsl:variable name="linkpostfix" select="$urlpost"/>
-->

<xsl:variable name="css" select="'default.css'"/>

<!-- images for notes, tips and warnings -->
<xsl:variable name="note_img" select="concat($img_url_prefix,'res/helpimg/note.png')"/>
<xsl:variable name="tip_img" select="concat($img_url_prefix,'res/helpimg/tip.png')"/>
<xsl:variable name="warning_img" select="concat($img_url_prefix,'res/helpimg/warning.png')"/>

<!--
#############
# Templates #
#############
//-->

<!-- Create the document skeleton -->
<xsl:template match="/">
	<xsl:variable name="csslink" select="concat($urlpre,'/',$urlpost)"/>
	<html>
		<head>
			<title><xsl:value-of select="$title"/></title>
			<link href="{$csslink}" rel="Stylesheet" type="text/css" /> <!-- stylesheet link -->
  		<meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
		</head>
		<body lang="{$lang}">
<!-- DEBUG
			<xsl:value-of select="$filename"/>
//-->
			<xsl:apply-templates select="/helpdocument/body"/>
		</body>
	</html>
</xsl:template>

<!-- AHELP -->
<xsl:template match="ahelp">
	<xsl:if test="not(@visibility='hidden')"><span class="avis"><xsl:apply-templates /></span></xsl:if>
</xsl:template>

<!-- ALT -->
<xsl:template match="alt"/>

<!-- BOOKMARK -->
<xsl:template match="bookmark">
	<a name="{@id}"></a>
	<xsl:choose>
		<xsl:when test="starts-with(@branch,'hid')">
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- BOOKMARK_VALUE -->
<xsl:template match="bookmark_value" />

<!-- BR -->
<xsl:template match="br">
	<br />
</xsl:template>

<!-- CAPTION -->
<xsl:template match="caption" />

<!-- CASE -->
<xsl:template match="case">
	<xsl:choose>
		<xsl:when test="parent::switch[@select='sys']">
			<xsl:if test="@select = $System"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switch[@select='appl']">
			<xsl:if test="@select = $appl"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switch[@select='distrib']">
			<xsl:if test="@select = $distrib"><xsl:apply-templates /></xsl:if>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- CASEINLINE -->
<xsl:template match="caseinline">
	<xsl:choose>
		<xsl:when test="parent::switchinline[@select='sys']">
			<xsl:if test="@select = $System"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switchinline[@select='appl']">
			<xsl:if test="@select = $appl"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switchinline[@select='distrib']">
			<xsl:if test="@select = $distrib"><xsl:apply-templates /></xsl:if>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- COMMENT -->
<xsl:template match="comment" />

<!-- CREATED -->
<xsl:template match="created" />

<!-- DEFAULT -->
<xsl:template match="default">
	<xsl:choose>
		<xsl:when test="parent::switch[@select='sys']">
			<xsl:if test="not(../child::case[@select=$System])"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switch[@select='appl']">
			<xsl:if test="not(../child::case[@select=$appl])"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switch[@select='distrib']">
			<xsl:if test="not(../child::case[@select=$distrib])"><xsl:apply-templates /></xsl:if>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- DEFAULTINLINE -->
<xsl:template match="defaultinline">
	<xsl:choose>
		<xsl:when test="parent::switchinline[@select='sys']">
			<xsl:if test="not(../child::caseinline[@select=$System])"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switchinline[@select='appl']">
			<xsl:if test="not(../child::caseinline[@select=$appl])"><xsl:apply-templates /></xsl:if>
		</xsl:when>
		<xsl:when test="parent::switchinline[@select='distrib']">
			<xsl:if test="not(../child::caseinline[@select=$distrib])"><xsl:apply-templates /></xsl:if>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<!-- Some EMBED is resolved on help compilation -->
<xsl:template match="embed">

	<div class="embedded">
		<xsl:variable name="archive"><xsl:value-of select="concat(substring-before(substring-after(@href,'text/'),'/'),'/')"/></xsl:variable>
		<xsl:variable name="href"><xsl:value-of select="concat($urlpre,$archive,substring-before(@href,'#'),$urlpost)"/></xsl:variable>
		<xsl:variable name="anchor"><xsl:value-of select="substring-after(@href,'#')"/></xsl:variable>
		<xsl:variable name="doc" select="document($href)"/>
		<xsl:apply-templates select="$doc//section[@id=$anchor]"/>
		
		<xsl:if test="not($doc//section[@id=$anchor])">  <!--fallback for embeds that actually should be embedvars -->
			<p>
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
	
			</p>
		</xsl:if>
		
	</div>

</xsl:template>

<!-- EMBEDVAR -->
<xsl:template match="embedvar">
	<xsl:if test="not(@href='text/shared/00/00000004.xhp#wie')"> <!-- special treatment if howtoget links -->
		<xsl:variable name="archive"><xsl:value-of select="concat(substring-before(substring-after(@href,'text/'),'/'),'/')"/></xsl:variable>
		<xsl:variable name="href"><xsl:value-of select="concat($urlpre,$archive,substring-before(@href,'#'),$urlpost)"/></xsl:variable>
		<xsl:variable name="anchor"><xsl:value-of select="substring-after(@href,'#')"/></xsl:variable>
		<xsl:variable name="doc" select="document($href)"/>
		<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>

	</xsl:if>
</xsl:template>

<!-- EMPH -->
<xsl:template match="emph">
	<span class="emph">
		<xsl:apply-templates />
	</span>
</xsl:template>

<!-- FILENAME -->
<xsl:template match="filename" />

<!-- HISTORY -->
<xsl:template match="history" />

<!-- IMAGE -->

<xsl:template match="image">
	
	<xsl:variable name="src">
		<xsl:value-of select="concat($img_url_prefix,@src)"/> 
	</xsl:variable>
	
	<xsl:variable name="alt">
		<xsl:value-of select="./alt"/>
	</xsl:variable>
	
	<xsl:variable name="width" select="''"/>
	<xsl:variable name="height" select="''"/>
	
	<!--
	<xsl:variable name="width">
		<xsl:choose>
			<xsl:when test="contains(@width,'cm')">
				<xsl:value-of select="substring-before(@width,'cm')*$dpcm"/>
			</xsl:when>
			<xsl:when test="contains(@width,'in')">
				<xsl:value-of select="substring-before(@width,'in')*$dpi"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	//-->
	
	<!--
	<xsl:variable name="height">
	<xsl:choose>
		<xsl:when test="contains(@height,'cm')">
				<xsl:value-of select="substring-before(@height,'cm')*$dpcm"/>
			</xsl:when>
			<xsl:when test="contains(@height,'in')">
				<xsl:value-of select="substring-before(@height,'in')*$dpi"/>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	//-->
	
	<img src="{$src}" alt="{$alt}" title="{$alt}">
		<xsl:if test="not($width='')"><xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute></xsl:if>
		<xsl:if test="not($height='')"><xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute></xsl:if>
	</img>  
</xsl:template>

<!-- ITEM -->
<xsl:template match="item">
	<span class="{@type}">
		<xsl:apply-templates />
	</span>
</xsl:template>

<!-- LASTEDITED -->
<xsl:template match="lastedited" />

<!-- LINK -->
<xsl:template match="link">
	<xsl:choose>
	
	<!-- don't insert the heading link to itself, doesn't work as yet
		<xsl:when test="concat('/',@href) = /helpdocument/meta/topic/filename">
			<xsl:apply-templates />
		</xsl:when>
	//-->
		
	<xsl:when test="contains(child::embedvar/@href,'/00/00000004.xhp#wie')"> <!-- special treatment of howtoget links -->
				<xsl:variable name="archive"><xsl:value-of select="concat(substring-before(substring-after(child::embedvar/@href,'text/'),'/'),'/')"/></xsl:variable>
				<xsl:variable name="tmp_href"><xsl:value-of select="concat($urlpre,$archive,substring-before(child::embedvar/@href,'#'),$urlpost)"/></xsl:variable>
				<xsl:variable name="tmp_doc" select="document($tmp_href)"/>
				<div class="howtoget">
				<table class="howtoget" width="100%" border="1" cellpadding="3" cellspacing="0" rules="none">
					<tr>
						<td>

							<p class="howtogetheader"><xsl:apply-templates select="$tmp_doc//variable[@id='wie']"/></p>

						</td>
					</tr>
					<tr>
						<td>

							<xsl:variable name="archive1"><xsl:value-of select="concat(substring-before(substring-after(@href,'text/'),'/'),'/')"/></xsl:variable>
							<xsl:variable name="href"><xsl:value-of select="concat($urlpre,$archive1,substring-before(@href,'#'),$urlpost)"/></xsl:variable>
							<xsl:variable name="anchor"><xsl:value-of select="substring-after(@href,'#')"/></xsl:variable>
							<xsl:variable name="doc" select="document($href)"/>
							<xsl:apply-templates select="$doc//section[@id=$anchor]"/>
							<xsl:if test="not($doc//section[@id=$anchor])">  <!-- fallback for embeds that actually should be embedvars --> 
								<p><xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/></p>
							</xsl:if>

						</td>
					</tr>
				</table>
				</div>
				<br/>
		</xsl:when>
		
		<xsl:otherwise>
			<xsl:variable name="archive"><xsl:value-of select="concat(substring-before(substring-after(@href,'text/'),'/'),'/')"/></xsl:variable>
			<xsl:choose>
				<xsl:when test="contains(@href,'#')">
					<xsl:variable name="anchor"><xsl:value-of select="concat('#',substring-after(@href,'#'))"/></xsl:variable>
					<xsl:variable name="href"><xsl:value-of select="concat($linkprefix,$archive,substring-before(@href,'#'),$linkpostfix,$anchor)"/></xsl:variable>
					<a href="{$href}"><xsl:apply-templates /></a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="href"><xsl:value-of select="concat($linkprefix,$archive,@href,$linkpostfix)"/></xsl:variable>
					<a href="{$href}"><xsl:apply-templates /></a>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	
	</xsl:choose>
</xsl:template>

<xsl:template match="link" mode="embedded">
		<xsl:variable name="archive"><xsl:value-of select="concat(substring-before(substring-after(@href,'text/'),'/'),'/')"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="contains(@href,'#')">
				<xsl:variable name="anchor"><xsl:value-of select="concat('#',substring-after(@href,'#'))"/></xsl:variable>
				<xsl:variable name="href"><xsl:value-of select="concat($linkprefix,$archive,substring-before(@href,'#'),$linkpostfix,$anchor)"/></xsl:variable>
				<a href="{$href}"><xsl:apply-templates /></a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="href"><xsl:value-of select="concat($linkprefix,$archive,@href,$linkpostfix)"/></xsl:variable>
				<a href="{$href}"><xsl:apply-templates /></a>
			</xsl:otherwise>
		</xsl:choose>
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
			<ul>
				<xsl:apply-templates />
			</ul>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- LISTITEM -->
<xsl:template match="listitem">
	<li><xsl:apply-templates /></li>
</xsl:template>

<!-- META, SEE HEADER -->
<xsl:template match="meta" />

<!-- OBJECT (UNUSED) -->
<xsl:template match="object" />

<!-- PARAGRAPH -->
<xsl:template match="paragraph">
	<xsl:choose>
		
		<xsl:when test="@role='heading'">
			<xsl:text disable-output-escaping="yes">&lt;h</xsl:text><xsl:value-of select="@level"/><xsl:text disable-output-escaping="yes">&gt;</xsl:text> 
				<xsl:apply-templates />
			<xsl:text disable-output-escaping="yes">&lt;/h</xsl:text><xsl:value-of select="@level"/><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		</xsl:when>
		
		<xsl:when test="@role='note'">
			<xsl:variable name="alt">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/',$alttext,$urlpost)"/></xsl:variable>
				<xsl:variable name="anchor"><xsl:value-of select="'alt_note'"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</xsl:variable>
			<div class="note">
			<table border="1" class="note" frame="hsides" rules="none" cellspacing="0" cellpadding="5" width="100%">
				<tr>
					<td><img src="{$note_img}" alt="{$alt}" title="{$alt}"/></td>
					<td><xsl:apply-templates /></td>
				</tr>
			</table>
			</div>
			<xsl:if test="(name(following-sibling::*[1]) = 'table') or ((name(following-sibling::*[1]) = 'paragraph') and (contains('tip note warning',following-sibling::*[1]/@role)))">
				<br/>
			</xsl:if>
		</xsl:when>
		
		<xsl:when test="@role='tip'">
		<xsl:variable name="alt">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/',$alttext,$urlpost)"/></xsl:variable>
				<xsl:variable name="anchor"><xsl:value-of select="'alt_tip'"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</xsl:variable>
			<div class="tip">
			<table border="1" class="tip" frame="hsides" rules="none" cellspacing="0" cellpadding="5" width="100%">
				<tr>
					<td><img src="{$tip_img}" alt="{$alt}" title="{$alt}"/></td>
					<td><xsl:apply-templates /></td>
				</tr>
			</table>
			</div>			
		<xsl:if test="(name(following-sibling::*[1]) = 'table') or ((name(following-sibling::*[1]) = 'paragraph') and (contains('tip note warning',following-sibling::*[1]/@role)))">
				<br/>
			</xsl:if>
		</xsl:when>
		
		<xsl:when test="@role='warning'">
		<xsl:variable name="alt">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/',$alttext,$urlpost)"/></xsl:variable>
				<xsl:variable name="anchor"><xsl:value-of select="'alt_warning'"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</xsl:variable>
			<div class="warning">
			<table border="1" class="warning" frame="hsides" rules="none" cellspacing="0" cellpadding="5" width="100%">
				<tr>
					<td><img src="{$warning_img}" alt="{$alt}" title="{$alt}"/></td>
					<td><xsl:apply-templates /></td>
				</tr>
			</table>
			</div>		
<xsl:if test="(name(following-sibling::*[1]) = 'table') or ((name(following-sibling::*[1]) = 'paragraph') and (contains('tip note warning',following-sibling::*[1]/@role)))">
				<br/>
			</xsl:if>			
		</xsl:when>
		
		<xsl:when test="contains(descendant::embedvar/@href,'/00/00000004.xhp#wie')"> <!-- special treatment of howtoget links -->
			<xsl:apply-templates />
		</xsl:when>		
		
		<xsl:otherwise>
			<xsl:variable name="role">
				<xsl:choose>
					<xsl:when test="ancestor::table">
						<xsl:value-of select="concat(@role,'_intable')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@role"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<p class="{$role}">
				<xsl:apply-templates />
			</p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="paragraph" mode="embedded">
	<xsl:choose>
		
		<xsl:when test="@role='heading'">	<!-- increase the level of headings that are embedded -->
			<xsl:variable name="level"><xsl:value-of select="@level + 1"/></xsl:variable>
			<xsl:text disable-output-escaping="yes">&lt;h</xsl:text><xsl:value-of select="$level"/><xsl:text disable-output-escaping="yes">&gt;</xsl:text> 
				<xsl:apply-templates mode="embedded"/>	<!-- this is to enable self-links for embedded h1s -->
			<xsl:text disable-output-escaping="yes">&lt;/h</xsl:text><xsl:value-of select="$level"/><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		</xsl:when>
		
		<xsl:when test="@role='note'">
			<xsl:variable name="alt">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/',$alttext,$urlpost)"/></xsl:variable>
				<xsl:variable name="anchor"><xsl:value-of select="'alt_note'"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</xsl:variable>
			<div class="note">
			<table border="1" class="note" frame="hsides" rules="none" cellspacing="0" cellpadding="5" width="100%">
				<tr>
					<td><img src="{$note_img}" alt="{$alt}" title="{$alt}"/></td>
					<td><xsl:apply-templates /></td>
				</tr>
			</table>
			</div>
			<xsl:if test="(name(following-sibling::*[1]) = 'table') or ((name(following-sibling::*[1]) = 'paragraph') and (contains('tip note warning',following-sibling::*[1]/@role)))">
				<br/>
			</xsl:if>
		</xsl:when>
		
		<xsl:when test="@role='tip'">
		<xsl:variable name="alt">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/',$alttext,$urlpost)"/></xsl:variable>
				<xsl:variable name="anchor"><xsl:value-of select="'alt_tip'"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</xsl:variable>
			<div class="tip">
			<table border="1" class="tip" frame="hsides" rules="none" cellspacing="0" cellpadding="5" width="100%">
				<tr>
					<td><img src="{$tip_img}" alt="{$alt}" title="{$alt}"/></td>
					<td><xsl:apply-templates /></td>
				</tr>
			</table>
			</div>			
		<xsl:if test="(name(following-sibling::*[1]) = 'table') or ((name(following-sibling::*[1]) = 'paragraph') and (contains('tip note warning',following-sibling::*[1]/@role)))">
				<br/>
			</xsl:if>
		</xsl:when>
		
		<xsl:when test="@role='warning'">
		<xsl:variable name="alt">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/',$alttext,$urlpost)"/></xsl:variable>
				<xsl:variable name="anchor"><xsl:value-of select="'alt_warning'"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
			</xsl:variable>
			<div class="warning">
			<table border="1" class="warning" frame="hsides" rules="none" cellspacing="0" cellpadding="5" width="100%">
				<tr>
					<td><img src="{$warning_img}" alt="{$alt}" title="{$alt}"/></td>
					<td><xsl:apply-templates /></td>
				</tr>
			</table>
			</div>		
<xsl:if test="(name(following-sibling::*[1]) = 'table') or ((name(following-sibling::*[1]) = 'paragraph') and (contains('tip note warning',following-sibling::*[1]/@role)))">
				<br/>
			</xsl:if>			
		</xsl:when>
		
		<xsl:when test="contains(descendant::embedvar/@href,'/00/00000004.xhp#wie')"> <!-- special treatment of howtoget links -->
			<xsl:apply-templates />
		</xsl:when>		
		
		<xsl:otherwise>
			<xsl:variable name="role">
				<xsl:choose>
					<xsl:when test="ancestor::table">
						<xsl:value-of select="concat(@role,'_intable')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@role"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<p class="{$role}">
				<xsl:apply-templates />
			</p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- SECTION -->
<xsl:template match="section">
	<a name="{@id}"></a>

		<xsl:choose>
			
			<xsl:when test="@id='relatedtopics'">
				<div class="relatedtopics">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/text/shared/00/00000004.xhp',$urlpost)"/></xsl:variable>
				<xsl:variable name="anchor"><xsl:value-of select="'related'"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<p class="related">
					<xsl:apply-templates select="$doc//variable[@id=$anchor]"/>
				</p>
				<xsl:apply-templates />
				</div>
			</xsl:when>
			
			<xsl:when test="@id='howtoget'">
				<xsl:variable name="href"><xsl:value-of select="concat($urlpre,'shared/text/shared/00/00000004.xhp',$urlpost)"/></xsl:variable>
				<xsl:variable name="doc" select="document($href)"/>
				<div class="howtoget">
				<table class="howtoget" width="100%" border="1" cellpadding="3" cellspacing="0" rules="none">
					<tr>
						<td>
							<p class="howtogetheader"><xsl:apply-templates select="$doc//variable[@id='wie']"/></p>
						</td>
					</tr>
					<tr>
						<td>
							<xsl:apply-templates />
						</td>
					</tr>
				</table>
				</div>
			</xsl:when>
			
			<xsl:otherwise>
						<xsl:apply-templates/>
			</xsl:otherwise>
		
		</xsl:choose>


</xsl:template>

<!-- SORT -->
<xsl:template match="sort" >
	<xsl:apply-templates><xsl:sort select="descendant::paragraph"/></xsl:apply-templates>
</xsl:template>

<!-- SWITCH -->
<xsl:template match="switch">
	<div class="switch">
		<xsl:apply-templates />
	</div>
</xsl:template>

<!-- SWITCHINLINE -->
<xsl:template match="switchinline">
	<span class="switchinline">
		<xsl:apply-templates />
	</span>
</xsl:template>

<!-- TABLE -->
<xsl:template match="table">
	<xsl:variable name="imgsrc">	<!-- see if we are in an image table -->
		<xsl:value-of select="tablerow/tablecell[1]/paragraph[1]/image/@src"/>
	</xsl:variable>
	
	<xsl:choose>
		
		<xsl:when test="count(descendant::tablecell)=1">
			<table border="0" class="onecell" cellpadding="0" cellspacing="0">
				<xsl:apply-templates />
		 </table>
		</xsl:when>
		
		<xsl:when test="count(descendant::tablerow)=1 and descendant::tablecell[1]/descendant::image">
			<table border="0" class="icontable" cellpadding="5" cellspacing="0">
				<xsl:apply-templates mode="icontable"/>
		 </table>
		</xsl:when>
		
		
		<xsl:otherwise>
			<table border="1" class="border" cellpadding="0" cellspacing="0">
				<xsl:apply-templates />
		 </table>
		</xsl:otherwise>
	</xsl:choose>
	
	<xsl:if test="name(following-sibling::*[1]) = 'table'">
		<br/>
	</xsl:if>
</xsl:template>

<!-- TABLECELL -->
<xsl:template match="tablecell">
	<td valign="top"><xsl:apply-templates /></td>
</xsl:template>
<xsl:template match="tablecell" mode="icontable">
	<td valign="center"><xsl:apply-templates/></td>
</xsl:template>

<!-- TABLEROW -->
<xsl:template match="tablerow">
	<tr><xsl:apply-templates /></tr>
</xsl:template>
<xsl:template match="tablerow" mode="icontable">
	<tr><xsl:apply-templates mode="icontable"/></tr>
</xsl:template>

<!-- TITLE -->
<xsl:template match="title"/>

<!-- TOPIC -->
<xsl:template match="topic"/>

<xsl:template match="help-id-missing">
	<xsl:value-of select="$Id"/>
</xsl:template>

<!-- VARIABLE -->
<xsl:template match="variable">
		<a name="{@id}"></a>
		<xsl:apply-templates />
</xsl:template>

<!-- VARIABLE -->
<xsl:template match="variable" mode="embedded">
		<a name="{@id}"></a>
		<xsl:apply-templates />
</xsl:template>

<xsl:template match="text()">
	<xsl:call-template name="brand">
		<xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template name="brand" >
	<xsl:param name="string"/>
	<xsl:choose>
		<xsl:when test="contains($string,$brand1)">
			<xsl:value-of select="substring-before($string,$brand1)"/>
			<xsl:value-of select="$productname"/>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="substring-after($string,$brand1)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($string,$brand2)">
			<xsl:value-of select="substring-before($string,$brand2)"/>
			<xsl:value-of select="$productversion"/>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="substring-after($string,$brand2)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($string,$brand3)">
			<xsl:value-of select="substring-before($string,$brand3)"/>
			<xsl:value-of select="$productname"/>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="substring-after($string,$brand3)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="contains($string,$brand4)">
			<xsl:value-of select="substring-before($string,$brand4)"/>
			<xsl:value-of select="$productversion"/>
			<xsl:call-template name="brand">
				<xsl:with-param name="string" select="substring-after($string,$brand4)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$string"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
