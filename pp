#!/usr/bin/env perl

#todo: -0 for input containing spaces

# use single quotes for code on the command line

use warnings ;
no warnings qw(once) ;

my $code ;
my @input ;
my $F ;
my $regex ;
my $results ;

for (@ARGV)
	{
	chomp $_ ;
	if(/^(?:-|--)(.+)/)
		{
		my $option = $1 ;

		if($option =~ /(.+)\s*=\s*(.+)/)
			{
			eval qq{\$$1 = "$2" ; } ;
			}
		elsif($option =~ /M([[:alpha:]:]+)/)
			{
			eval qq{use $1 ; } ;
			}
		else
			{
			eval qq{\$$option = 1 ; } ;
			}
		}
	elsif(! defined $code)
		{
		$code = $_ ;
		}
	else
		{
		chomp ;
		push @input, $_ ; 
		}
	}

do { warn "pp: po code given" && exit 1} unless defined $code ;

my $field_separator = defined $F ? $F : '\s' ;

$_ = $input[0] ;
$_ = <STDIN> unless defined $_ ;
chomp $_ ;
$input[0] = $_ ;

local $SIG{__WARN__} =
	sub 
		{
		my $message = shift;
		$message =~ s/at .*?line.*$// ;
		die "\npp: $message\tcode: $code\n\tinput:\n\t\t" . join("\n\t\t", @input) . "\n" ;
		};

# put stuff in $1, $2, ...
if(1 == @input)
	{
	@fields = split $field_separator ;
	$regex = '(' . join(')\s(',  @fields) . ')' ;
	/$regex/ ; 

	@results = eval $code ;
	}
else
	{
	$_ = join ' ', @input ;
	$regex = '(' . join(')\s(',  @input) . ')' ;
	/$regex/ ; 

	@results = eval $code ;
	}

die $@ if $@ ;

print join("\n", @results) ;
print "\n" if $nl ;

#function git_show_parents2()
#{
#git log --pretty="%h %p" -n 1 $* | pp -nl '$1, "\tparent: $2\n\t\t" . join("\t\t", `git branch --contains $2`), "\tparent: $3\n\t\t" . join("\t\t", `git branch --contains $3`)'
#}


