:
eval 'exec perl -wS $0 ${1+"$@"}'
    if 0;
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This file incorporates work covered by the following license notice:
#
#   Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements. See the NOTICE file distributed
#   with this work for additional information regarding copyright
#   ownership. The ASF licenses this file to you under the Apache
#   License, Version 2.0 (the "License"); you may not use this file
#   except in compliance with the License. You may obtain a copy of
#   the License at http://www.apache.org/licenses/LICENSE-2.0 .
#

# creates the ilst control file for the
# help specific images

use File::Find;

$params = join "|", "",@ARGV,"";
($params =~ /-dir/) ? ($startdir = $params) =~ (s/.*-dir=([^\|]*).*$/$1/gs) : (($startdir = `pwd`) =~ s/\n//gs);
($params =~ /-pre/) ? ($pre = $params) =~ (s/.*-pre=([^\|]*).*$/$1/gs) : ($pre = "helpimg");

my $startdir_regexp = quotemeta($startdir);


if ( -d $startdir ) {
    find(sub{push @files, $File::Find::name if (($File::Find::name=~/\.png$/));},$startdir);
    foreach ( @files ) { s#.*$startdir_regexp[\\/]##; };
    for (sort(@files)) {
        print "%GLOBALRES%/$pre/$_\n";
    }
} else {
    &terminate("Cannot find $startdir.");
}


sub terminate {
    $err = shift;
    printf STDERR "$err\n\n";
    $msg = <<"MSG";
create_ilst.pl -dir=directory [-pre=string] 
-dir  root directory for the help images to
    be searched (default=current dir)
    Only *.png will be found.
-pre  define directory prefix (default=helpimg)
  
MSG
    die "$msg\n";
}
