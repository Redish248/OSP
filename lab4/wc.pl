#!/usr/bin/perl -T

use strict;
use warnings qw(FATAL all);

my $wantLines = 1;
my $wantWords = 1;
my $wantBytes = 1;

my $filename = "";
my $i = 0;

my $totalLines = 0;
my $totalWords = 0;
my $totalBytes = 0;
my $fileCounter = 0;

my $lines = 0;
my $words = 0;
my $bytes = 0;
 
if ($ARGV[0] !~ '^$') {
    if ($#ARGV + 1 == 0) {
        print "Incorrect arguments! Use wc -lwc filename."
    } else {
        if ($ARGV[0] =~ '^-') {
                if ($ARGV[0] !~ 'l') {
                    $wantLines = 0;
                }
                if ($ARGV[0] !~ 'c') {
                    $wantBytes = 0;
                }
                if ($ARGV[0] !~ 'w') {
                    $wantWords = 0;
                }
                $i = 1;
        }

        for ($i = $i; $i < $#ARGV + 1; $i++) {
            $filename = $ARGV[$i];
            $fileCounter++;
            if (-e $filename) {
                if (-d $filename) {
                    print "File $filename is a directory!";
                    next; 
                } else {
                    $lines = 0;
                    $words = 0;
                    $bytes = 0;
                    open(my $fh, $filename);
 
                    while (my $row = <$fh>) {
                        if ($wantBytes) {
                            $bytes += length($row);
                        }
                        if ($wantLines) {
                            $lines++;
                        }
                        if ($wantWords) {
                            $words += scalar(split(/\W+/, $row));
                        }
                    }

                    if ($wantLines) { print "$lines "; }
                    if ($wantWords) { print "$words "; }
                    if ($wantBytes) { print "$bytes "; } 
                    print "$filename \n";
                }
            } else {
                print "File $filename doesn't exist!";
                next;
            }

            if ($wantBytes) { $totalBytes += $bytes; }
            if ($wantLines) { $totalLines += $lines; }
            if ($wantWords) { $totalWords += $words; }
        }

        if ($fileCounter > 1) {
            if ($wantLines) { print "$totalLines "; }
            if ($wantWords) { print "$totalWords "; }
            if ($wantBytes) { print "$totalBytes "; } 
            print "total\n";
        }

    }
} else {
    print "Enter file name!";
}


