#import mwlib.cdbwiki, mwlib.apps.render, mwlib.apps
import mwlib.apps
import sys

class MW(object):
    """ 
    Use this adapter class to call mwlib within python.
    Example: import mw; MW.buildcdb("in.xml","out")
    """

    @staticmethod
    def _setArgs(function,args):
        """ Set sys.argv for @function """
        bak = sys.argv
        args=("nothing",)+args
        dec=[x.encode() for x in args]
        sys.argv=dec
        r=function()
        sys.argv=bak
        return r

    @staticmethod
    def buildcdb(source,dest):
        args=("--input",source,"--output",dest)
        return MW._setArgs(mwlib.apps.buildcdb,args)
        #mwlib.cdbwiki.BuildWiki(*args)

    @staticmethod
    def render(*args):
        import mwlib.apps.render
        return MW._setArgs(mwlib.apps.render.Main(),args)
