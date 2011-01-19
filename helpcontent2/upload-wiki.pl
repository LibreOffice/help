#!/usr/bin/perl -w

use MediaWiki::API;
use File::Find();
use File::Slurp;
use Getopt::Std;

# help
sub usage {
    print <<EOM;
upload-wiki.pl [...] - Uploads the wiki/ subdir to a real wiki installation.

  -i - Upload also the images
  -p - Don't upload the pages themselves
  -r - Upload also the redirects

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

%options = ();
getopts( "hipr", \%options );

usage() if ( defined $options{h} );

my $upload_images = 0;
my $upload_pages = 1;
my $upload_redirects = 0;
$upload_images = 1 if ( defined $options{i} );
$upload_pages = 0 if ( defined $options{p} );
$upload_redirects = 1 if ( defined $options{r} );

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

if ( ! -d 'wiki' ) {
    print "Missing the wiki/ subdir, re-run help-to-wiki.py.\n\n";
    usage();
}

if ( $upload_images ) {
    if ( ! -f 'images.txt' ) {
        print "Missing images.txt, re-run help-to-wiki.py.\n\n";
        usage();
    }

    if ( ! -d 'images' ) {
        print "Missing images/ subdir - mkdir images ; cd images ; unzip /path/to/images_tango.zip\n\n";
        usage();
    }
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
    $pagename =~ s/\/MAIN$//;

    # pages starting with lowercase 's' are redirects
    if ( $pagename =~ /^s/ ) {
        return if ( !$upload_redirects );
    }
    else {
        return if ( !$upload_pages );
    }

    my $text = read_file( $_ );

    print "Uploading page '$pagename'\n";
    $mw->edit( {
            action => 'edit',
            title => $pagename,
            text => $text }, { skip_encoding => 1 } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
}
File::Find::find( {wanted => \&upload_article}, 'wiki/' );

# upload the images
if ( $upload_images ) {
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
}

# clean up
$mw->logout();

# vim:set shiftwidth=4 softtabstop=4 expandtab:
