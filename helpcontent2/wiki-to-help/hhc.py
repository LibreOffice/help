import platform, os, subprocess

class HHC(object):
    """ Class for execution of Html Help Compiler """
    hhcexe="c:\\htmlhelp\\hhc.exe"

    def __init__(self):
        pass

    def exWindows(self,source):
        """ Private. Compile @source calling HHC natively under Windows """
        cmd=[self.hhcexe,os.path.join(source,"htmlhelp.hhp")]
        r = (subprocess.Popen(cmd).wait())
        return r

    def exWine(self,source):
        """ Private. Compile @source calling HHC via Wine """
        #dirname = os.path.dirname(source)
        wine = Wine(source,"j:")
        r = wine(self.hhcexe,"j:\\htmlhelp.hhp")
        del wine
        return r

    def __call__(self,source):
        """
        Converts @source with HHC
        @source path to input directory that contains htmlhelp.hhp
        """
        windows=(platform.system()=="Windows")
        if windows is False:
            self.exWine(source)
        else:
            self.exWindows(source)

class Wine(object):
    # TODO: this should be a singleton
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
