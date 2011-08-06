"""
This package sets up modifications and bugfixes for mwlib.
Usage: import mwlib_mods
"""

# The order of the imports is relevant!

import no_sections
no_sections.apply()

import docbook_internLinks
docbook_internLinks.apply()

import custom_nfo
custom_nfo.apply()


