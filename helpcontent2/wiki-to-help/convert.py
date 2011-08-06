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

import subprocess, tempfile, os, shutil

import mwlib_mods
from hhc import HHC
from mw import MW
from metabook_translated import MetabookTranslated

scriptpath=os.path.dirname(os.path.realpath(__file__) )

class Main(object):
    createChm = True # final
    keepTmp = True # final
    workingDir = "./test" # final
    #style=os.path.join(scriptpath,'xsl/htmlhelp/htmlhelp.xsl') # final
    style=os.path.join(scriptpath,'htmlhelp.xsl') # final

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

    def __init__(self):
        self.tmp = tempfile.mkdtemp()

        self.workingDir = os.path.abspath(self.workingDir)
        self.style = os.path.abspath(self.style)

        self.hhc = HHC()
        self.convert("test2.xml",self.workingDir)

    def createDir(self,path):
        try:
            os.mkdir(path)
        except OSError:
            pass

    @staticmethod
    def createMetabook(xmldump,output): # TODO: move to class Metabook
        """
        @xmldump String path
        @output String path
        """
        m = MetabookTranslated()
        jsonStructFile = os.path.join(scriptpath,"metabook.json")
        with open(jsonStructFile,"r") as f:
            m.loadTemplate(f)
        m(xmldump)
        with open(output,"w") as f:
            m.write(f)

    def convert(self,source,dest,startpage=None,title="LibreOffice"):
        """
        Create the converted files.
        @source XML-Dump-file
        @dest Directory for output
        @startpage Path to an html file
        """
        tmp = self.tmp
        self.createDir(dest)

        shutil.copy(os.path.join(scriptpath,"nfo.json"),tmp)
        #names = self.getArtNames(source)
        metabook=os.path.join(tmp,"metabook.json")
        self.createMetabook(source,metabook)
        
        MW.buildcdb(source,tmp)
        #MW.render("--config=%s/wikiconf.txt"%(tmp),
        #    "-w","docbook","-o",tmp+"/docbook.xml",*names)
        MW.render("--config=%s/wikiconf.txt"%(tmp),
            "-w","docbook","-o",tmp+"/docbook.xml","-m",metabook,"--title",title)
        #and mwlib.apps.render
        #self.ex(self.mwpath+"mw-buildcdb","--input",source,"--output",tmp) and \
        #self.ex(
        #    self.mwpath+"mw-render","--config=%s/wikiconf.txt"%(tmp),
        #    "-w","docbook","-o",tmp+"/docbook.xml",*names) \
        (shutil.copy(tmp+'/docbook.xml',dest) or True) \
        and self.ex("/usr/bin/xsltproc","--nonet","--novalid","-o",tmp+'/',self.style,tmp+'/docbook.xml') \
        and self.setStartpage(startpage) \
        and self.createChm \
        and (self.hhc(tmp) or True) \
        and (shutil.copy(os.path.join(tmp,'htmlhelp.chm'),dest) or True)

    def setStartpage(self,startpage):
        """
        Private.
        Copies @startpage to our tmp dir so that it will be used as the start page.
        @return False if @startpage doesnt exist, otherwise True.
        """
        if startpage is None: return True
        filename="index.html"
        if not os.path.exist(startpage): return False
        os.remove(os.path.join(self.tmp,filename))
        shutil.copy(startpage, os.path.join(self.tmp,filename))
        return True

    def __del__(self):
        if not self.keepTmp:
            shutil.rmtree(self.tmp) # remove temp files

if __name__ == '__main__':
    Main()

