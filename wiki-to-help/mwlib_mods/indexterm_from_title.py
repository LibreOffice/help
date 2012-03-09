"""
Adds 
<indexterm><primary>TITLE</primary></indexterm>
to each <article>
"""

## Set up docbookwriter
import mwlib.docbookwriter
#import lxml.etree
SubElement = mwlib.docbookwriter.SubElement
class MyDocBookWriter(mwlib.docbookwriter.DocBookWriter):
    def dbwriteArticle(self, a):
        """ 
        Add <indexterm><primary>a.caption</primary></indexterm>
        """
        e = super(MyDocBookWriter,self).dbwriteArticle(a)
        i = SubElement(e,"indexterm")
        p = SubElement(i,"primary")
        p.text = a.caption
        return e

def apply():
    mwlib.docbookwriter.DocBookWriter = MyDocBookWriter

