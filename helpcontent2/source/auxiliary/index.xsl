<xsl:stylesheet version="1.0" encoding="UTF-8"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:office="http://openoffice.org/2000/office"
	xmlns:style="http://openoffice.org/2000/style"
	xmlns:table="http://openoffice.org/2000/table"
	xmlns:draw="http://openoffice.org/2000/drawing"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:meta="http://openoffice.org/2000/meta"
	xmlns:number="http://openoffice.org/2000/datastyle"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns:chart="http://openoffice.org/2000/chart"
	xmlns:help="http://openoffice.org/2000/help"
	xmlns:index="http://sun.com/2000/XMLSearch"	
	xmlns:text="http://openoffice.org/2000/text">

<xsl:param name="Language" select="'de'"/>

<xsl:template match="office:document|office:body">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="headingheading">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="text:p">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="text:span">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="help:to-be-embedded">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>


<xsl:template match="help:key-word">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="help:link">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="help:help-text[@value='visible']">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="text()">
  <index:text index:nodeID="{generate-id(current())}">
    <xsl:value-of select="."/>
  </index:text>
</xsl:template>


<xsl:template match="*"/>
	
</xsl:stylesheet>


