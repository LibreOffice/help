#!/usr/bin/perl

# creates the ilst control file for the
# help specific images

$helpdirprefix = "helpcontent2/source/";

$params = join "|", "",@ARGV,"";
($params =~ /-dir/) ? ($startdir = $params) =~ (s/.*-dir=([^\|]*).*$/$1/gs) : (($startdir = `pwd`) =~ s/\n//gs);
($params =~ /-out/) ? ($outdir = $params) =~ (s/.*-out=([^\|]*).*$/$1/gs) : (($outdir = `pwd`) =~ s/\n//gs);
($params =~ /-pre/) ? ($outdir = $params) =~ (s/.*-pre=([^\|]*).*$/$1/gs) : ($pre = "/res/helpimg/");

if (opendir DIR, $startdir) {
    print $startdir;
    @files = grep /png$/, readdir DIR;
    for (sort(@files)) {
        print "%GLOBAL%".$pre.$_."\n";
    }
} else {
    &terminate("Cannot access $startdir.");
}


sub terminate {
    $err = shift;
    print "$err\n\n";
    $msg = <<"MSG";
create_ilst.pl -dir=[directory name] -out=[directory name]
  -dir  root directory for the help images to
          be searched (default=current dir)
                Only *.png will be found.
  -pre  directory prefix (default=/res/helpimg/)
    -out  output directory for the helpimg.ilst file
          (default=current dir)
  
MSG
    die "$msg\n";
}