#!/usr/bin/env python
#!/usr/bin/python -i
"""
Convert an XML-Dump to platformspecific help files.
Copyright 2011 Timo Richter

This program depends on:
mwlib
python
python-lxml
xsltproc
Microsoft HHC: http://go.microsoft.com/fwlink/?LinkId=14188


"""

import subprocess, tempfile, os, shutil, argparse

#import mwlib_mods # is being imported. see below
from hhc import HHC
from mw import MW
from metabook_translated import MetabookTranslated
from metabook_translated import LanguageSeparator
from executor import Executor

scriptpath=os.path.dirname(os.path.realpath(__file__) )

class Main(object):
    ''' Defines program parameters and returns them as a dictionary '''
    def parseArgs(self):
        parser = argparse.ArgumentParser(description='Conversion from a mediawiki xml-dumpfile to helpfiles')
        parser.add_argument("--startpage", metavar="PATH", dest="startpage", default=None, type=str, help="Sets a HTML-file as the start page")
        parser.add_argument("--images", metavar="PATH", dest="imgPath", default=None, type=str, help="Uses images from PATH. PATH is a zipfile or a directory.")
        parser.add_argument("--keep", dest="keepTmp", default=False, action='store_true', help="Keeps temporary files in /tmp")
        parser.add_argument("--only-en", dest="onlyEn", action='store_true', default=False, help="Converts only English articles")
        parser.add_argument("--no-chm", dest="createChm", default=True, action='store_false', help="Avoids creation of a CHM file at the end")
        parser.add_argument("-v", dest="verbose", default=False, action='store_true', help="Verbose")
        parser.add_argument("input", type=str, help="XML input")
        parser.add_argument("output", type=str, help="Directory for output")

        return parser.parse_args()

    def __init__(self):
        args = self.parseArgs()
        import mwlib_mods
        r = Converter(
            keepTmp=args.keepTmp, 
            createChm=args.createChm,
            source=args.input,
            dest=args.output,
            startpage=args.startpage,
            onlyEn=args.onlyEn,
            imgPath=args.imgPath,
            verbose=args.verbose,
        )()
        exit(int(not r))


class Converter(object):
    verbose=False
    createChm = None # 
    keepTmp = None # 
    #style=os.path.join(scriptpath,'xsl/htmlhelp/htmlhelp.xsl') # final
    style=os.path.join(scriptpath,'htmlhelp.xsl') # final
    title="Book" # final

    tmp=None
    includeFiles=[]

    def __init__(self,source,dest,onlyEn,imgPath,verbose,
        keepTmp=False,createChm=True,startpage=None):
        """
        Parameters are documented in Main.parseArgs()
        """
        self.createChm = createChm
        self.keepTmp=keepTmp
        self.tmp = tempfile.mkdtemp()
        self.style = os.path.abspath(self.style)
        source = os.path.abspath(source)
        dest = os.path.abspath(dest)
        if startpage is not None:
            startpage = os.path.abspath(startpage)
        self.source=source
        self.dest=dest
        self.startpage=startpage
        self.onlyEn = onlyEn
        self.imgPath = imgPath
        self.verbose = verbose
        self.ex = Executor(showErr=verbose,showOutput=True,showCmd=verbose)
        self.hhc = HHC(showErr=True,showOutput=verbose,showCmd=verbose)
        self.title = self.getTitle(self.title)

    def getTitle(self,default=None):
        """
        If given, return TEXT from <siteinfo><sitename>TEXT</sitename></siteinfo>
            in xml file self.source.
        Otherwise return @default
        """
        import xml.dom.minidom
        print "Loading title"
        dom = xml.dom.minidom.parse(self.source)
        try:
            siteinfo = dom.getElementsByTagName("siteinfo")[0]
            sitename = siteinfo.getElementsByTagName("sitename")[0]
            name = sitename.childNodes[0].data
        except IndexError:
            return default
        else:
            return name
        
    def createDir(self,path):
        try:
            os.mkdir(path)
        except OSError:
            pass

    def setupImgPath(self):
        """
        If --images is not given, the path will be in the format "images/name.jpg".
        If --images is given a zipfile, it is being extracted to "images/".
        If --images is a directory, it is being copied to "images/".
        The filenames in images/ are being stored to self.includeFiles.
        """ 
        imgDest = "images" # puts images to output/imgDest/
        if not self.imgPath:
            self.imgPath = os.path.join(imgDest,"IMAGENAME")
            return
        extension = os.path.splitext(self.imgPath)[1].lower()
        imgTmp = os.path.join(self.tmp,imgDest)
        print "Copying images..."
        if extension == ".zip":
            self.ex("unzip","-q","-o","-j","-d",imgTmp,self.imgPath)
        else:
            shutil.copytree(self.imgPath,imgTmp)
        shutil.copytree(imgTmp, os.path.join(self.dest,imgDest) )
        self.imgPath = os.path.join(imgDest,"IMAGENAME")
        # Save filenames for inclusion in chm
        for fname in os.listdir(imgTmp):
            fpath = os.path.join(imgDest,fname)
            self.includeFiles.append(fpath)

    def writeHhp(self):
        """
        Writes changes to the .hhp-file.
        self.includeFiles will be flushed to the hhp.
        """
        hhp=os.path.join(self.tmp,"htmlhelp.hhp")
        with open(hhp,"a") as f:
            f.write("\n".join(self.includeFiles))

    def __call__(self):
        """
        Create the environment for conversion and call convert()
        @return boolean Success
        """
        tmp = self.tmp
        self.createDir(self.dest)

        print "Working directory: "+tmp

        self.setupImgPath()

        shutil.copy(os.path.join(scriptpath,"nfo.json"),tmp)
        metabook_template = os.path.join(scriptpath,"metabook.json")
        ls = LanguageSeparator.fromFileToFiles(metabook_template,self.source,tmp)
        MW.buildcdb(self.source,tmp)

        if self.onlyEn:
            return self.convert("en",ls["en"])
        else:

            for lang, metabook in ls.iteritems():
                if not self.convert(lang,metabook): return False

    def convert(self,lang,metabook):
        """
        Private.
        This function executes the programs for the conversion.
        @lang Language of book
        @metabook Path to metabook-json-file
        """
        print "Rendering language "+lang
        tmp = self.tmp
        docbookfile = os.path.join(tmp,"%s.xml"%lang)
        chmDest = os.path.join(self.dest,lang+".chm")

        renderArgs = ("-L",lang,"-W","imagesrcresolver=%s"%self.imgPath,
            "--config=%s/wikiconf.txt"%(tmp),
            "-w","docbook","-o",docbookfile,"-m",metabook,"--title",self.title)
        MW.quietCall(MW.render,renderArgs,showErr=self.verbose)
        shutil.copy(docbookfile,self.dest)
        print "Parsing docbook"
        if not self.ex("/usr/bin/xsltproc","--nonet","--novalid","-o",tmp+'/',self.style,docbookfile): return False
        self.setStartpage(self.startpage)
        self.writeHhp()
        if self.createChm:
            print("Compiling chm...")
            self.hhc(tmp)
            shutil.copy(os.path.join(tmp,'htmlhelp.chm'),chmDest)
        return True

    def setStartpage(self,startpage):
        """
        Private.
        Copies @startpage to our tmp dir so that it will be used as the start page.
        @return False if @startpage doesnt exist, otherwise True.
        """
        if startpage is None: return True
        filename="index.html"
        if not os.path.exists(startpage): return False
        os.remove(os.path.join(self.tmp,filename))
        shutil.copy(startpage, os.path.join(self.tmp,filename))
        return True

    def __del__(self):
        if not self.keepTmp:
            shutil.rmtree(self.tmp) # remove temp files

if __name__ == '__main__':
    Main()

