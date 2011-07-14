#!/usr/bin/env python
"""
Convert an XML-Dump to platformspecific help files.
Copyright 2011 Timo Richter
Licensed under GNU GPLv3

This program depends on:
mwlib
python
python-lxml
xsltproc
Microsoft HHC: http://go.microsoft.com/fwlink/?LinkId=14188


"""

import xml.dom.minidom as minidom
import subprocess, tempfile, os, shutil

from hhc import HHC
from mw import MW

scriptpath=os.path.dirname(os.path.realpath(__file__) )

class Main(object):
    workingDir = "./test" # final
    #mwpath='/usr/local/bin/' # final
    style=os.path.join(scriptpath,'xsl/htmlhelp/htmlhelp.xsl') # final

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

    def convert(self,source,dest,startpage=None):
        """
        Create the converted files.
        @source XML-Dump-file
        @dest Directory for output
        @startpage Path to an html file
        """
        tmp = self.tmp
        try:
            os.mkdir(dest)
        except OSError:
            pass
        names = self.getArtNames(source)
        MW.buildcdb(source,tmp)
        MW.render("--config=%s/wikiconf.txt"%(tmp),
            "-w","docbook","-o",tmp+"/docbook.xml",*names)

        #and mwlib.apps.render
        #self.ex(self.mwpath+"mw-buildcdb","--input",source,"--output",tmp) and \
        #self.ex(
        #    self.mwpath+"mw-render","--config=%s/wikiconf.txt"%(tmp),
        #    "-w","docbook","-o",tmp+"/docbook.xml",*names) \
        (shutil.copy(tmp+'/docbook.xml',dest) or True) \
        and self.ex("/usr/bin/xsltproc","--nonet","--novalid","-o",tmp+'/',self.style,tmp+'/docbook.xml') \
        and self.setStartpage(startpage) \
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
        shutil.rmtree(self.tmp) # remove temp files
        pass

    def getArtNames(self,filename):
        """
        Get Article Names
        Reads all title tags from an xml file and returns a list of all titles.
        @filename XML-file
        @return List of Strings
        """
        dom=minidom.parse(filename)
        elements=dom.getElementsByTagName("title")
        names=[]
        for element in elements:
            name=element.childNodes[0].data
            names.append(name)
        return names

if __name__ == '__main__':
    Main()

