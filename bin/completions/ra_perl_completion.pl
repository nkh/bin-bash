#! /usr/bin/perl                                                                       

=pod

I<Arguments> received from bash:

=over 2

=item * $index - index of the command line argument to complete (starting at '1')

=item * $command - a string containing the command name

=item * \@argument_list - list of the arguments typed on the command line

=back

You return possible completion you want separated by I<\n>. Return nothing if you
want the default bash completion to be run which is possible because of the <-o defaul>
passed to the B<complete> command.

Note! You may have to re-run the B<complete> command after you modify your perl script.

=cut

use strict;
use Tree::Trie;

my ($argument_index, $command, @arguments) = @ARGV ;

$argument_index-- ;
my $word_to_complete = $arguments[$argument_index] ;

my %top_level_completions = # name => takes a file 0/1
	(	
	-bash => 0,
	-version => 0,
	-help => 0,
	-h => 0,
	-faq => 0,
	-generate_bash_completion => 0,
	-apropos => 0,
	) ;
		
my %commands_and_their_options =
	(
	show_usecases =>  [qw(-master_template_file -help -show_collapsed -show_collapse_button -title -header_file)],
	grep =>  [qw(-r -recursive -1 -list -only_file_name -match_file_name -p -pattern -i -ignore_case -path -silent -s -statistics -summary -help)],
	check =>  [qw(-master_template_file -invalid_requirement_list -help)],
	new_batch =>  [qw(-master_template_file -help)],
	new =>  [qw(-master_template_file -help)],
	edit =>  [qw(-master_template_file -master_categories_file -free_form_template -user_dictionary -no_spellcheck -raw -no_check_categories -no_file_ok -help)],
	show =>  [qw(-include_type -include_description_data -include_categories -remove_empty_requirement_field_in_categories -include_not_found -include_statistics -show_abstraction_level -format -include_loaded_from -master_template_file -master_categories_file -requirement_fields_filter_file -field -help)],
	show_flat =>  [qw(-include_type -include_description_data -include_categories -remove_empty_requirement_field_in_categories -include_not_found -include_statistics -show_abstraction_level -keep_abstraction_level -title -header_file -comment -include_loaded_from -master_template_file -master_categories_file -flat_requirement_fields_filter_file -help)],
	spellcheck =>  [qw(-user_dictionary -display_dictionary_search -user_dictionary -help)],
	show_by_abstraction =>  [qw(-master_template_file -help)],
	) ;
	
my @commands = (sort keys %commands_and_their_options) ;
my %commands = map {$_ => 1} @commands ;
my %top_level_completions_taking_file = map {$_ => 1} grep {$top_level_completions{$_}} keys %top_level_completions ;

my $command_present = 0 ;
for my $argument (@arguments)
	{
	if(exists $commands{$argument})
		{
		$command_present = $argument ;
		last ;
		}
	}

my @completions ;
if($command_present)
	{
	# complete differently depending on $command_present
	push @completions, @{$commands_and_their_options{$command_present}}  ;
	}
else
	{
	if(defined $word_to_complete)
		{
		@completions = (@commands, keys %top_level_completions) ;
		}
	else
		{
		@completions = @commands ;
		}
	}

if(defined $word_to_complete)
        {
	my $trie = new Tree::Trie;
	$trie->add(@completions) ;

        print join("\n", $trie->lookup($word_to_complete) ) ;
        }
else
	{
	my $last_argument = $arguments[-1] ;
	
	if(exists $top_level_completions_taking_file{$last_argument})
		{
		# use bash file completiong or we could pass the files ourselves
		#~ use File::Glob qw(bsd_glob) ;
		#~ print join "\n", bsd_glob('M*.*') ;
		}
	else
		{
		print join("\n", @completions)  unless $command_present ;
		}
	}

