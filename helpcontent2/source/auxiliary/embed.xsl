<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" method="xml"/>

<!-- SPECIFY YOUR FILE SYSTEM ROOT PATH TO THE HELP FILES -->
<xsl:param name="fsroot" select="'file:///handbuch/WORKBENCH/helpcontent2/source/'"/>

<!--
######################################################
All others
######################################################
-->
<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="*|@*|comment()|processing-instruction()|text()">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="*|@*|comment()|processing-instruction()|text()" mode="embedded">
  <xsl:copy>
    <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()" mode="embedded"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="bookmark" mode="embedded">
	<bookmark>
		<xsl:copy-of select="@*"/>
		<xsl:attribute name="embedded">true</xsl:attribute>
		<xsl:apply-templates />
	</bookmark>
</xsl:template>


<xsl:template match="bookmark_value" mode="embedded">
	<bookmark_value embedded="true">
		<xsl:apply-templates/>
	</bookmark_value>
</xsl:template>


<!-- 
###################################################### 
EMBED
###################################################### 
-->
<xsl:template match="embed">

		<xsl:variable name="href"><xsl:value-of select="substring-before(concat($fsroot,@href),'#')"/></xsl:variable>
		<xsl:variable name="anchor"><xsl:value-of select="substring-after(@href,'#')"/></xsl:variable>
		<xsl:variable name="doc" select="document($href)"/>
		<xsl:apply-templates select="$doc//section[@id=$anchor]" mode="embedded"/>
		<xsl:if test="not($doc//section[@id=$anchor])"> <!-- fallback for embeds that actually should be embedvars -->
			<paragraph role="paragraph"><xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/></paragraph>
		</xsl:if>
</xsl:template>

<!-- 
###################################################### 
EMBEDVAR
###################################################### 
-->
<xsl:template match="embedvar">
	<xsl:if test="not(@href='text/shared/00/00000004.xml#wie')"> <!-- special treatment if howtoget links -->
		<xsl:variable name="href"><xsl:value-of select="substring-before(concat($fsroot,@href),'#')"/></xsl:variable>
		<xsl:variable name="anchor"><xsl:value-of select="substring-after(@href,'#')"/></xsl:variable>
		<xsl:variable name="doc" select="document($href)"/>
		<xsl:apply-templates select="$doc//variable[@id=$anchor]" mode="embedded"/>
	</xsl:if>
	
	<!-- FPE: embedvars, that point to "text/shared/00/00000004.xml#wie" will only be resolved in the main_transform -->
	
</xsl:template>
</xsl:stylesheet>
