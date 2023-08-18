
bgc="$META_HOME/bin/completions/generated_completions"
source "$bgc"

bash_generate_completion() 
{
echo "_bgc_$1 () { COMPREPLY=( \$( [[ -n \$2 ]] && compgen -W '${@:2}' -- "\${COMP_WORDS[COMP_CWORD]}" )) ; } "
echo "complete -o default -F '_bgc_$1' '$1'"
}

bash_use_completion() { eval "$(bash_generate_completion $@)" ; }
bash_save_completion() { echo "$(bash_generate_completion $@)" >> "$bgc" ; echo "saved to '$bgc'" ; copy --text "$bgc" ; }


