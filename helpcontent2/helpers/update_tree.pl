#!/usr/bin/perl

use File::Find;
use File::Basename;
use Benchmark;


$t0 = new Benchmark;
# update the tree files in helpcontent2/source/auxiliary/*

$| = 1;
($scriptname = `pwd`) =~ s/\n/\/$0/;
($treeroot = $scriptname) =~ s/\/update_tree.pl/\/..\/source\/auxiliary/;
($sourceroot = $treeroot) =~ s/source\/auxiliary$/source/;
$treestrings = "$sourceroot/text/shared/tree_strings.xhp";

$params = join "|", "",@ARGV,"";
($params =~ /-langdir/) ? ($langdir = $params) =~ (s/.*-langdir=([^\|]*).*$/$1/gs) : (($langdir = '***ALL***'));


# Get the English tree files as master
#-------------------------------
# Update English from xhp
#-------------------------------
&do_english;

#-------------------------------
# Update localizations from sdf
#-------------------------------
# read all strings with id "tit" from all localize.sdf files
&read_loctit;
&read_loctree;

if ($langdir eq '***ALL***') {
    if (opendir AUX, "$treeroot") {
        @langs = grep { /^(?!(\.|CVS|en-US))/ && -d "$treeroot/$_"} readdir AUX;
      closedir AUX;
    } else {
        &terminate("Cannot open directory $treeroot");
    }
} else {
    @langs = $langdir;
}

for $l(@langs) {
    &do_lang($l);
}

$t1 = new Benchmark;
$td = timediff($t1, $t0);
print timestr($td),"\n";


####################
# SUBS
####################
sub terminate {
    $err = shift;
    print "$err\n\n";
    $msg = <<"MSG";

update_tree.pl [-langdir=language]
    -langdir    Proceed files in this language subdirectory
              If no langdir is given all subdirs are processed.

   Updates the *.tree files.
   At first, the English file is updated based on the English
   help topic titles as read from the help files. Then, the
   localized tree files are written based on the English tree
   file and the localized help topic titles.
MSG
    die "$msg\n";
}

#---------------------------------------------------
sub do_english {
    print "Processing en-US\n";
    undef %helpsection; undef %node; undef %topic;
    &readtreestrings;
  &gettreefiles;
    &processtreefiles('en-US');	
}

#---------------------------------------------------
sub do_lang {
    $lng = shift;
    print "\n\n---------------------------------------------------\nProcessing $lng\n";
    undef %helpsection; undef %node; undef %topic; undef %title;
    &readl10ntreestrings($lng);
    &readl10ntitles($lng);
    &processtreefiles($lng);
    print "\n";
}

#---------------------------------------------------
sub readtreestrings {
    print "Reading tree strings for en-US...";
    if (open TREE, $treestrings) {
        while (<TREE>) {
            chomp;
            s/<\/*help:productname>//gis;	
            if (/help_section/) {
                s/^\s*<.*help_section//;
                s/<\/.*$//;
                ($id = $_) =~ s/^.*id=&quot;(\d+)&quot;.*$/$1/;
                ($title = $_) =~ s/^.*title=&quot;(.*)&quot;.*$/$1/;
                $helpsection{$id} = $title; 
            }
        
            if (/node id=/) {
                s/^\s*<.*node //;
                s/<\/.*$//;
                ($id = $_) =~ s/^.*id=&quot;(\d+)&quot;.*$/$1/;
                ($title = $_) =~ s/^.*title=&quot;(.*)&quot;.*$/$1/;
                $node{$id} = $title;
            }
        }
      close TREE;
    } else {
    &terminate("Error opening $treeview");
    }
    print "done\n";
}

#---------------------------------------------------
sub readl10ntreestrings {
    my $lng = shift;
    print "Reading tree strings for $lng...";
    for (@{$l10ntreestrings{$lng}}) {
        @tokens = split /\t/, $_;
        ($file = $tokens[1]) =~ s/\\/\//g;
        $file =~ s/.*text\///g;
      $id = $tokens[4];	$lang = $tokens[9];	$cnt = $tokens[10];
        if ($cnt =~ /help_section/) {
                s/^\s*<.*help_section//;
                ($id = $cnt) =~ s/^.*id="(\d+)".*$/$1/;
                ($title = $cnt) =~ s/^.*title="(.*)".*$/$1/;
                $helpsection{$id} = $title; 
        }
        if ($cnt =~/node id=/) {
            s/^\s*<.*node //;
            ($id = $cnt) =~ s/^.*id="(\d+)".*$/$1/;
            ($title = $cnt) =~ s/^.*title="(.*)".*$/$1/;
            $node{$id} = $title;
        }
    }
    print "done\n";
}

#---------------------------------------------------
sub readl10ntitles {
    my $lng = shift;
    print "Reading titles for $lng...";
    
    for $t(@{$l10ntitles{$lng}}) {
        @tokens = split /\t/, $t;
        ($file = $tokens[1]) =~ s/\\/\//g;
        $file =~ s/.*text\///g;
        $id = $tokens[4];
        $lang = $tokens[9];
        $cnt = $tokens[10];
        $title{"text/$file"} = $cnt;
        #print "$file\n";
    }
    print "done\n";
}	

#------------------------------------
sub gettreefiles {
    # Read the tree files from the directory
    # this list is also used for all foreign languages
    print "Reading tree files...";
    if (opendir ENUS, "$treeroot/en-US") {
        @treeviews = grep /\.tree/, readdir ENUS;
      closedir ENUS;
    } else {
        &terminate("Cannot open directory $treeroot/en-US");
    }
    print "done\n";
}

#------------------------------------
sub processtreefiles {
    $lng = shift;
    
    for $tv(@treeviews) {
      print "\nProcessing $tv\n";
        @lines = &readtv("$treeroot/en-US/$tv");
        print "Read ".scalar @lines." lines\n";
        for $l(@lines) {
                
            if ($l =~ /topic/) {
                ($id = $l) =~ s/^.*id="([^"]*)".*$/$1/gis;
                ($module = $id) =~ s/^([^\/]*).*$/$1/;
                $id =~ s/^.*?\///;
                $file = "$sourceroot/$id";

                if ($lng eq 'en-US') { # english comes from the file
                    if (open F,$file) {
                        print ".";
                        undef $/; $cnt = <F>; close F;
                        $cnt =~ s/^.*<title[^>]+id="tit"[^>]*>([^<]*)<\/title>.*$/$1/gis;
                        $cnt =~ s/&apos;/\'/gis; $cnt =~ s/&amp;/+/gis;
                        $cnt =~ s/&quot;/\'/gis; $cnt =~ s/&/+/gis;
                        $l = "<topic id=\"$module/$id\">$cnt</topic>\n";
                    } else {
                        print "!";
                        $l = "<!-- removed $module/$id -->\n";
                    }
                } else { # localized comes from the localize sdf
                    if (defined($title{$id})) {
                        print ".";
                        $l = "<topic id=\"$module/$id\">$cnt</topic>\n";
                    } else {
                        print "!";
                    }
                }
            }
    
            if ($l =~/<node/) {
                ($id = $l) =~ s/^.*id="(\d+)".*$/$1/gis;
                if ($lng eq 'en-US') {
                    if (defined($node{$id})) {
                        $l =~ s/title="(.*)"/title="$node{$id}"/;
                    } else {
                        $l =~ s/title="(.*)"/title="NOTFOUND:$id"/;
                    }
                } else {
                    if (defined($node{$id})) {
                        $l =~ s/title="(.*)"/title="$node{$id}"/;
                    }
                }
            }
    
            if ($l =~/<help_section/) {
                ($id = $l) =~ s/^.*id="(\d+)".*$/$1/gis;
                if ($lng eq 'en-US') {
                    if (defined($helpsection{$id})) {
                        $l =~ s/title="(.*)"/title="$helpsection{$id}"/;
                    } else {
                        $l =~ s/title="(.*)"/title="NOTFOUND:$id"/;
                    }
                } else {
                    if (defined($helpsection{$id})) {
                        $l =~ s/title="(.*)"/title="$helpsection{$id}"/;
                    }
                }
            }
      }
  
        $tvout = "$treeroot/$lng/$tv";
      if (open TV, ">$tvout") {
        for $line(@lines) { 
                $line =~ s/\$\[officename\]/%PRODUCTNAME/g;
                $line =~ s/\$\[officeversion\]/%PRODUCTVERSION/g;
                print TV $line;	
            }  
            close TV;
      } else {
            &terminate("Cannot write to $tvout");
        }
    }
}

#------------------------------------
sub readtv {
    my $f = shift;
    if (open TV, $f) {
         $/ = "\n";
       my @l = <TV>;
       close TV;
        return @l;
     } else { 
        &terminate("Error opening $f"); 
    }
}

#------------------------------------
sub read_loctit {
    print "\n\nReading localized titles...";
    $/ = "\n";
    @titles = qx{grep [^a-zA-Z0-9]tit[^a-zA-Z0-9] `find $sourceroot/text -name localize.sdf`};
    print "done reading ".scalar @titles." localized titles\n";

    print "Sorting localized titles...";
    for (@titles) {
        @tokens = split /\t/, $_;
        ($file = $tokens[1]) =~ s/\\/\//g;
        $file =~ s/.*text\///g;
        $id = $tokens[4];
        $lang = $tokens[9];
        $cnt = $tokens[10];
        push @{$l10ntitles{$lang}}, $_;
    }
    print "done\n";
}

#------------------------------------
sub read_loctree {
    print "Reading localized tree strings...";
    @l10ntreestrings = qx{grep tree_strings.xhp $sourceroot/text/shared/localize.sdf};
    print "done reading ".scalar @l10ntreestrings." localized strings\n";
    print "Sorting localized tree strings...";
    for (@l10ntreestrings) {
        @tokens = split /\t/, $_;
        $lang = $tokens[9];
        push @{$l10ntreestrings{$lang}}, $_;
    }
    print "done\n";
}
