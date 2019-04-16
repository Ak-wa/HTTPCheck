#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use HTTP::Tiny;
use Try::Tiny;
my $Client = HTTP::Tiny->new();
@ARGV == 1 or die "[!] Usage: HTTPCheck.pl <targetlist>";
print "[+] HTTP List Checker\n";
my $list = $ARGV[0];
my $url_list = open my $in,"<:encoding(utf8)",$list or die "[+] Could not import URL List\n";
open(my $fh, '>', 'output.txt');
while (my $line = <$in>) {
	try {
	chomp $line;
    my $response = $Client->get($line);
    print $line, ": ", $response->{status},"\n";
	if ($response->{status} == 200) {print $fh $line."\n";}
	} catch {
	warn "[+] Unknown Exception" };}
	print "[+] Online targets written into online_targets.txt";