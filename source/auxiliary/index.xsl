/*
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
 */

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

<xsl:param name="Language" select="'en-US'"/>

<xsl:template match="helpdocument|body">
  <xsl:choose>
    <xsl:when test="meta/topic[@indexer='exclude']"/>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="title">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="table">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="tablecell">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="tablerow">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="list">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="listitem">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="item">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="emph">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="sub">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="sup">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="paragraph">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="section">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="bookmark">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="bookmark_value">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="link">
  <index:element index:tokenizer="com.sun.xmlsearch.util.SimpleTokenizer">
      <xsl:apply-templates/>
  </index:element>
</xsl:template>

<xsl:template match="ahelp[@visibility='visible']">
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


