#!/usr/env perl

use strict ;
use warnings ;

my $SHA = qr/[0-9a-f]{5,40}/ ;
my $regex = join('|', @ARGV) ;

my @log = `git log --all --color --graph --pretty=format:'%C(yellow)%h %C(white bold)%s %C(blue bold)<branch:%d> %C(black bold)(%ar, %an)%C(red)' ` ;

for(@log)
	{
	if(/$SHA/)
		{
		my $branch = s/<branch:([^>]+)>/$1/ ;

		if($branch)
			{
			print ;
			}
		else
			{
			s/<branch:>// ;
			
			if(/$regex/)
				{
				chomp ;
				print ; 
				print "   <==\n" ;
				}
			}
		}
	else
		{
		print ; # no SHA, just glyphs
		}
	}

print "\n" ;
