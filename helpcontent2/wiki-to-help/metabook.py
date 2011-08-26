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
    """
    ArticleClass = Article # final
    artTags = ["title"] # final

    m = {} # Dict metabook
    source = "" # String input file, xmldump
    dest = "" # FileObject destination of json metabook

    def getClone(self):
        m = Metabook()
        m.m = self.m.copy()
        #m.dest = self.dest
        #m.source = self.source
        return m

    def getArtTags(self,filename,tagnames):
        """ 
        Get Article Tags
        Reads all title tags from an xml file and returns a list of all titles.
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
        self.m = json.load(jsonStruct)
        #self.m = self.load_data(source)

    def setArticles(self):
        pages = self.getArtTags(self.source,self.artTags)
        items=[]
        for page in pages:
            #item=self.itemTag.copy()
            #item["title"] = name
            item = self.ArticleClass(page)
            if item.getInclude():
                items.append(item.toDict())
        self.m["items"] = items

    def __call__(self,source):
        """
        Creates a metabook for @source and saves it to @dest
        @source xml-dump
        @dest File object as destination of json-file
        """
        self.source = source
        #self.dest = dest
        #self.loadStructure()
        self.setArticles()

    def write(self,dest):
        json.dump(self.m,dest)
        

