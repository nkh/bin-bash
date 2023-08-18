
bgc="$META_HOME/bin/completions/generated_completions"
source "$bgc"

completion_generate() 
{
echo "_bgc_$1 () { COMPREPLY=( \$( [[ -n \$2 ]] && compgen -W '${@:2}' -- "\${COMP_WORDS[COMP_CWORD]}" )) ; } "
echo "complete -o default -F '_bgc_$1' '$1'"
}

completion_use() { eval "$(completion_generate $@)" ; }
completion_save() { echo "$(completion_generate $@)" >> "$bgc" ; echo "saved to '$bgc'" ; copy -m --text "$bgc" ; }

#bind 'set page-completions Off' # show ... More ?
#bind 'set completion-query-items 0' # show how many items left in completion

completion_get() {

# Version by: Nadim Khemir
# Based on https://brbsix.github.io/2015/11/29/accessing-tab-completion-programmatically-in-bash
# Original source: https://brbsix.github.io/2015/11/29/accessing-tab-completion-programmatically-in-bash/
# License: LGPLv3 (http://www.gnu.org/licenses/lgpl-3.0.txt)

local completion completion_type COMP_CWORD COMP_LINE COMP_POINT COMP_WORDS COMPREPLY=()

COMP_LINE=$*
COMP_POINT=${#COMP_LINE}
COMP_WORDS=("$@")

if [[ ${#COMP_WORDS[@]} -eq  0 ]] ; then 
	return 0
elif [[ ${#COMP_WORDS[@]} -eq 1 ]] ; then 
	COMP_CWORD=$(( ${#COMP_WORDS[@]} ))
else
	COMP_CWORD=$(( ${#COMP_WORDS[@]} - 1 ))
fi


# load bash-completion if necessary
declare -F _completion_loader &>/dev/null || source /usr/share/bash-completion/bash_completion

# determine completion function
completion=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-1)}' | sed -e "s/^'//" -e "s/'$//")

# run _completion_loader only if necessary
[[ -n $completion ]] || {

	# load completion
	_completion_loader "$1"

	# detect completion
	completion=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-1)}') | sed -e "s/^'//" -e "s/'$//"
	}

# ensure completion was detected
[[ -n $completion ]] || return 1
	
completion_type=$(complete -p "$1" 2>/dev/null | awk '{print $(NF-2)}')

# execute completion function

if [[ "$completion_type"  == '-F' ]] ; then 
	"$completion"
elif [[ "$completion_type"  == '-C' ]] ; then 
	mapfile -t COMPREPLY < <( "$completion" "${COMP_WORDS[0]}" "${COMP_WORDS[-1]}" "" )
else
	printf "completion type %s not supported\n" "$completion_type"
	return 1
fi

# print completions to stdout
printf '%s\n' "${COMPREPLY[@]}" | LC_ALL=C sort -u

# try with extra '', ie: git co '' would give the branches and tags

printf "# completion_get:\n"
printf "# function: $completion\n"
printf "# words:  ${#COMP_WORDS[@]}\n"
printf "#\t%s\n" "${COMP_WORDS[@]}"
printf "# completion_type: %s\n" "$completion_type"
printf "# results: %d\n" ${#COMPREPLY[@]}
}

