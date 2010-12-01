#!/usr/bin/perl

## 
## Generates a list of tag count references
## using the cvs provided by The Guardian
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
		@tags = split ',', $tags;
		foreach (@tags) {
			$tag = trim($_);
			if (length($tag) == 4) {
				if ($count{$tag}) {
					$count{$tag} = $count{$tag} + 1;
				} else {
					$count{$tag} = 1;
				}
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
