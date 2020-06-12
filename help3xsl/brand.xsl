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

<!-- Product brand variables used in the help files -->
<xsl:variable name="brand1" select="'$[officename]'"/>
<xsl:variable name="brand2" select="'$[officeversion]'"/>
<xsl:variable name="brand3" select="'%PRODUCTNAME'"/>
<xsl:variable name="brand4" select="'%PRODUCTVERSION'"/>

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
</xsl:stylesheet>
