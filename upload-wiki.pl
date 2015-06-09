#!/usr/bin/perl -w
#
# This file is part of the LibreOffice project.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

use MediaWiki::API;
use File::Find();
use File::Slurp;
use Getopt::Std;
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);

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

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}=0;

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
    $pagename =~ s/%2F/\//g;

    # pages starting with lowercase 's' are redirects
    if ( $pagename =~ /^s/ ) {
        return if ( !$upload_redirects );
    }
    else {
        return if ( !$upload_pages );
    }

    my $text = read_file( $_ );

    RETRY:
    print "Uploading page '$pagename'\n";
    unless ( $mw->edit( {
            action => 'edit',
            title => $pagename,
            text => $text }, { skip_encoding => 1 } ) )
    {
        print 'Error: ' . $mw->{error}->{code} . ': ' . $mw->{error}->{details} . "\n";
        print "Waiting for 10 seconds...\n";
        sleep 10;
        print "Retry!\n";
        goto RETRY;
    }
}
File::Find::find( {wanted => \&upload_article}, 'wiki/' );

# upload the images
if ( $upload_images ) {
    open( IN, "images.txt" ) || usage();
    my $imagename = '';
    my $imageuploadmsg = '';
    my $image = '';    
    while ( my $line = <IN> ) {
        chomp( $line );
        my $fname = "images/$line";
        if ( ! -f $fname ) {
            print "Image '$fname' not found, skipped.\n";
            next;
        }
        if ( ! $fname =~ /\.(png|gif|jpg|jpeg)$/ ) {
            print "Image '$line' ignored, not a jpg/png/gif.\n";
            next;
        }        
        
        $imagename = $line;
        if ( $line =~ /\/([^\/]*)$/ ) {
            $imagename = $1;
        }
        sub upload_file_to_mw {
            $mw->upload( {
                title => 'File:'.$imagename,
                summary => $imageuploadmsg,
                data => $image } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
        }
        
        $image = read_file( $fname );

        # don't reupload an image if it is already present - otherwise it only bloats the wiki
        my $imagesha1 = sha1_hex($image);
        # get the sha1 request directly from the wiki
        my $mwquery = $mw->api( {
            action => 'query',
            prop => 'imageinfo',
            iiprop => 'sha1',
            titles => 'File:'.$imagename } );        
        my $mwimagesha1 = "";
        #FIXME: bad style, this foreach should konsist only ONE imageid --> do that nicelier
        foreach my $imageid (keys $mwquery->{'query'}{'pages'}) {
            $mwimagesha1 = $mwquery->{'query'}{'pages'}{$imageid}{'imageinfo'}->[0]->{'sha1'};
        }
        
        if (($imagesha1 ne $mwimagesha1) and ($mwimagesha1 ne '')) {
            print "Updating image '$imagename', sha1 is different from already uploaded image.\n";
            $imageuploadmsg = 'Updating image.';
            upload_file_to_mw();
        } elsif ($mwimagesha1 eq '') {
            print "Initial upload of  image '$imagename'\n";
            $imageuploadmsg = 'Initial upload.';
            upload_file_to_mw();
        } else {
            print "Skipping image '$imagename', sha1 identially to already uploaded image.\n";
        }
    }
}

# clean up
$mw->logout();

# vim:set shiftwidth=4 softtabstop=4 expandtab:
