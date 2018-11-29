Using prism.js for Basic code highlight

http://prismjs.com

License MIT (see prism.js)

Download page http://prismjs.com/download

Theme: Coy

Languages to download: Visual Basic + Python + defaults pre-sets

Plugins: line numbers

Usage:

Add prism.js and prism.css to html page,

Add class language-visual-basic and line-numbers to <code> as in

<xsl:template match="bascode">
    <div class="bascode" itemscope="true" itemtype="http://schema.org/SoftwareSourceCode" itemprop="codeSampleType" content="snippet"><pre><code class="language-visual-basic line-numbers"><xsl:apply-templates /></code></pre></div>
</xsl:template>
