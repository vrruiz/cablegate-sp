#!/usr/bin/perl

##
## 2010 Víctor R. Ruiz <rvr@linotipo.es>
## Cablegate cable parser. Generates a XML file.
## 

use strict;
use HTML::TreeBuilder;
use XML::Element;
use XML::Twig;

##
## DECLARATIONS
## 

# Declare variables
my %cable;

# Declare functions
sub trim {
    # Remove trailing spaces
    my $string = shift;
    $string =~ s/^\s+//;
    $string =~ s/\s+$//;
    return $string;
}

sub xml_add_element {
    # Add element to xml tree
    my $name  = shift;
    my $content = shift;
    my $root = bless(shift, "XML::Element");
    my $type = shift;
    
    return if (!$content); # No content, nothing to do
    
    my $element;
    if ($type) {
	$element = XML::Element->new($name, 'type' => $type);
    } else {
	$element = XML::Element->new($name);
    }
    $element->push_content($content);
    $root->push_content($element);
}

sub xml_add_array {
    # Add array of elements to xml tree
    my $name  = shift;
    my $elements = shift;
    my $root = bless(shift, "XML::Element");
    
    foreach my $e (@{ $elements }) {
	my $element = XML::Element->new($name);
	$element->push_content($e);
	$root->push_content($element);
    }
}

##
## BEGIN
##

# Read file
exit(1) if (!$ARGV[0]);
my $tree = HTML::TreeBuilder->new;
$tree->parse_file($ARGV[0]);

# Find <code>....</code> blocks. There must be two of them, one for the headers
# and one for the body. The structure is:
#
#     <code><pre>VZCZCXRO4693& ... </pre></code> 
#     <code><pre>C O N F I D E N T I A L SECTION 01 OF 03 MADRID 00091 ... </pre></code>
my @codes = $tree->find_by_tag_name('code');
my $n = 0;
foreach my $code (@codes) {
    my @pre = $code->content_list;
    foreach my $pre (@pre) {
	$cable{'header'} = $pre[0]->as_text if ($n == 0);
	$cable{'body'} = $pre[0]->as_text if ($n == 1);
    }
    $n++;
}

# Process <a href> to find linked data. 
# Cable ID, link to WikiLeaks, date and classification
my @links = $tree->find_by_tag_name('a');
foreach my $link (@links) {
    my $href = $link->attr('href');
    my $text = $link->as_text;
    # print "text: $text $href \n";
    
    # ID and link: <a href='/cable/2007/05/07MADRID911.html'>07MADRID911</a> 
    ## BUG: HTML::TreeBuilder error? The above link is converted to
    ## <a href='./07MADRID911_files/07MADRID911.html'>07MADRID911</a>
    if ($href =~ m/\/cable\// && $href =~ m/.html$/) {
	$cable{'link'} = $href;
        $cable{'id'} = $text;
    }
    
    # Classification
    # <a href='/classification/2_0.html' title='secret'>CONFIDENTIAL//NOFORN</a> 
    $cable{'classification'} = $text if ($href =~ m/\/classification\//);
    
    # Date
    # <a href='/date/2007-05_0.html'>2007-05-14 17:05</a> 
    $cable{'date'} = $text if ($href =~ m/\/date\//);
}

# Relese memory
$tree->delete;

# Process header
my @headers = split /\n/, $cable{'header'};
my $to = 0;
my $info = 0;
foreach my $header (@headers) {
    # Get cable source from header with structure
    # FM AMEMBASSY MADRID
    ($cable{'from'}) = $header =~ m/^FM (.*)/ if ($header =~ m/^FM /);
    
    # Get cable primary destination from header with structure
    # TO RUEHC/SECSTATE WASHDC PRIORITY 1758
    if ($header =~ m/^TO (.*)/) {
	$header = $1;
        $to = 1;
    }
    
    # Get cable secondary destination from headers with structure
    # INFO RUCNCLS/ALL SOUTH AND CENTRAL ASIA COLLECTIVE
    # RUCNCIS/CIS COLLECTIVE
    # RUCNMEM/EU MEMBER STATES COLLECTIVE
    # RUEHAK/AMEMBASSY ANKARA 4434
    # ... until the end of header
    if ($header =~ /^INFO (.*)/) {
	$header = $1;
	$to = 0;
	$info = 1;
    }
    push @{ $cable{'to'} }, $header if ($to);
    push @{ $cable{'info'} }, $header if ($info);
}

# Process body
my @bodies = split /\n/, $cable{'body'};
my $subject = 0;
my $tag = 0;
foreach my $body (@bodies) {
    # Tag block
    if ($body =~ m/^TAGS[\:]{0,1} (.*)/) {
	$tag = 1;
	$body = $1;
    }
    
    # Subject block
    if ($body =~ m/SUBJECT: (.*)/) {
	$body = $1;
	$subject = 1;
	$tag = 0;
    }
    
    # Get cable tag list from body header with structure
    # TAGS PREL, PINR, EPET, EINV, ETRD, EWWT, SCUL, RS, TX
    # or
    # TAGS: PREL MARR SP
    if ($tag) {
	my @tags;
	if ($body =~ m/, /) {
	    @tags = split /,[\s]*/, $body; # TAGS PREL, PINR, EPET
	} else {
	    $body =~ s/[\s]{2,}/ /g; # Remove repeated spaces
	    @tags = split / /, $body; # TAGS: PREL MARR SP
	}
	push @{ $cable{'tags'} }, @tags;
    }
    # Get cable subject from body header with structure
    # SUBJECT: SOLZHENITSYN AND METROPOLITAN KIRILL ON RUSSIA, 
    # MEDVEDEV, UKRAINE
    # Can have more than one line. End with empty line or new
    # header (REF).    
    if ($subject) {
	$cable{'subject'} .= $body;
    }
    
    $subject = 0 if ($subject && $body =~ /^[\s]*$/);
    $subject = 0 if ($body =~ /^REF:/);
}


# Write the XML cable output. Structure:
# <xml>
# <cable>
#   <id></id>
#   <link></link>
#   <classfication></classification>
#   <date></date>
#   <subject></subject>
#   <from></from>
#   <to></to>
#   ...
#   <to></to>
#   <info></info>
#   ...
#   <info></info>
#   <tag></tag>
#   ...
#   <tag></tag>
#   <header></header>
#   <body></body>
# </cable>

# <xml>
my $xml_pi = XML::Element->new('~pi', text => 'xml version="1.0"');

# <cable>
my $root = XML::Element->new('cable');

# <id>, <link>, <date>, <from>, <subject>, <classification>
foreach my $element ('id', 'link', 'date', 'from', 'subject', 'classification') {
    xml_add_element($element, $cable{$element}, $root);
}

# <to>, <info>, <tags>
foreach my $element ('to', 'info', 'tags') {
    xml_add_array($element, $cable{$element}, $root);
}

# <header>, <body>
foreach my $element ('header', 'body') { 
   xml_add_element($element, $cable{$element}, $root, 'text/plain');
}

# Print output. Use XML::Twig to output pretty XML
my $xml_content = $xml_pi->as_XML().$root->as_XML();
my $xml = XML::Twig->new(pretty_print => 'indented');
$xml->parse($xml_content);
$xml->print();
