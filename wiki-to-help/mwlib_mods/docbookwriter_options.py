"""
This enables -L, --language and -W for docbook output.
Additionally the magic word IMAGENAME will contain the imagename instead of "IMAGE:imagename"

Example:
    mw-render -w docbook -L de -W debug=True;imagesrcresolver=/home/images/IMAGENAME

The content of writer() belongs to the mwlib.

"""

from mwlib.docbookwriter import *
def writer(env, output, status_callback, **args): # changed
    """ This is the function for external use. It is called by apps.render """
    if status_callback:
        buildbook_status = status_callback.getSubRange(0, 50)
    else:
        buildbook_status = None
    book = writerbase.build_book(env, status_callback=buildbook_status)
    scb = lambda status, progress :  status_callback is not None and status_callback(status=status, progress=progress)
    scb(status='preprocessing', progress=50)
    for c in book.children:
        preprocess(c)   
    scb(status='rendering', progress=60)
    
    args["language"] = args["lang"] # changed
    del args["lang"] # changed
    mwlib.docbookwriter.DocBookWriter(env, status_callback=scb, documenttype="book", **args).writeBook(book, output=output) # changed

def setupWriter():
    mwlib.docbookwriter.writer = writer
    mwlib.docbookwriter.writer.options = \
        ["documenttype","lang","imagesrcresolver","debug"]



import mwlib.docbookwriter
class MyDocBookWriter(mwlib.docbookwriter.DocBookWriter):
    def dbwriteImageLink(self, obj): 
        if obj.target:
            name = obj.target
            obj.target = name[name.find(":") + 1:]
        return super(MyDocBookWriter,self).dbwriteImageLink(obj)
            
def setupDocBookWriter():
    mwlib.docbookwriter.DocBookWriter = MyDocBookWriter



def apply():
    setupWriter()
    setupDocBookWriter()


