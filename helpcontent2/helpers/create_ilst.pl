:
eval 'exec perl -wS $0 ${1+"$@"}'
    if 0;
#*************************************************************************
#
#   OpenOffice.org - a multi-platform office productivity suite
#
#   $RCSfile: create_ilst.pl,v $
#
#   $Revision: 1.5 $
#
#   last change: $Author: kz $ $Date: 2006-07-05 21:44:11 $
#
#   The Contents of this file are made available subject to
#   the terms of GNU Lesser General Public License Version 2.1.
#
#
#     GNU Lesser General Public License Version 2.1
#     =============================================
#     Copyright 2005 by Sun Microsystems, Inc.
#     901 San Antonio Road, Palo Alto, CA 94303, USA
#
#     This library is free software; you can redistribute it and/or
#     modify it under the terms of the GNU Lesser General Public
#     License version 2.1, as published by the Free Software Foundation.
#
#     This library is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#     Lesser General Public License for more details.
#
#     You should have received a copy of the GNU Lesser General Public
#     License along with this library; if not, write to the Free Software
#     Foundation, Inc., 59 Temple Place, Suite 330, Boston,
#     MA  02111-1307  USA
#
#*************************************************************************

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
