
function _ra_perl_completion
{
local old_ifs="${IFS}"
local IFS=$'\n'

COMPREPLY=( $(~/nadim/bin/completions/ra_perl_completion.pl ${COMP_CWORD} ${COMP_WORDS[@]}))

IFS="${old_ifs}"
}

complete -o default -F _ra_perl_completion ra


