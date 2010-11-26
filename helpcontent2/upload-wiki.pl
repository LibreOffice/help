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
name=<the user name>
password=<the appropriate password>

EOM
    exit 1;
}

# first of all, read the configuration from wikisetup.txt
my ( $url, $name, $password );
open( IN, "wikisetup.txt" ) || usage();
while ( my $line = <IN> ) {
    if ( $line =~ /^([^=]*)=(.*)$/ ) {
        my $k = $1;
        my $v = $2;
        chomp $k;
        chomp $v;
        if ( $k eq 'wiki' ) {
            $url = $v;
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

if ( !defined( $url ) || !defined( $name ) || !defined( $password ) ) {
    usage();
}

# initialize the wiki
my $mw = MediaWiki::API->new();
$mw->{config}->{api_url} = $url;

# log in to the wiki
$mw->login( { lgname => $name, lgpassword => $password } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

# upload the articles
sub upload_article {
    -f || return;

    my $pagename = $File::Find::name;
    $pagename =~ s/^wiki\///;
    my $text = read_file( $_ );

    print "Uploading '$pagename'\n";
    $mw->edit( {
            action => 'edit',
            title => $pagename,
            text => $text } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
}
File::Find::find( {wanted => \&upload_article}, 'wiki/' );

# clean up
$mw->logout();

# vim:set shiftwidth=4 softtabstop=4 expandtab:
