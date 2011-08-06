"""
Writes <article>...</article> instead of <article><section>...</section></article>.

"""

import mwlib.docbookwriter
#import lxml.etree
#Element = mwlib.docbookwriter.Element
class MyDocBookWriter(mwlib.docbookwriter.DocBookWriter):
    def dbwriteArticle(self, a):
        from mwlib.docbookwriter import *
        """
        this generates the root element if not available
        """
        #e = super(MyDocBookWriter,self).dbwriteArticle(a)
        #e.remove(e.find("section"))
        #return e
        # add head + title
        e = Element("article", lang=self.language)
        if self.root is None:
            self.root = e
        h = SubElement(e,"articleinfo")
        t = SubElement(h, "title")
        if a.caption:
            t.text = a.caption
        
        # DONT add a section and heading for this article 
        #s = SubElement(e, "section")
        #si = SubElement(s, "sectioninfo")
        #h = SubElement(si, "title")
        #h.text = a.caption
        #e.writeto = s
        return e 

def apply():
    mwlib.docbookwriter.DocBookWriter = MyDocBookWriter


