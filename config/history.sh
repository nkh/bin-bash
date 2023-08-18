
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=5000
HISTFILESIZE=20000

# Note! setup history file for the current session
# by calling mycd_update_HISTFILE
# see at the  end of the file

alias eh='history -w ; vi $HISTFILE +50000; history -c ; history -r'
history_grep (){ find ~/.dir_bash_history/ -type f -print0 | xargs -0 grep -s -h --color "$@" ; }

# history per directory
alias cd='mycd'
alias pushd='mypushd'
alias popd='mypopd'

mycd()
{
SESSION_DIRS+=("$(pwd)") 

history -a # write current history file
builtin cd "$@" 
error_code=$?
mycd_update_HISTFILE

return $error_code
}
 
mypushd()
{
history -a # write current history file
builtin pushd "$@"
mycd_update_HISTFILE
}

mypopd()
{
history -a # write current history file
builtin popd "$@" 
mycd_update_HISTFILE
}

mycd_update_HISTFILE()
{
local HISTDIR="$HOME/.dir_bash_history$PWD" # use nested folders for history

mkdir -p "$HISTDIR"

export HISTFILE="$HISTDIR/bash_history.txt" # set new history file
touch "$HISTFILE"
#echo history file: $HISTFILE

history -c # clear memory
history -r #read from current histfile
}

# setup history file for the current session
history -w # write current history file
mycd_update_HISTFILE

# add tag in history and remove entries up to the tag
alias ht='history -s "#@ <"$(date | tr " " "_")">"'
htd()
{
[[ -z "$1" ]] && return

i=$(history | sed '-e s/^\s\+//' -e '/[0-9]\+\s\+\#\@\ <.*'$1'/!d' | tail -n 1 | cut -d ' ' -f 1)
[[ "$i" == "" ]] && return

m=`history 1 | awk '{print $1}'`

for x in `seq $i $m` ; do history -d $i ; done 
}

