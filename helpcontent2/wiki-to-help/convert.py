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

class Wine(object):
    #driveletter="j:" #final

    def __init__(self,workingDir,driveletter):
        """ Setup the wine environment. Granting access so that wine is able to output files to @workingDir.
        @workingDir will be accessable via @driveletter
        E.g. Wine("/tmp/dir","j:") """
        homedir = os.path.expanduser('~')
        wineprefix=os.path.join(homedir,".wine")
        drive=os.path.join(wineprefix,"dosdevices",driveletter)
        if os.path.lexists(drive):
            self.driveBak = drive+".bak"
            shutil.move(drive,self.driveBak)
        os.symlink(workingDir,drive)
        self.drive = drive
        #self.driveBak = driveBak

    def ex(self,*cmd):
        """ execute something with wine """
        cmd = [elem for elem in cmd]
        cmd = ["/usr/bin/wine"]+cmd
        r= (subprocess.Popen(cmd).wait())
        return r

    def __call__(self,*cmd):
        return self.ex(*cmd)

    def __del__(self):
        os.remove(self.drive)
        if hasattr(self,'driveBak'):
            shutil.move(self.driveBak,self.drive)




class Main(object):
    workingDir = "./test" # final
    mwpath='/usr/local/bin/' # final
    style='/usr/share/xml/docbook/stylesheet/docbook-xsl/htmlhelp/htmlhelp.xsl' # final

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

        self.wine = Wine(self.tmp,"j:")
        self.convert("test2.xml",self.workingDir)

    def convert(self,source,dest):
        """
        Create the converted files.
        @source XML-Dump-file
        @dest Directory for output
        """
        tmp = self.tmp
        try:
            os.mkdir(dest)
        except OSError:
            pass

        names = self.getArtNames(source)
        self.ex(self.mwpath+"mw-buildcdb","--input",source,"--output",tmp) \
        and self.ex(
            self.mwpath+"mw-render","--config=%s/wikiconf.txt"%(tmp),
            "-w","docbook","-o",tmp+"/docbook.xml",*names) \
        and (shutil.copy(tmp+'/docbook.xml',dest) or True) \
        and self.ex("/usr/bin/xsltproc","--nonet","--novalid","-o",tmp+'/',self.style,tmp+'/docbook.xml') \
        and (self.wine("c:\\htmlhelp\\hhc.exe","j:\\htmlhelp.hhp") or True) \
        and (shutil.copy(tmp+'/htmlhelp.chm',dest) or True)

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

