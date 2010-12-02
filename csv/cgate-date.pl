#!/usr/bin/perl

## 
## Generates a list of cable activity per month
## using the csv provided by The Guardian
## 
## 2010 Víctor R. Ruiz <rvr@linotipo.es>
## 


open CGATE, "< sp.csv";

sub trim;
my %count;

while (<CGATE>) {
	$line = $_;
	if ($line =~ m/[\"\s\,]+SP[\s\,\"]+/) {
		# print $line;
	   	($date,$source,$tags) = $line =~ m/^(.*),(.*),"(.*)"$/;
		$d = substr $date, 0, 7;
		if ($count{$d}) {
			$count{$d} = $count{$d} + 1;
		} else {
			$count{$d} = 1;
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
