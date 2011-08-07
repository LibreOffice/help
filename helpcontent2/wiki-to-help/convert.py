#!/usr/bin/env python
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

import mwlib_mods
from hhc import HHC
from mw import MW
from metabook_translated import MetabookTranslated
from metabook_translated import LanguageSeparator

scriptpath=os.path.dirname(os.path.realpath(__file__) )

class Main(object):
    ''' Defines program parameters and returns them as a dictionary '''
    def parseArgs(self):
        parser = argparse.ArgumentParser(description='Conversion from a mediawiki xml-dumpfile to helpfiles')
        parser.add_argument("--startpage", metavar="Path", dest="startpage", default=None, type=str, help="Sets a HTML-file as the start page")
        parser.add_argument("--keep", dest="keepTmp", default=False, action='store_true', help="Keeps temporary files in /tmp")
        parser.add_argument("--only-en", dest="onlyEn", action='store_true', default=False, help="Convert only English articles")
        parser.add_argument("--no-chm", dest="createChm", default=True, action='store_false', help="Avoids creation of a CHM file at the end")
        parser.add_argument("input", type=str, help="XML input")
        parser.add_argument("output", type=str, help="Directory for output")

        return parser.parse_args()

    def __init__(self):
        args = self.parseArgs()
        r = Converter(
            keepTmp=args.keepTmp, 
            createChm=args.createChm,
            source=args.input,
            dest=args.output,
            startpage=args.startpage,
            onlyEn=args.onlyEn,
        )()
        exit(int(not r))


class Converter(object):
    createChm = None # 
    keepTmp = None # 
    #workingDir = "./test" # final
    #style=os.path.join(scriptpath,'xsl/htmlhelp/htmlhelp.xsl') # final
    style=os.path.join(scriptpath,'htmlhelp.xsl') # final
    title="LibreOffice" # final

    tmp=None

    def ex(self,*cmd):
        """
        Execute a program
        @cmd Command, args
        @return boolean True if succeed
        """
        cmd = [elem for elem in cmd]
        print cmd
        return (subprocess.Popen(cmd).wait() == 0)

    def __init__(self,source,dest,onlyEn,keepTmp=False,createChm=True,startpage=None):
        """
        @source XML-Dump-file
        @dest Directory for output
        @startpage Path to an html file
        """
        self.createChm = createChm
        self.keepTmp=keepTmp
        self.tmp = tempfile.mkdtemp()
        self.style = os.path.abspath(self.style)
        self.hhc = HHC()
        source = os.path.abspath(source)
        dest = os.path.abspath(dest)
        if startpage is not None:
            startpage = os.path.abspath(startpage)
        self.source=source
        self.dest=dest
        self.startpage=startpage
        self.onlyEn = onlyEn
        
    def createDir(self,path):
        try:
            os.mkdir(path)
        except OSError:
            pass

    def __call__(self):
        """
        Create the environment for conversion and call convert()
        @return boolean Success
        """
        tmp = self.tmp
        self.createDir(self.dest)

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
        tmp = self.tmp
        docbookfile = os.path.join(tmp,"docbook_%s.xml"%lang)
        chmDest = os.path.join(self.dest,lang+".chm")

        MW.render("--config=%s/wikiconf.txt"%(tmp),
            "-w","docbook","-o",docbookfile,"-m",metabook,"--title",self.title)
        shutil.copy(docbookfile,self.dest)
        if not self.ex("/usr/bin/xsltproc","--nonet","--novalid","-o",tmp+'/',self.style,docbookfile): return False
        self.setStartpage(self.startpage)
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

