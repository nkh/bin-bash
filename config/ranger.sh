
alias ranger='VRANGER_USE_TABS=1 vranger'
alias vranger='VRANGER_USE_TABS=1 vranger'

function in_ranger
{
if [ -n "$RANGER_LEVEL" ]; then
	echo "ranger($RANGER_LEVEL) "
else
	echo ''	
fi
}

# Compatible with ranger 1.4.2 through 1.6.*
#
# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

function cdr {
    tempfile='/tmp/chosendir'
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# This binds Ctrl-O to ranger-cd:
bind '"\C-o":"rcd\C-m"'
