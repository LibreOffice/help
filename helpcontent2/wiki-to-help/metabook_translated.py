import metabook
import re

class ArticleTranslated(metabook.Article):
    lang = "en" # default language code
    trans = "" # translated title

    def __init__(self,attributes):
        title = attributes["title"]
        parts = title.split("/")
        #if len(parts) < 2: 
        #    self.include = False
        #    return
        if len(parts) == 1:
            # title = "blabla"
            self.title = title
        if len(parts) == 2: 
            # title = "Category/englishTitle"
            self.title = parts[1]
        if len(parts) == 3:
            # title = "Category/englishTitle/langCode"
            self.lang = parts[2]
            self.title = parts[1]
        
        comment = attributes["comment"]
        if '{Lang|' in comment:
            # Language-tag exists
            r = re.search("\{Lang\|([^\}]*)\}",comment)
            trans = r.group(1)
            self.trans = trans
        else:
            self.trans = self.title

        attr = {}
        attr["title"] = attributes["title"]
        attr["displaytitle"] = self.trans
        attr["lang"] = self.lang
        self.attributes = attr

class MetabookTranslated(metabook.Metabook):
    """ 
    This concrete metabook expects article titles in this form:
        Category/Title/lang
    Comments include this:
        {{Lang|translatedTitle}}
    """
    ArticleClass=ArticleTranslated
    artTags = ["title","comment"]

    def splitByLanguage(self):
        """
        @return List of Metabook
        """
        pass

