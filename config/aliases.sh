
alias please='sudo -p "... "'
alias psd='please spin_down &>/dev/null'
alias rc=realclean

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias f=~/nadim/bin/fzfpp
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias fw='cat /usr/share/dict/words | fzf | copy'

alias ls='ls --color=auto -h -v --group-directories-first -b'
alias lsx='ls --color=auto -h -v --group-directories-first -X -b'
alias lsl='ls --color=auto -g -h -v --group-directories-first -b'

alias a='atw'
alias acki='ack -i'
alias build=./Build
alias b=./Build
alias lfm='lfm -1'
alias l2='links2'
alias f='ftl'
alias r='ranger'
alias btc=bluetoothctl
alias cmus='tmux new-session -s cmus -d "$(which cmus)" 2> /dev/null; tmux switch-client -t cmus'
alias mp3_record='arecord -f cd | pv | lame -q 0 -V 0 - '
alias sound_control=pavucontrol
# alias watch='watch -n 1 -d  --color bash -ic'
alias whatsmyip='curl ifconfig.me'
alias t=todolist
alias po=pbs_options
alias loop=loop-rs
alias cp2='vi /home/nadim/nadim/devel/repositories/perl_modules/P5-PerlBuildSystem/pbs2_collection_of_requirements.txt'
alias spreadshee=scim
alias clc=copy_last_command

alias v='vim -p'
alias ve="vim -p -c ':call FZFPickNkh()|tabo'"
alias vh="vim -p -c ':FZFMru'"
alias eb='vi ~/.bashrc'
alias sb='source ~/.bashrc'

complete -F '__edit_config_completion' 'e'

alias ev='vi ~/.vimrc'
alias vi_swap="find | grep '\.sw'"
alias vi_swap_kill="find -print0 | grep -z '.sw' | xargs -0 rm"

alias yank_pipe='\yank-cli | ansi_show_stripped_all'
alias yank='\yank-cli | ansi_show_stripped_all | xsel -b'

alias copy_last_command='last_command|copy'

alias pvi='parallel -X --tty vi -p'
alias ppe='perl -p -e'
alias pne='perl -n -e'

alias extract='dtrx'
alias download='aria2c'
alias open='xdg-open'
alias jobs='jobs -l'
alias retro_term='cool-retro-term'

alias bash_functions='declare -F'
alias bash_function='declare -f'
alias all_commands='compgen -c'

alias info=pinfo
alias help='help -m'
alias vcat=~/nadim/bin/vimcat
alias cat_non_ascii="ocat -v -t -e" 
alias markdown_view="python ~/.local/lib/python2.7/site-packages/mdv/markdownviewer.py"

alias mount_show='mount |column -t'

alias :w='echo "*** not in vim ***"'
alias :wq='echo "*** not in vim ***"'
alias :q='echo "*** not in vim ***"'
alias q='echo "*** not in vim ***"'

alias cmx='chmod +x'
alias cmnx='chmod -x'
#alias 755='chmod 755'

alias gpge='gpg --encrypt --sign --armor '
#complete -F '_gpg' 'gpge'

ff() { firefox "$@" 2>/dev/null & }
export -f ff

# word functions
alias wn_lup='look | fzf'

wn_spell() { echo "$1" | aspell -a ;}

wn_color() { piper 'Synonyms.*' yellow 'Sense.*' blue 'Antonyms.*' yellow 'Grep of.*' yellow ;}
wn_filter() { perl -ne '($s and do {$s^=1; 1}) || (!/\d+ senses? of/ and print) || ($s^=1)' ;}

wn_syn() { wn $1 -synsn -synsv -synsa -synsr | wn_filter | wn_color | less -R -F ;}
wn_all() { wn $1 -synsn -synsv -synsa -synsr -antsn -antsv -antsa -antsr -grepn -grepv -grepa -grepr | wn_filter | wn_color | less -R -F ;}

wn_help() { echo wn_syn wn_all wn_spell wn_lup wn wnb;}
 
