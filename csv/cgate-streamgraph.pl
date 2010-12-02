#!/usr/bin/perl
use strict;

## 
## Generates streamgraph data for streamgraph.js for cablegate tags
## using the csv provided by The Guardian
## 
## 2010 Víctor R. Ruiz <rvr@linotipo.es>
## 

# Declare functions
sub trim;

# Declare variables
my $cgate_file = "sp-2004-2010.csv";
my $cgate_tag_file = "sp-tags-top20.csv";
my $tag_length = 4; # 2 = countries, 4 = topics.
my %tag_list;
my %tag_count;
my %tags_cgate;
my $year_month_prev;

###
### MAIN
###

print <<__EOF__;
function getStreamgraphSettings()
{
    var s = new Settings();
    s.show_settings = false;
    s.show_legend = false;

    s.colors.background = 200;
    s.colors.neutral = 100;
    s.colors.highlight = 0;

    s.colors.image = "../deps/layers";
    return s;
}
__EOF__

##
## Read tag list to hash (count). Generate getStreamgraphLabels()
##
open CGATE_TAGS, "< $cgate_tag_file";
while (<CGATE_TAGS>) {
	my $tag = trim($_);
	$tag_list{$tag} = 0; # Init tag count to zero

}

print "function getStreamgraphLabels() {\n\treturn [\n";
my $prev = 0;
for (sort keys %tag_list) {
	my $tag = $_;
	# Separate values withs commans, except first element
	if ($prev == 0) {
		$prev = 1;
	} else {
		print ",\n";
	}
	print "\t'$tag'";

}
print "\n\t];\n}\n\n\n";

##
## Red cable file. Calculate tag count by month. Generate getStreamgraphData()
##
open CGATE, "< $cgate_file";
print "function getStreamgraphData() {\n\treturn [\n";
my $n = 0;
while (<CGATE>) {
	my $line = $_;
	# Check whether line conforms with format 'date, source, "tag, tag, tag"'
	if ($line =~ m/[\"\s\,]+SP[\s\,\"]+/) {
		# Split content
		my ($date,$source,$tags) = $line =~ m/^(.*),(.*),"(.*)"$/;

		# Split tags
		my @tags = split ',', $tags;

		# Get current  yyyy-mm
		my $year_month_current = substr $date, 0, 7;
		# print "$year_month_current\n";

		# Check when a new month has hit
		if ($year_month_current ne $year_month_prev) {
			if ($year_month_prev ne "") {
				# Generate previouns month output
				print "\t// Date: $year_month_prev ($n) \n";
				print "\t[";
				my $prev = 0;
				for (sort keys %tag_count) {
					my $tag = $_;
					# Separate values with comma, except the first item
					if ($prev == 1) {
						print ",";
					} else {
						$prev = 1;
					}
					print "$tag_count{$tag}";
				}
				print "],\n";
				$n++;
			}
			# Count reset
			$year_month_prev = $year_month_current;
			%tag_count = %tag_list;
		}

		# Process tags
		foreach (@tags) {
			my $tag = trim($_);
			## length = 2 -> countries. lengith = 4 -> topics
			if (length($tag) == $tag_length) {
				# Check whether tag is in hash
				if (exists $tag_count{$tag}) {
					$tag_count{$tag} = $tag_count{$tag} + 1;
				}
			}
		}
	}
}
print "];\n}\n";

## 
## Functions
## 

## Remove spaces
sub trim {
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}

