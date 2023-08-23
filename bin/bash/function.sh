
function_list() { declare -f $1 ; }
complete -A function -a function_list

function_which() { shopt -s extdebug ; declare -F $1 ; a=$?  ; shopt -u extdebug ; return $a ; }
complete -A function -a function_which

function_vi (){  [[ -n $1 ]] && source /dev/stdin < <(bash_function $1 | vipe --suffix bash) ; }
complete -A function -a function_vi

function_delete() { unset -f $1 ; }
complete -A function -a function_delete

is_bash_internal() { help -d $1 2> /dev/null ; }

alias_which() {

alias_definition=$(alias $1 2>/dev/null)
own_definitions=$(ack -1 --nogroup --no-color --output="🚲\$\`\$&\$'" "alias $1=" ~/nadim/config ~/nadim/bin | perl -pe 's/(.*:)🚲/$1 =~tr[:][ ]r/ge')

if [[ -n "$alias_definition" ]] ; then
	found_current=$(echo -n "$own_definitions" | grep "$alias_definition")

	[[ -n "$own_definitions" ]] && echo "$own_definitions"
	echo "${YELLOW}current: ${alias_definition}${RESET}"
	return 0
else
	[[ -n "$own_definitions" ]] && echo "Unused alias: $own_definitions"
	return 1
fi

}

# type -a $1 is a good replacement for this copious amount of bash code!
#whichever () { [[ -n $1 ]] && ( function_which $1 || alias $1 2> /dev/null || is_bash_internal $1 || (a=$(which $1) && ls "$(which $a)") ) ; }

whichever () 
{
what=$1
and_or='||'
[[ -n $what ]] && [[ $what == '-a' ]] && and_or=';' && what=$2

if [[ -n $what ]] ; then 
	cmd="alias_which $what $and_or function_which $what 2> /dev/null $and_or is_bash_internal $what $and_or (a=\$(which $what) && ls -gGh  \$(which $what))"  
	eval "$cmd"
fi
}

export -f whichever

# -a alias -b builtin -c commands -? function
#compgen -a -b -c 
_bgc_whichever () { COMPREPLY=( $(compgen -W '$(compgen -a) $(compgen -b)  $(compgen -c) ' -- ${COMP_WORDS[COMP_CWORD]} )) ; }
complete -o default -F '_bgc_whichever' 'whichever'

alias we=whichever
complete -o default -F '_bgc_whichever' 'we'

oec() { local error=${1:?oec: error: no column given} ; ec $1 | oe ; }
