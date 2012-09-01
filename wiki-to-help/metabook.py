import json
import xml.dom.minidom as minidom

class Article(object):
    itemTag = {"content_type":"text/x-wiki","type":"article"}
    #itemTag = {"content_type":"text/x-wiki","type":"article","wikiident":"lo","url":"http://asdlkf/","source-url":"http://sourceurl/","source":"http://source/"}
    attributes = {}
    include = True #""" True if this article should be included in the metabook """
    
    def __init__(self,attributes):
        self.attributes = attributes

    def getInclude(self):
        """ @return True if this article should be included in the metabook """
        return self.include

    def toDict(self):
        #if not self.include: return None
        article = self.itemTag.copy()
        article.update(self.attributes) # merge dicts
        return article

class Metabook(object):
    """ 
    I am your metabook and wish you a pleasant evening. 
    Sequence of usage:
        m = Metabook()
        m.loadTemplate(...)
        m.loadArticles(xml input)
        m.createBook()
        m.write(output)
    If template, in- and output are files, use fromFileToFile()
    """
    ArticleClass = Article # final
    artTags = ["title"] # final

    m = {} # Dict metabook
    template = None
    items = []
    #source = "" # String input file, xmldump
    #dest = "" # FileObject destination of json metabook

    def getClone(self):
        m = Metabook()
        m.template = self.template # No copy() neccessary here
        m.ArticleClass = self.ArticleClass
        m.artTags = self.artTags
        #m.m = self.m.copy()
        #m.dest = self.dest
        return m

    def getArtTags(self,filename,tagnames):
        """ 
        Get Article Tags
        Reads all specified tags from an xml file and returns a list of all tags.
        @filename XML-file
        @tagnames List of String Tagnames
        @return List of Dict<String Tagname, String Value>
        """
        dom=minidom.parse(filename)
        out = []

        elements=dom.getElementsByTagName("page")
        
        for element in elements:
            tagdict = {}
            for tagname in tagnames:
                tags = element.getElementsByTagName(tagname)
                if len(tags) > 0:
                    tagdict[tagname] = self.getText(tags[0])
                else:
                    tagdict[tagname] = ""
            out.append(tagdict)
        return out

    def getText(self,element):
        """
        @element xml Node
        @return String content
        """
        return element.childNodes[0].data

    def load_data(self,filename):
        """ Unserialize data from jsonfile """
        with open(filename, "r") as infile:
            outdict = json.load(infile)
        return outdict

    def loadTemplate(self,jsonStruct):
        """ 
        Loads an existing json file at the beginning 
        @jsonStruct File object
        """
        self.template = json.load(jsonStruct)
        #self.m = self.load_data(source)

    def loadArticles(self,source):
        """
        Loads the articles and saves them as objects to self.items
        """
        pages = self.getArtTags(source,self.artTags)
        self.items = [self.ArticleClass(page) for page in pages]
        """return
        items=[]
        for page in pages:
            item = self.ArticleClass(page)
            if item.getInclude():
                items.append(item.toDict())
        self.m["items"] = items
        """

    def createBook(self):
        """
        Convert all article objects to dicts and merge them with the template.
        The result is saved to self.m
        """
        if self.template is None:
            self.m = []
        else:
            self.m = self.template.copy()
        self.m["items"] = []
        for item in self.items:
            if item.getInclude():
                self.m["items"].append(item.toDict())

    def __call__(self,source):
        """
        Creates a metabook for @source and writes it to self.m. To continue, 
            use write()
        @source xml-dump
        """
        self.loadArticles(source)
        self.createBook()

    def write(self,dest):
        json.dump(self.m,dest)
        
    def fromFileToFile(jsonStructFile,xmldump,output): 
        """
        Creates a Metabook from a file and writes it to a file.
        Short cut Function. This loads a metabook template file, creates the 
            metabook content from @xmldump and writes the book to @output.
        @jsonStructFile String path to Metabook template
        @xmldump String path
        @output String path
        """
        #m = MetabookTranslated()
        with open(jsonStructFile,"r") as f:
            self.loadTemplate(f)
        self.__call__(xmldump)
        with open(output,"w") as f:
            self.write(f)


