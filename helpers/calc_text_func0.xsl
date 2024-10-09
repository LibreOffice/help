<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" method="xml" version="1.0" encoding="UTF-8"/>

<xsl:param name="func" select="base"/>

<xsl:template match="@* | node()">
    <xsl:copy>
        <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
</xsl:template>

<xsl:template match="//section">

  <xsl:choose>
    <xsl:when test="current()[@id = $func]">
		<section id="{./@id}">
		  <embed href="text/scalc/01/func_{@id}.xhp#func_{@id}"/>
		</section>
    </xsl:when>
    <xsl:otherwise>
		<xsl:copy-of select="."/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> 

</xsl:stylesheet>