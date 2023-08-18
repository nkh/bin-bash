use strict ; use warnings ;

use Term::ReadKey;
ReadMode 3; # Turn off echo but keep controls keys for ^C

use Time::HiRes qw(usleep) ;
use IPC::Open2;
use IO::Select ;
use IO::Socket ;

my $server = IO::Socket::INET->new(LocalPort => 11000, Listen => 1, Reuse => 1, Proto => 'tcp') or die $@;
my $client = $server->accept;

my $sub_process = join ' ', @ARGV ;
#my $sub_process = 'bc' ;
#my $sub_process = q{perl -ne '$|=1 ; print $_'} ;

my $pid = open2(my $out, my $in, $sub_process);
my ($key_counter, $network_counter, $output_counter) = (0, 0, 0) ;

$|++  ;

while (1)
	{
	my ($subprocess_output, $network_input) ;
	if(IO::Select->new($client)->can_read(0))
		{
		print "have network input\n" ;
		sysread $client, $network_input, 1024 ;
		}

	my $key = ReadKey(-1) ;

	if (! defined $key && ! defined $network_input) 
		{
		# check if the subprocess wrote something out

		if(IO::Select->new($out)->can_read(0))
			{
			sysread($out, $subprocess_output, 1024) ;
			print "subprocess output [$output_counter]:\n" . $subprocess_output . "\n" ;
			$output_counter++ ;
			}

		usleep 10000 ;
		}
	else
		{
		if (defined $key) 
			{
			print "got key <$key> $key_counter\n" ;
			$key_counter++ ;

			if ($key eq 'q')
				{
				ReadMode 0; # Reset tty mode before exiting
				print "exiting\n" ;
				exit 1 ;
				}

			syswrite $in, "1+1\n" ;
			}

		if (defined $network_input) 
			{
			print "got network input <$network_input> $network_counter\n" ;
			$network_counter++ ;
			syswrite $in, "1+1\n" ;
			}


		}
	}

ReadMode 0; # Reset tty mode before exiting

