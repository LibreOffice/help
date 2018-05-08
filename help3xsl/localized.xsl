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
</xsl:stylesheet>

