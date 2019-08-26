#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
exit (main());

### This script can parse sections of a file (based on random columns) ###
### OR can extract a certain range of column ####
### I have written this script such that it can handle both Tab or comma separate format ##

sub main{
  my $settings ={};
  GetOptions($settings,qw(infile=s outfile=s type=s cols=s));
  my $in = $$settings{infile} or die usage ();
  my $ofile = $$settings{outfile} or die usage ();
  my $type = $$settings{type} or die usage ();
  my $cols = $$settings{stcol} or die usage ();
  randcolparser ($in, $ofile, $type, $cols);
  return 0;
}

##############################################################################
####### Subroutine for performing the column parser ##########################
#############################################################################
sub randcolparser{
  my ($in, $ofile, $type, $cols) = @_;
  chomp ($in);
  chomp ($ofile);
  chomp ($type);
  chomp ($cols);
 
  open (OUT, ">$ofile") or die "Can't open $!";
  #### Processing the file if it is tabtxt ###

 if ($type eq "tabtxt"){

open (FILE, "<$in") or die "Can't open $!";

my $string = '';
  while (my $inp = <FILE>){
my @b = ();
    chomp ($inp);
    my @ar = split(/\t/,$inp);
    my @cl = split (/\;/$cols); 
    #print $inp."\n";
    
   foreach my $i(@cl){
    push (@b, $ar[$i]);
    }

 $string = join '\t', @b;
print OUT "$string\n";
  ##  my @arr = ();
}

#foreach my $lis (@b){
#  my  @arr = join("\t",@b);
 #print OUT "@arr\n";
 #}
}

#  print OUT "\n";

#### Processing the file if is a CSV ###

if ($type eq "csv"){
my $string1 = '';
open (FILE, "<$in") or die "Can't open $!";
while (my $inp1 = <FILE>){
    my @b1 = ();
  chomp ($inp1);
  my @ar1 = split(/\,/,$inp1);
  
  my @cl = split (/\;/$cols); 

  foreach my $j(@cl){
    push (@b1, $ar[$j]);
    }

$string1 = join '\t', @b1;
print OUT "$string1\n";
 ##  my @arr = ();
}

#foreach my $lis (@b){
#  my  @arr = join("\t",@b);
#print OUT "@arr\n";
#}
}

return 1;
}

sub usage {
  "Extarcting data from a file based on columns
  Use column parameter seperated by ;
  Usage: $0 -i <inputfile> -o <outputfile> -t <file type {tabtxt or csv}> -c <column # sep by ;>";
}
