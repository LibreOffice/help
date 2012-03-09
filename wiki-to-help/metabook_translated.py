import metabook
import re, os

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
    This metabook contains all articles with translated titles.
    This concrete metabook expects article titles in this form:
        Category/Title/lang
    Comments include this:
        {{Lang|translatedTitle}}
    """
    ArticleClass=ArticleTranslated
    artTags = ["title","comment"]

class LanguageSeparator(object):
    """
    A translated metabook is a metabook where all titles are in the destination
    language. 
    This class splits a translated metabook into many books with homogenous languages.
    """
    books={} # Dict<Str lang, Metabook>
    sortedItems={} # Dict<Str lang, List<TranslatedArticle>>
    items=[] # List<TranslatedArticle>

    def __init__(self, book):
        self.book = book
        self.items = book.items

    def splitItemsByLanguage(self):
        """
        Sort the articles in self.items by language and put them to self.sortedItems
        """
        sortedItems={}
        for item in self.items:
            if item.lang in sortedItems.keys():
                sortedItems[item.lang].append(item)
            else:
                sortedItems[item.lang] = [item]
        self.sortedItems = sortedItems
        #return sortedItems

    def createBooksByLanguage(self):
        """
        Generate metabooks to self.books.
        Create a metabook for each language from self.sortedItems.
        """
        for lang, items in self.sortedItems.iteritems():
            m = self.book.getClone()
            m.items = items
            m.lang = lang
            self.books[lang] = m
        
    @staticmethod
    def fromFileToFiles(jsonStructFile,xmldump,output): 
        """
        Creates a Metabook from a file and writes it to one file per language.
        Short cut Function. This loads a metabook template file, creates the 
            metabook content from @xmldump and writes the book to @output.
        @jsonStructFile String path to Metabook template
        @xmldump String path
        @output String path to output directory
        @return Dict<String lang, String output>
        """
        m = MetabookTranslated()
        with open(jsonStructFile,"r") as f:
            m.loadTemplate(f)

        m.loadArticles(xmldump)
        ls = LanguageSeparator(m)
        ls.splitItemsByLanguage()
        ls.createBooksByLanguage()

        pathlist={}

        for lang, book in ls.books.iteritems():
            book.createBook()
            dest = os.path.join(output,"metabook_%s.json" % lang)
            pathlist[lang] = dest
            with open(dest,"w") as f:
                book.write(f)
        return pathlist

