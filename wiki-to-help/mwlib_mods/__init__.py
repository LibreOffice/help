"""
This package sets up modifications and bugfixes for mwlib.
Usage: import mwlib_mods
"""

# The order of the imports is relevant!

import docbook_grammar
docbook_grammar.apply()

import docbook_table_tags
docbook_table_tags.apply()

import docbookwriter_options
docbookwriter_options.apply()

import no_sections
no_sections.apply()

import docbook_internLinks
docbook_internLinks.apply()

import custom_nfo
custom_nfo.apply()

import indexterm_from_title
indexterm_from_title.apply()

