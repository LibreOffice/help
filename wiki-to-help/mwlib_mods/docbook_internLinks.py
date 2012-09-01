"""
This enables the conversion of article links to internal links within the docbook output.
Usage:
    import docbook_internLinks
    docbook_internLinks.apply()
Requires:
    docbook_grammar

Author: Timo Richter
"""

## Set up nuwiki.adapt
import mwlib.nuwiki
class MyAdapt(mwlib.nuwiki.adapt):
    def getParsedArticle(self, title, revision=None):
        """ Add the original title to the attributes of each article """
        a = super(MyAdapt,self).getParsedArticle(title,revision)
        if a:
            a.title = title
        return a
    def getURL(self, name, revision=None, defaultns=None):
        """ Returns raw link targets """
        return name

def setupAdapt():
    mwlib.nuwiki.adapt = MyAdapt


## Set up docbookwriter
import mwlib.docbookwriter
#import lxml.etree
Element = mwlib.docbookwriter.Element
SubElement = mwlib.docbookwriter.SubElement
class MyDocBookWriter(mwlib.docbookwriter.DocBookWriter):
    def getTargetId(self,title):
        """ Transform "The first article" to "The_first_article" """
        # See mwlib.zipwiki.normalize_title()
        return title.replace(" ","_")

    def dbwriteArticle(self, a):
        """ 
        Add id-attribute with original title to all articles.
        <article id="a.title">
        """
        e = super(MyDocBookWriter,self).dbwriteArticle(a)
        targetId = self.getTargetId(a.title)
        e.set("id",targetId)
        return e

    def dbwriteArticleLink(self, obj):
        a = Element("link")
        if obj.target:
            a.set("linkend", obj.target)
        if not obj.children:
            a.text = obj.target
        return a
    #dbwriteLink = dbwriteURL
    #dbwriteNamedURL = dbwriteURL
    #dbwriteSpecialLink = dbwriteURL
    #dbwriteCategoryLink = dbwriteURL
    #dbwriteLangLink = dbwriteURL
    #dbwriteArticleLink = dbwriteLink 
    #dbwriteLangLink = dbwriteLink # FIXME
    #dbwriteNamespaceLink = dbwriteLink# FIXME
    #dbwriteInterwikiLink = dbwriteLink# FIXME
    #dbwriteSpecialLink = dbwriteLink# FIXME

def setupDocBookWriter():
    mwlib.docbookwriter.DocBookWriter = MyDocBookWriter

def apply():
    setupAdapt()
    #setupGrammar()
    setupDocBookWriter()


