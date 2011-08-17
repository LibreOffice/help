"""
New docbook grammar enables more tags.
"""

## Set up docbookwriter.grammar
import mwlib.docbookwriter
import docbook45grammar

def apply():
    mwlib.docbookwriter.grammar = docbook45grammar.grammar

