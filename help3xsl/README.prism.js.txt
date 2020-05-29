Latest download version

PrismJS 1.20.0

Using prism.js for Basic code highlight

http://prismjs.com

License MIT (see prism.js)

Download page http://prismjs.com/download

Theme: Coy

Languages to download: Visual Basic + Python + defaults pre-sets

Plugins: line numbers,

normalize-whitespace: configure after https://prismjs.com/plugins/normalize-whitespace/

Prism.plugins.NormalizeWhitespace = new NormalizeWhitespace({
'remove-trailing': true,
'remove-indent': true,
'left-trim': true,
'right-trim': true,
/*'break-lines': 80,
'indent': 2,*/
'remove-initial-line-feed': true,
/*'tabs-to-spaces': 4,
'spaces-to-tabs': 4*/
});


Usage:

Add prism.js and prism.css to html page,

Add class 'language-visual-basic' and 'line-numbers' to <code> as in

<xsl:template match="bascode">
    <div class="bascode" itemscope="true" itemtype="http://schema.org/SoftwareSourceCode" itemprop="codeSampleType" content="snippet">
   <pre><code class="language-visual-basic line-numbers"><xsl:apply-templates /></code></pre></div>
</xsl:template>

Interference with a11y-toggle.js

[aria-hidden='true'] interferes with prism line-numbers plugin.

Solution is to add to default.css the following

.line-numbers [aria-hidden='true']{
    display:block;
}
