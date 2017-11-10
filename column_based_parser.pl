#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
exit (main());

### This script either can parse sections of a file (based on column) ###
### OR can extract a certain range of column ####
### I have written this script such that it can handle both Tab or comma separate format ##

sub main{
  my $settings ={};
  GetOptions($settings,qw(infile=s outfile=s type=s stcol=s encol=s));
  my $in = $$settings{infile} or die usage ();
  my $ofile = $$settings{outfile} or die usage ();
  my $type = $$settings{type} or die usage ();
  my $colst = $$settings{stcol} or die usage ();
  my $enco = $$settings{encol} or die usage ();
  colparser ($in, $ofile, $type, $colst, $enco);
  return 0;
}

##############################################################################
####### Subroutine for performing the column parser ##########################
#############################################################################
sub colparser{
  my ($in, $ofile, $type, $colst, $enco) = @_;
  chomp ($in);
  chomp ($ofile);
  chomp ($type);
  chomp ($colst);
  chomp ($enco);
  open (OUT, ">$ofile") or die "Can't open $!";
  #### Processing the file if it is tabtxt ###


 if ($type eq "tabtxt"){

open (FILE, "<$in") or die "Can't open $!";

my $string = '';
  while (my $inp = <FILE>){
my @b = ();
    chomp ($inp);
    my @ar = split(/\t/,$inp);
    my $start = $colst-1;
    my $end = $enco-1;
    print $inp."\n";
   for (my $i=$start; $i <=$end; $i++){
      push (@b, $ar[$i]);
    }

 $string = join ', ', @b;
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
  my $start1 = $colst-1;
  my $end1 = $enco-1;

  for (my $j=$start1; $j <=$end1; $j++){
     push (@b1, $ar1[$j]);
   }

$string1 = join ', ', @b1;
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
  Usage: $0 -i <inputfile> -o <outputfile> -t <file type {tabtxt or csv}> -s <start column #> -e <end column #>";
}
