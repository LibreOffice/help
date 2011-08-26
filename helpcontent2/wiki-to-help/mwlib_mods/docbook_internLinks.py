"""
This enables the conversion of article links to internal links within the docbook output.

Author: Timo Richter
"""

# Set up nuwiki.adapt
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

mwlib.nuwiki.adapt = MyAdapt


# Set up docbookwriter.grammar
import mwlib.docbookwriter
import docbook45grammar
mwlib.docbookwriter.grammar = docbook45grammar.grammar


# Set up docbookwriter
import mwlib.docbookwriter
import lxml.etree
class MyDocBookWriter(mwlib.docbookwriter.DocBookWriter):
    def getTargetId(self,title):
        """ Transform "The first article" to "The_first_article" """
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
        Element = mwlib.docbookwriter.Element
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

mwlib.docbookwriter.DocBookWriter = MyDocBookWriter

