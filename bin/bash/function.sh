
function_list() { declare -f $1 ; }
complete -A function -a function_list

function_which() { shopt -s extdebug ; declare -F $1 ; a=$?  ; shopt -u extdebug ; return $a ; }
complete -A function -a function_which

function_vi (){  [[ -n $1 ]] && source /dev/stdin < <(bash_function $1 | vipe --suffix bash) ; }
complete -A function -a function_vi

function_delete() { unset -f $1 ; }
complete -A function -a function_delete

# -----------------------------------------------------------------------------

alias wew=function_which
alias we=type
