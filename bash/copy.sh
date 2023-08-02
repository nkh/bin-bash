echo "$0: deprecated see 'copy'"
exit 1

copy() 
{
local file= text= trim_nl=false display_message=false

local PARSING=`getopt -o htm --long help,file,text -n 'copy' -- "$@"`
eval set -- "$PARSING"

while true ; do
	case $1 in
		-h | --help) copy_help ; return ;;

		--file     ) file=true ; shift ;;
		--text     ) text=true ; shift ;;
		-t         ) trim_nl=true ; shift ;;
		-m         ) display_message=true ; shift ;;
		--         ) shift ; break ;;
		*          ) echo "Internal error while parsing!" ; exit 1 ;;
	esac
done

[[ $1 = "--" ]] && shift

local output
local res=false
local tmpfile="${TMPDIR}/copy.$RANDOM.txt"
local msg=""

if [[ $# == 0 ]]; then
	output=$(cat)
	msg="Input copied to clipboard"
	res=true
else
	local cmd=""
	for arg in $@; do
		cmd+="\"$(echo -en $arg|sed -E 's/"/\\"/g')\" "
	done

	command_type=$(type "$1" 2> /dev/null)
		
	if [[ $? == 0 && -z $file ]] ; then
		output=$(eval "$cmd" 2>&1 /dev/null)

		if [[ $? == 0 ]]; then
			msg="Results of command '$@' are in the clipboard"
			res=true
		else
			msg="Error running command '$@', $command_type"
			res=false
		fi
	else
		if [[ -f $1 && -z $text ]]; then
			output=""
			for arg in $@; do
				if [[ -f $arg ]]; then
					type=`file "$arg"|grep -c text`
					if [ $type -gt 0 ]; then
						output+=$(cat $arg)
						msg+="Contents of '$arg' are in the clipboard"
						res=true
					else
						msg+="File '$arg' is not plain text"
					fi
				fi
			done
		else
			output=$@
			msg="Text copied to clipboard"
			res=true
		fi
	fi
fi

if $res ; then
	if $trim_nl ; then
		echo -ne "$output" | tr -d '\n' | xsel -i -p -s -b 
	else
		echo -ne "$output" | xsel -i -p -s -b 
	fi

	$display_message && echo -e "$msg"
	return 0
else
	echo -e "$msg"
	return 1
fi
}

copy_help()
{
cat << 'EOH' 
NAME
	copy - copies text, a file content, or a command output, to the clipboad

SYNOPSIS
	command | copy [options]
	copy [options --] [command/file/text]

DESCRIPTION
	$ echo "a text" | copy		stdin is copied to the clipboard
	$ copy some random text		copies a file, "some random text" to the clipboad
	$ copy file			copies content of the file to the clipboard
	$ copy command arg arg		copies the output of $(command arg arg)
	$ copy -- command -opt arg	copies the output of $(command -opt arg), use --
					so the options go to the command not copy

	# in tmux, grab the last command and its output
	$ copy -m -- tmux-grab -l -c

OPTIONS
	-m	display message about the operation
	-t	trim new line from output
	--file	copy file content even if it is executable
	--text	copy as text even it matches a file name

	--help	display this help

SEE ALSO
	last_command, tmux-grab
	original idea from http://brettterpstra.com/2015/04/27/a-universal-clipboard-command-for-bash/
EOH
}

_bgc_copy () { COMPREPLY=( $( compgen -W 'last_command tmux-grab' -- ${COMP_WORDS[COMP_CWORD]} )) ; }
complete -F '_bgc_copy' 'copy'

