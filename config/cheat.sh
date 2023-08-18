
alias c='cheat -a'
alias cl='cheat'
cll() { cheat $1 | less ; }

cg() { cheat $1 | grep "${@:2}" ; }
cga() { grep -h $@ $(cheat -f) ; }

function _cheat_completion
{
if (( COMP_CWORD == 1 ))
	then 
		local old_ifs="${IFS}"
		local IFS=$'\n'
		COMPREPLY=( $( cheat -l | grep -E "^${COMP_WORDS[1]}"  ) )
		IFS="${old_ifs}"
	fi
}

complete -F _cheat_completion cheat
complete -F _cheat_completion c
complete -F _cheat_completion cl
complete -F _cheat_completion cll
complete -F _cheat_completion cg



