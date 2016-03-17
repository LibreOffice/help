#/bin/bash
find . -type f -name "*.xhp" -exec sed -i 's/UTF-8"?>/UTF-8"?><?xml-stylesheet type="text\/xsl" href="\/online_transform.xsl"?>/g' {} +
