"""
Create docbook- instead of HTML-tables.

Requires:
    docbook_grammar

Example of a docbook table:

<table frame='all'><title>Sample Table</title>
<tgroup cols='5' align='left' colsep='1' rowsep='1'>
<colspec colname='c1'/>
<colspec colname='c2'/>
<colspec colname='c3'/>
<colspec colnum='5' colname='c5'/>
<thead>
<row>
  <entry namest="c1" nameend="c2" align="center">Horizontal Span</entry>
  <entry>a3</entry>
  <entry>a4</entry>
  <entry>a5</entry>
</row>
</thead>
<tfoot>
<row>
  <entry>f1</entry>
  <entry>f2</entry>
  <entry>f3</entry>
  <entry>f4</entry>
  <entry>f5</entry>
</row>
</tfoot>
<tbody>
<row>
  <entry>b1</entry>
  <entry>b2</entry>
  <entry>b3</entry>
  <entry>b4</entry>
  <entry morerows='1' valign='middle'><para>  <!-- Pernicous Mixed Content -->
  Vertical Span</para></entry>
</row>
<row>
  <entry>c1</entry>
  <entry namest="c2" nameend="c3" align='center' morerows='1' valign='bottom'>Span Both</entry>
  <entry>c4</entry>
</row>
<row>
  <entry>d1</entry>
  <entry>d4</entry>
  <entry>d5</entry>
</row>
</tbody>
</tgroup>
</table>

Example from http://www.docbook.org/tdg/en/html/table.html
"""

## Set up docbookwriter
import mwlib.docbookwriter
Element = mwlib.docbookwriter.Element
SubElement = mwlib.docbookwriter.SubElement
setVList=mwlib.docbookwriter.setVList
class MyDocBookWriter(mwlib.docbookwriter.DocBookWriter):
    def dbwriteTable(self, t):           
        """
        rowspan & colspan are supported
        nested tables not supported in DocBook V4.4
        """
        table = Element("informaltable") #border=1
        tgroup = SubElement(table,"tgroup")
        tbody = SubElement(tgroup,"tbody")
        setVList(table, t)           
        if t.caption:
            #c = SubElement(table, "caption")
            #self.writeText(t.caption, c)
            pass
        table.writeto = tbody
        #docbookwriter.py l 220
        return table

    def dbwriteCell(self, cell):
        td = Element("entry")
        #setVList(td, cell)           
        return td
            
    def dbwriteRow(self, row):
        return Element("row")


def apply():
    mwlib.docbookwriter.DocBookWriter = MyDocBookWriter

