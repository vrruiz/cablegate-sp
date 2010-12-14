#!/usr/bin/perl

##
## 2010 Victor R. Ruiz <rvr@linotipo.es>
## Cablegate cable downloader script. Download all the available cables.
##

use strict;
use Date::Calc qw(Delta_Days Add_Delta_Days);

require "cgate-html-downloader.pl";

##
## Declarations
##

my $URL_BASE = "http://213.251.145.96/reldate/";
my $cgate_ini_year = 2010;
my $cgate_ini_month = 11;
my $cgate_ini_day = 28;

##
## BEGIN
##

# Get current date
my ($second, $minute, $hour, $day_month, $month, $year_offset, $day_week,
    $day_year, $daylight_savings) = localtime();
my $year = 1900 + $year_offset;

# Get number of days between the first date of release and current date
my $delta_days = Delta_Days($year, $month, $day_month,
    $cgate_ini_year, $cgate_ini_month, $cgate_ini_day);

# Loop from initial release date to today
my $delta_day = 0;
while ($delta_day <= $delta_days) {
    my ($c_year, $c_month, $c_day) = Add_Delta_Days($cgate_ini_year,
	$cgate_ini_month, $cgate_ini_day, $delta_day);
    my $formatted_day = sprintf("%02d", $c_day);
    my $url = $URL_BASE."$c_year-$c_month-$formatted_day"."_0.html";
    print $url."\n";
    download_listing_page($url); # cgate-html-downloader.pl
    $delta_day++;
}
