#!/usr/bin/env perl

=pod

Add the following line in your I<~/.bashrc> or B<source> them:

_pbs_perl_completion()
{
local old_ifs="${IFS}"
local IFS=$'\n';
COMPREPLY=( $(pbs_perl_completion.pl ${COMP_CWORD} ${COMP_WORDS[@]}) );
IFS="${old_ifs}"

return 1;
}

complete -o default -F _pbs_perl_completion pbs

Replace I<pbs_perl_completion_script> with the name you saved the script under. The script has to
be executable and somewhere in the path.

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

my @completions =
	qw(
	-h
	--h
	-help
	--help
	-hs
	--hs
	-help_switch
	--help_switch
	-hnd
	--hnd
	-help_narrow_display
	--help_narrow_display
	-generate_bash_completion_script
	--generate_bash_completion_script
	-pp
	--pp
	-pbsfile_pod
	--pbsfile_pod
	-pbs2pod
	--pbs2pod
	-raw_pod
	--raw_pod
	-d
	--d
	-display_pod_documenation
	--display_pod_documenation
	-w
	--w
	-wizard
	--wizard
	-wi
	--wi
	-display_wizard_info
	--display_wizard_info
	-wh
	--wh
	-display_wizard_help
	--display_wizard_help
	-v
	--v
	-version
	--version
	-no_colorization
	--no_colorization
	-c
	--c
	-colorize
	--colorize
	-ce
	--ce
	-color_error
	--color_error
	-cw
	--cw
	-color_warning
	--color_warning
	-cw2
	--cw2
	-color_warning2
	--color_warning2
	-ci
	--ci
	-color_info
	--color_info
	-ci2
	--ci2
	-color_info2
	--color_info2
	-cu
	--cu
	-color_user
	--color_user
	-cs
	--cs
	-color_shell
	--color_shell
	-cd
	--cd
	-color_debug
	--color_debug
	-output_indentation
	--output_indentation
	-p
	--p
	-pbsfile
	--pbsfile
	-prf
	--prf
	-pbs_response_file
	--pbs_response_file
	-naprf
	--naprf
	-no_anonymous_pbs_response_file
	--no_anonymous_pbs_response_file
	-nprf
	--nprf
	-no_pbs_response_file
	--no_pbs_response_file
	-plp
	--plp
	-pbs_lib_path
	--pbs_lib_path
	-display_pbs_lib_path
	--display_pbs_lib_path
	-ppp
	--ppp
	-pbs_plugin_path
	--pbs_plugin_path
	-display_pbs_plugin_path
	--display_pbs_plugin_path
	-no_default_path_warning
	--no_default_path_warning
	-dpli
	--dpli
	-display_plugin_load_info
	--display_plugin_load_info
	-display_plugin_runs
	--display_plugin_runs
	-dpt
	--dpt
	-display_pbs_time
	--display_pbs_time
	-dptt
	--dptt
	-display_pbs_total_time
	--display_pbs_total_time
	-dpu
	--dpu
	-display_pbsuse
	--display_pbsuse
	-dpuv
	--dpuv
	-display_pbsuse_verbose
	--display_pbsuse_verbose
	-dput
	--dput
	-display_pbsuse_time
	--display_pbsuse_time
	-dputa
	--dputa
	-display_pbsuse_time_all
	--display_pbsuse_time_all
	-dpus
	--dpus
	-display_pbsuse_statistic
	--display_pbsuse_statistic
	-display_md5_statistic
	--display_md5_statistic
	-build_directory
	--build_directory
	-mandatory_build_directory
	--mandatory_build_directory
	-sd
	--sd
	-source_directory
	--source_directory
	-rule_namespace
	--rule_namespace
	-config_namespace
	--config_namespace
	-save_config
	--save_config
	-load_config
	--load_config
	-fb
	--fb
	-force_build
	--force_build
	-check_dependencies_at_build_time
	--check_dependencies_at_build_time
	-no_build
	--no_build
	-nub
	--nub
	-no_user_build
	--no_user_build
	-ns
	--ns
	-no_stop
	--no_stop
	-nh
	--nh
	-no_header
	--no_header
	-no_external_link
	--no_external_link
	-nsi
	--nsi
	-no_subpbs_info
	--no_subpbs_info
	-dsi
	--dsi
	-display_subpbs_info
	--display_subpbs_info
	-sfi
	--sfi
	-subpbs_file_info
	--subpbs_file_info
	-allow_virtual_to_match_directory
	--allow_virtual_to_match_directory
	-nli
	--nli
	-no_link_info
	--no_link_info
	-nlmi
	--nlmi
	-no_local_match_info
	--no_local_match_info
	-ndi
	--ndi
	-no_duplicate_info
	--no_duplicate_info
	-ntii
	--ntii
	-no_trigger_import_info
	--no_trigger_import_info
	-sc
	--sc
	-silent_commands
	--silent_commands
	-sco
	--sco
	-silent_commands_output
	--silent_commands_output
	-qow
	--qow
	-query_on_warning
	--query_on_warning
	-dm
	--dm
	-dump_maxdepth
	--dump_maxdepth
	-di
	--di
	-dump_indentation
	--dump_indentation
	-ni
	--ni
	-node_information
	--node_information
	-nbn
	--nbn
	-node_build_name
	--node_build_name
	-no
	--no
	-node_origin
	--node_origin
	-nd
	--nd
	-node_dependencies
	--node_dependencies
	-nc
	--nc
	-node_build_cause
	--node_build_cause
	-nr
	--nr
	-node_build_rule
	--node_build_rule
	-nb
	--nb
	-node_builder
	--node_builder
	-nconf
	--nconf
	-node_config
	--node_config
	-npbc
	--npbc
	-node_build_post_build_commands
	--node_build_post_build_commands
	-nil
	--nil
	-node_information_located
	--node_information_located
	-o
	--o
	-origin
	--origin
	-j
	--j
	-jobs
	--jobs
	-jdoe
	--jdoe
	-jobs_die_on_errors
	--jobs_die_on_errors
	-ubs
	--ubs
	-use_build_server
	--use_build_server
	-distribute
	--distribute
	-display_shell_info
	--display_shell_info
	-dbi
	--dbi
	-display_builder_info
	--display_builder_info
	-time_builders
	--time_builders
	-dji
	--dji
	-display_jobs_info
	--display_jobs_info
	-djr
	--djr
	-display_jobs_running
	--display_jobs_running
	-kpbb
	--kpbb
	-keep_pbs_build_buffers
	--keep_pbs_build_buffers
	-l
	--l
	-create_log
	--create_log
	-ll
	--ll
	-display_last_log
	--display_last_log
	-dpr
	--dpr
	-display_pbs_run
	--display_pbs_run
	-dpos
	--dpos
	-display_original_pbsfile_source
	--display_original_pbsfile_source
	-dps
	--dps
	-display_pbsfile_source
	--display_pbsfile_source
	-dpc
	--dpc
	-display_pbs_configuration
	--display_pbs_configuration
	-dec
	--dec
	-display_error_context
	--display_error_context
	-dpl
	--dpl
	-display_pbsfile_loading
	--display_pbsfile_loading
	-dspd
	--dspd
	-display_sub_pbs_definition
	--display_sub_pbs_definition
	-dds
	--dds
	-display_depend_start
	--display_depend_start
	-dur
	--dur
	-display_used_rules
	--display_used_rules
	-durno
	--durno
	-display_used_rules_name_only
	--display_used_rules_name_only
	-dar
	--dar
	-display_all_rules
	--display_all_rules
	-dc
	--dc
	-display_config
	--display_config
	-display_config_delta
	--display_config_delta
	-dca
	--dca
	-display_config_all
	--display_config_all
	-dac
	--dac
	-display_all_configs
	--display_all_configs
	-no_silent_override
	--no_silent_override
	-display_subpbs_search_info
	--display_subpbs_search_info
	-display_all_subpbs_alternatives
	--display_all_subpbs_alternatives
	-dsd
	--dsd
	-display_source_directory
	--display_source_directory
	-display_search_info
	--display_search_info
	-daa
	--daa
	-display_all_alternates
	--display_all_alternates
	-dr
	--dr
	-display_rules
	--display_rules
	-drd
	--drd
	-display_rule_definition
	--display_rule_definition
	-dtr
	--dtr
	-display_trigger_rules
	--display_trigger_rules
	-dtrd
	--dtrd
	-display_trigger_rule_definition
	--display_trigger_rule_definition
	-dpbcr
	--dpbcr
	-display_post_build_commands_registration
	--display_post_build_commands_registration
	-dpbcd
	--dpbcd
	-display_post_build_command_definition
	--display_post_build_command_definition
	-dpbc
	--dpbc
	-display_post_build_commands
	--display_post_build_commands
	-dpbcre
	--dpbcre
	-display_post_build_result
	--display_post_build_result
	-dd
	--dd
	-display_dependencies
	--display_dependencies
	-ddl
	--ddl
	-display_dependencies_long
	--display_dependencies_long
	-ddt
	--ddt
	-display_dependency_time
	--display_dependency_time
	-dct
	--dct
	-display_check_time
	--display_check_time
	-dcdi
	--dcdi
	-display_c_dependency_info
	--display_c_dependency_info
	-scd
	--scd
	-show_c_depending
	--show_c_depending
	-dre
	--dre
	-dependency_result
	--dependency_result
	-ncd
	--ncd
	-no_c_dependencies
	--no_c_dependencies
	-dcd
	--dcd
	-display_c_dependencies
	--display_c_dependencies
	-display_cpp_output
	--display_cpp_output
	-ddr
	--ddr
	-display_dependencies_regex
	--display_dependencies_regex
	-ddrd
	--ddrd
	-display_dependency_rule_definition
	--display_dependency_rule_definition
	-display_dependency_regex
	--display_dependency_regex
	-dtin
	--dtin
	-display_trigger_inserted_nodes
	--display_trigger_inserted_nodes
	-dt
	--dt
	-display_trigged
	--display_trigged
	-display_digest_exclusion
	--display_digest_exclusion
	-display_digest
	--display_digest
	-dddo
	--dddo
	-display_different_digest_only
	--display_different_digest_only
	-display_cyclic_tree
	--display_cyclic_tree
	-no_source_cyclic_warning
	--no_source_cyclic_warning
	-die_source_cyclic_warning
	--die_source_cyclic_warning
	-tt
	--tt
	-text_tree
	--text_tree
	-tta
	--tta
	-text_tree_use_ascii
	--text_tree_use_ascii
	-ttdhtml
	--ttdhtml
	-text_tree_use_dhtml
	--text_tree_use_dhtml
	-ttm
	--ttm
	-text_tree_max_depth
	--text_tree_max_depth
	-tno
	--tno
	-tree_name_only
	--tree_name_only
	-tda
	--tda
	-tree_depended_at
	--tree_depended_at
	-tia
	--tia
	-tree_inserted_at
	--tree_inserted_at
	-tnd
	--tnd
	-tree_display_no_dependencies
	--tree_display_no_dependencies
	-tad
	--tad
	-tree_display_all_data
	--tree_display_all_data
	-tnb
	--tnb
	-tree_name_build
	--tree_name_build
	-tnt
	--tnt
	-tree_node_triggered
	--tree_node_triggered
	-tntr
	--tntr
	-tree_node_triggered_reason
	--tree_node_triggered_reason
	-gtg
	--gtg
	-generate_tree_graph
	--generate_tree_graph
	-gtg_p
	--gtg_p
	-generate_tree_graph_package
	--generate_tree_graph_package
	-gtg_canonical
	--gtg_canonical
	-gtg_html
	--gtg_html
	-gtg_html_frame
	--gtg_html_frame
	-gtg_snapshot
	--gtg_snapshot
	-gtg_snapshots
	--gtg_snapshots
	-gtg_cn
	--gtg_cn
	-gtg_sd
	--gtg_sd
	-generate_tree_graph_source_directories
	--generate_tree_graph_source_directories
	-gtg_exclude
	--gtg_exclude
	-generate_tree_graph_exclude
	--generate_tree_graph_exclude
	-gtg_include
	--gtg_include
	-generate_tree_graph_include
	--generate_tree_graph_include
	-gtg_bd
	--gtg_bd
	-gtg_rbd
	--gtg_rbd
	-gtg_tn
	--gtg_tn
	-gtg_config
	--gtg_config
	-gtg_config_edge
	--gtg_config_edge
	-gtg_pbs_config
	--gtg_pbs_config
	-gtg_pbs_config_edge
	--gtg_pbs_config_edge
	-gtg_gm
	--gtg_gm
	-generate_tree_graph_group_mode
	--generate_tree_graph_group_mode
	-gtg_spacing
	--gtg_spacing
	-gtg_ps
	--gtg_ps
	-gtg_svg
	--gtg_svg
	-gtg_printer
	--gtg_printer
	-generate_tree_graph_printer
	--generate_tree_graph_printer
	-a
	--a
	-ancestors
	--ancestors
	-dbsi
	--dbsi
	-display_build_sequencer_info
	--display_build_sequencer_info
	-dbs
	--dbs
	-display_build_sequence
	--display_build_sequence
	-dbsno
	--dbsno
	-display_build_sequence_name_only
	--display_build_sequence_name_only
	-files
	--files
	-fe
	--fe
	-files_extra
	--files_extra
	-fr
	--fr
	-files_from_repository
	--files_from_repository
	-bi
	--bi
	-build_info
	--build_info
	-nbh
	--nbh
	-no_build_header
	--no_build_header
	-dpb
	--dpb
	-display_progress_bar
	--display_progress_bar
	-ndpb
	--ndpb
	-display_no_progress_bar
	--display_no_progress_bar
	-bre
	--bre
	-build_result
	--build_result
	-bni
	--bni
	-build_and_display_node_information
	--build_and_display_node_information
	-verbosity
	--verbosity
	-u
	--u
	-user_option
	--user_option
	-D
	--D
	-debug
	--debug
	-dump
	--dump
	-dwfn
	--dwfn
	-display_warp_file_name
	--display_warp_file_name
	-display_warp_time
	--display_warp_time
	-warp
	--warp
	-no_warp
	--no_warp
	-dwt
	--dwt
	-display_warp_tree
	--display_warp_tree
	-dwbs
	--dwbs
	-display_warp_build_sequence
	--display_warp_build_sequence
	-dww
	--dww
	-display_warp_generated_warnings
	--display_warp_generated_warnings
	-display_warp_checked_nodes
	--display_warp_checked_nodes
	-display_warp_triggered_nodes
	--display_warp_triggered_nodes
	-post_pbs
	--post_pbs
	-evaluate_shell_command_verbose
	--evaluate_shell_command_verbose
	-use_watch_server
	--use_watch_server
	-watch_server_double_check_with_md5
	--watch_server_double_check_with_md5
	-watch_server_verbose
	--watch_server_verbose
	-display_simplified_rule_transformation
	--display_simplified_rule_transformation
	-tnonh
	--tnonh
	-tnonr
	--tnonr
	) ;

my($trie) = new Tree::Trie;
$trie->add(@completions) ;

my ($argument_index, $command, @arguments) = @ARGV ;

$argument_index-- ;
my $word_to_complete = $arguments[$argument_index] ;

if(defined $word_to_complete)
	{
	if($word_to_complete =~ /%$/)
		{
		my ($search_type) = $word_to_complete =~ /(%+)$/ ;	
		my ($prefix) = $word_to_complete =~ /^(-+)/ ;	

		$word_to_complete =~ s/%+$// ;	
		$word_to_complete =~ s/^-+// ;	

		my ($longest, @matches) ;

		for(@completions)
			{
			next unless /^$prefix/ ;
			next unless /$word_to_complete/ ;
			
			push @matches, $_ ;
			$longest = length($_) unless $longest > length($_) ; 
			}			

		use Array::Columnize ;
		print STDERR "$longest\n\n" ;
		print STDERR "\n" . columnize(\@matches, {displaywidth => $longest}) ;

		#print "$prefix$word_to_complete" ;

		use Term::ReadKey;
		my ($columns, $hchar, $wpixels, $hpixels) = GetTerminalSize();
		$columns-- ;

		use POSIX qw(ceil floor);	
		my $entries_per_row = floor($columns / ($longest + 1)) ;
		my $rows = ceil (@matches / $entries_per_row) ;

		#print STDERR join "\n", @matches ;
		#print STDERR "\n$rows => $entries_per_row\n" ;
		#print STDERR scalar(@matches) ."\n\n" ;

		print STDERR "\n" ;

		for my $row (0 ..  $rows - 1)
			{
			for my $entry_index (0 .. $entries_per_row - 1 )
				{
				my $entry = $matches[($entry_index * $rows) +  $row] ;
				
				next unless defined $entry ;

				use Term::ANSIColor qw (:constants) ;
				my ($red, $green, $yellow, $reset) = (BOLD . RED , BOLD . GREEN, YELLOW, RESET) ;

 				$entry = sprintf "%-${longest}s ", $entry ;
				$entry =~ s/$word_to_complete/$red$word_to_complete$reset/g ;
				print STDERR $entry ;
				}

			print STDERR "\n" ;
			}

		#print STDERR "\n" ; 
		}
	else
		{
		my @possible_completions = $trie->lookup($word_to_complete) ;
		print join("\n", @possible_completions) ;
		}

	}
#~ else
	#~ {
	#~ # give all the possible completions, this would override other bash completion mechanisms (path, ...)
	#~ print join("\n", $trie->lookup('')) ;
	#~ }

	print  "option?\n" ;
	print "?\n" ;

