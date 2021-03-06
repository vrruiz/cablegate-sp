#!/usr/bin/perl

## 
## Generates a list with the country count reference (2-char tags) 
## using the csv provided by The Guardian
## 
## 2010 Víctor R. Ruiz <rvr@linotipo.es>
## 

##
## Declarations
##
sub trim;

my %count;
my $cable_file = "kipr.csv";

##
## BEGIN
##

open CGATE, "< $cable_file";

while (<CGATE>) {
	$line = $_;
   	($date,$source,$tags) = $line =~ m/^(.*),(.*),"(.*)"$/;
	@tags = split ',', $tags;
	foreach (@tags) {
		$tag = trim($_);
		if (length($tag) == 2) {
			if ($count{$tag}) {
				$count{$tag} = $count{$tag} + 1;
			} else {
				$count{$tag} = 1;
			}
		}
	}
}

for my $key (keys %count) {
	print "$key ".$count{$key}."\n";
}

sub trim {
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}
