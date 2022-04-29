#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Data::Dumper;

# zstats -- Stats about your 'Forever Version History'

# Get all bz_done files and load filenames into array
my @bz_done_files = glob q("data/bz_done_*.dat");

# Declare array for z-lines to be stored
my @z_lines;

# Declare array for deduped lines to be stored
my @d_lines;

# Loop over files in @bz_done_files
foreach( @bz_done_files ){
    # Print current filename
    print("Looking through $_...\n");
    my $file = $_;
    # Open the current file or handle errors
    open my $info, $file or die "Could not open $file: $!";

    # TODO: Add function to find the governance lines so we don't have to loop over every single bz_done line

    # Loop over lines in the file
    while( my $line = <$info>){
        # Push the line to @z_lines if it contains a z byte
        push(@z_lines, $line) if $line =~ /^5\tz/;
        # Push the line to @d_lines if it contains a = byte
        push(@d_lines, $line) if $line =~ /^5\t=/;
    }
    # Be nice and close the file.
    close $info;
}

# Now we've got an array with expired z-lines as well as de-duped d-lines
# TODO: Get total size of expired files that we're expecting via. governance lines
# TODO: Locate expired files that have not been re-uploaded
# What does a files the was expired but has been re-uploaded look like?
#   - Has a z-line in bz_done logs
#   - Does not have a corresponding = line in bz_done logs
# TODO: Use a sqlite database and lean on its inbuilt indexing functionality
# TODO: Remove items from z-lines if there is a d-line with the same file id AFTER z-line

# Get all bzfileids from z-lines
my @z_bzfileids;
foreach(@z_lines){
    push(@z_bzfileids,$1) if $_ =~ /\t(\w{83})\t/;
}

# Get all bzfileids from d-lines
my @d_bzfileids;
foreach(@d_lines){
    push(@d_bzfileids,$1) if $_ =~ /\t(\w{83})\t/;
}

# Lookup table to test membership of z_bzfileids
my %seen = ();
my @d_ids_in_z_ids = ();

# Build lookup table
foreach my $item (@z_bzfileids) { $seen{$item} = 1 }

# Find only elements in @d_bzfileids in @z_bzfileids
foreach my $item (@d_bzfileids) {
    push(@d_ids_in_z_ids, $item) if exists $seen{$item};
}

# Find bzfileids not in @d_ids_in_z_ids
# Empty Lookup table
%seen = ();
my @unique_z_lines;

# Build lookup table
foreach my $item (@d_ids_in_z_ids) { $seen{$item} = 1 }

# Find only elements in @z_bzfileids not in @d_ids_in_z_ids
foreach my $item (@z_bzfileids) {
    push(@unique_z_lines, $item) unless exists $seen{$item};
}

print("DONE");


