#!/usr/bin/perl

##
## 2010 Víctor R. Ruiz <rvr@linotipo.es>
## Cablegate cable downloader.
## 

use strict;
use URI;
use LWP::UserAgent;
use LWP::Simple;
use HTML::TreeBuilder;
use Time::HiRes qw(usleep);

##
## Declarations
##

my $CABLE_PATH = "./cables"; # Cable storage path
my @pages;
my @downloaded;

# Parses a cable listing page to find individual cable links and stores the
# files.
# Parameters:
#   $tree: Listing page source tree (HTML::TreeBuilder)
#   $url: Base URI to download links.
sub download_cables {
    my $tree = bless(shift, "HTML::TreeBuilder");
    my $url = shift;
    
    # Loop over links to find cables
    my @links = $tree->find_by_tag_name('a');
    foreach my $link (@links) {
        my $href = $link->attr('href');
        my $text = $link->as_text;

        if ($href =~ m/\/cable\//) {
            # Generate URL's absolute path
            my $link = URI->new_abs($href, $url)->as_string;
            my $file_name = File::Spec->catfile($CABLE_PATH, $text.".html");
            # Next if file already exists
            next if (-e $file_name); 
            # Create directory
            mkdir $CABLE_PATH if (!-e $CABLE_PATH);
            print "Downloading $link...\n";
            # Download URL to file
            ## TODO: Check timeout and return code
            my $http_code = getstore($link, $file_name);
            # Be fine, sleep a while before downloading next cable
            usleep(500000); # 0.5 seconds
        }
    }
}

# Check whether an element exists in the array
# Parameters
#   @array: Array
#   $value: Value to find
sub check {
    my $array = shift;
    my $value = shift;
    my $found = 0;
    
    foreach my $item (@{$array}) {
        if ($item eq $value) {
            $found = 1;
            last;
        }        
    }    
    return $found;
}

# Download a cable listing page.
# Parameters:
#   $url: Cable listing page - i.e. http://213.251.145.96/reldate/2010-12-02_0.html
#   $loop: Parse pagination links to download them all. Default: 0.
sub download_listing_page {
    my $url = shift;
    my $loop = shift || 0;
    
    if ($loop == 0) {
        # Reset arrays
        @pages = ();
        @downloaded = ();
        # Don't re-scan current page
        push(@downloaded, $url);
    }

    # Download listing
    my $ua = LWP::UserAgent->new('timeout' => 60);
    $ua->agent('Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13');
    my $http = $ua->get($url);
    die "Error downloading page $url: ".$http->status_line if (!$http->is_success);
    my $html = $http->content;
    my $tree = HTML::TreeBuilder->new;
    $tree->parse($html);

    # Parse and download cables within this page
    download_cables($tree, $url);
    
    print "$url - $loop\n";

    # Store pagination links
    my @link_pages = $tree->find_by_attribute('class', 'paginator');
    my $paginator = $link_pages[0];
    if ($paginator) {
        my @links = $paginator->find_by_tag_name('a');
        foreach my $link (@links) {
            my $href = $link->attr('href'); # Link
            my $text = $link->as_text; # Page number
            if ($text =~ m/^\d+$/) {
                my $l = URI->new_abs($href, $url)->as_string;
                if (check(\@pages, $l) == 0 && check(\@downloaded, $l) == 0 && $l ne $url) {
                    print "Page # $text - $l\n";
                    push(@pages, $l);
                }
            }
        }
    }
        
    # Inside a pagination scan? Job done, return.
    return if ($loop == 1);
    
    # No loop
    return if ($#pages < 1);

    # Loop over pages
    my $over = 0;
    while ($over == 0) {
        my $page = shift(@pages);
        push(@downloaded, $page);
        # Download page, don't search for pagination links (already did it).
        download_listing_page($page, 1);
        $over = 1 if ($#pages == 0); # No more links, exit
    }
}

##
## BEGIN
##

if ($ARGV[0]) {
    # Check URL. Needs a Cablegate listing page.
    my $url = $ARGV[0] or die "Usage: script.pl http://wikileaks.ch/cablegate/....";
    download_listing_page($url);
} else {
    # Module mode
    return 1;
}