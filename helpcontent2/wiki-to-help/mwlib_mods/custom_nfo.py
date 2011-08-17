""" 
Enable looking for a custom nfo.json and siteinfo.json 

Author: Timo Richter
"""
import mwlib.cdbwiki
class WikiDB(mwlib.cdbwiki.WikiDB):
            def __init__(self, dir, prefix='wiki', lang="en"):
                try:
                    super(WikiDB,self).__init__(dir,prefix,lang)
                except(RuntimeError):
                    print("Warning: "+"could not get siteinfo for language %r" % (lang,))
                    print("Please set up a custom siteinfo and nfo.")
                self.nfo = self.get_data("nfo") or self.nfo
                self.siteinfo = self.get_data("siteinfo") or self.siteinfo

def apply():
    mwlib.cdbwiki.WikiDB=WikiDB

