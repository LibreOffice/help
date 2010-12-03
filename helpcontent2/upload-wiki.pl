#!/usr/bin/perl -w

use MediaWiki::API;
use File::Find();
use File::Slurp;

# help
sub usage {
    print <<EOM;
upload-wiki.pl - Uploads the wiki/ subdir to a real wiki installation.

You need a wikisetup.txt in this directory, to be able to authentificate you.
The content should be:

wiki=<url of the api.php on the wiki>
upload=<url of the Special:Upload page>
name=<the user name>
password=<the appropriate password>

upload-wiki.pl operates on the output of help-to-wiki.py, needing particularly
these:

wiki/      - directory with all the pages generated out of the help .xhp files
images.txt - list of the images used in help

Additionally you need:

images/    - directory with an unpack of images_tango.zip

EOM
    exit 1;
}

# first of all, read the configuration from wikisetup.txt
my ( $url, $upload_url, $name, $password );
if ( ! open( IN, "wikisetup.txt" ) ) {
    print "Missing wikisetup.txt\n\n";
    usage();
}
while ( my $line = <IN> ) {
    if ( $line =~ /^([^=]*)=(.*)$/ ) {
        my $k = $1;
        my $v = $2;
        chomp $k;
        chomp $v;
        if ( $k eq 'wiki' ) {
            $url = $v;
        }
        elsif ( $k eq 'upload' ) {
            $upload_url = $v;
        }
        elsif ( $k eq 'name' ) {
            $name = $v;
        }
        elsif ( $k eq 'password' ) {
            $password = $v;
        }
    }
}
close( IN );

if ( !defined( $url ) || !defined( $upload_url ) || !defined( $name ) || !defined( $password ) ) {
    print "wikisetup.txt does not contain all the info.\n\n";
    usage();
}

if ( ! -d 'wiki' || ! -f 'images.txt' ) {
    print "Missing the wiki/ subdir or images.txt, re-run help-to-wiki.py.\n\n";
    usage();
}

if ( ! -d 'images' ) {
    print "Missing images/ subdir - mkdir images ; cd images ; unzip /path/to/images_tango.zip\n\n";
    usage();
}

# initialize the wiki
my $mw = MediaWiki::API->new();
$mw->{config}->{api_url} = $url;
$mw->{config}->{upload_url} = $upload_url;

# log in to the wiki
$mw->login( { lgname => $name, lgpassword => $password } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

# upload the articles
sub upload_article {
    -f || return;

    my $pagename = $File::Find::name;
    $pagename =~ s/^wiki\///;
    my $text = read_file( $_ );

    print "Uploading page '$pagename'\n";
    $mw->edit( {
            action => 'edit',
            title => $pagename,
            text => $text } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
}
File::Find::find( {wanted => \&upload_article}, 'wiki/' );

# upload the images
open( IN, "images.txt" ) || usage();
while ( my $line = <IN> ) {
    chomp( $line );
    $fname = "images/$line";
    if ( ! -f $fname ) {
        print "Image '$fname' not found, skipped.\n";
        next;
    }
    if ( ! $fname =~ /\.(png|gif|jpg|jpeg)$/ ) {
        print "Image '$line' ignored, not a jpg/png/gif.\n";
        next;
    }

    my $imagename = $line;
    if ( $line =~ /\/([^\/]*)$/ ) {
        $imagename = $1;
    }
    my $image = read_file( $fname );

    print "Uploading image '$imagename'\n";
    $mw->upload( {
            title => $imagename,
            summary => 'Initial upload.',
            data => $image } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
}

# clean up
$mw->logout();

# vim:set shiftwidth=4 softtabstop=4 expandtab:
