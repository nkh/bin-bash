cd_help()
{
echo "
cdn	# cd $META_HOME
cdnb=	# cd $META_HOME/bin
cdnbb	# cd $META_HOME/bin/bash
cdnc	# cd $META_HOME/config
cdndr	# cd $META_HOME/devel/repositories
cdndr	# cd $META_HOME/devel/repositories
cdndrp	# cd $META_HOME/devel/repositories/perl_modules


cdm	# cd mark
cdml	# fzf marks, pushd $(cdml)
cdf	# cd fzf
cdr	# ranger cd
cdr	# cd in repos: /home/nadim/nadim/devel/repositories/;/home/nadim/nadim/devel/repositories/perl_modules/; /home/nadim/no_backup/devel/repositories/

p	# add OLDPWD to dirs stack 

cdp	# cd and p
cdf	# cdf and p
cdmp	# cd mark and p
rcdp	# rcd and p

cdh	# cd history
cdhc	# cd history clean
cdhl	# cd history list
"
}

alias cdn='cd $META_HOME'
alias cdnb='cd $META_HOME/bin'
alias cdnbb='cd $META_HOME/bin/bash'
alias cdnc='cd $META_HOME/config'
alias cdnd='cd $META_HOME/downloads'
alias cdndr='cd $META_HOME/devel/repositories'
alias cdndr='cd $META_HOME/devel/repositories'
alias cdndrp='cd $META_HOME/devel/repositories/perl_modules'

cdhc() { SESSION_DIRS=() ; }
cdhl() { printf "%s\n" "${SESSION_DIRS[@]}" ; }
cdh()  { new_dir=$(cdhl | uniq | fzf) ; [[ -n "$new_dir" ]] && cd $new_dir ; }

cdd()
{
start_directory='.'
[[ "$1" == "-d" ]] && { start_directory="$2" ; shift 2 ; }

fzf_query=
[[ $# > 0 ]] && fzf_query="$@"

end_directory=$(fd . --color always --type d "$start_directory" | fzf --ansi -q "$fzf_query")

[[ $? == 0 ]] && cd "$end_directory"
}

if [[ -z "${FZF_MARKS_FILE}" ]] ; then
    FZF_MARKS_FILE="${HOME}/.fzf-marks"
fi

cdrep_paths=(\
/home/nadim/nadim/devel/repositories/ \
/home/nadim/nadim/devel/repositories/perl_modules/ \
/home/nadim/no_backup/devel/repositories/)

cdrep ()
{
#todo: color the repo name or remove the path

local repos=$({ for i in ${cdrep_paths[@]} ; do find "$i" -maxdepth 1 -type d ; done ; })

if [[ ${#@} == 0 || ${#@} -gt 1 ]] ; then
	d=$(echo "$repos" | fzf --ansi --reverse)
	[[ -n "$d" ]] && cd "$d"
else
	local matches=0
	local matching_repos=$(echo "$repos" | grep -i "$1") 
	[[ -n "$matching_repos" ]] && matches=$(echo "$matching_repos" | wc -l) 

	if [[ $matches == 0 ]] ; then
		d=$(echo "$repos" | fzf --ansi --height 50% --reverse)
		[[ -n "$d" ]] && cd "$d"
	elif [[ $matches -gt 1 ]] ; then
		d=$(echo "$matching_repos" | grep -i "$1" | fzf --ansi --reverse) 
		[[ $? == 0 ]] && cd "$d" || false
	else
		cd "$matching_repos"
	fi
fi
}

_cdrep_completion()
{
local repos=$({ for i in ${cdrep_paths[@]} ; do find "$i" -maxdepth 1 -type d ; done ; })

#todo: do completion on repo name not on repo path

COMPREPLY=( $( compgen -W "$(echo "$repos" | ([[ -n $2 ]] && grep -i $2 || cat | tr '\n' ' '))" -- ${COMP_WORDS[$COMP_CWORD]} ))
}

complete -o default -F _cdrep_completion cdrep

function cdml() {
lines=$(_fzm_color_marks < "${FZF_MARKS_FILE}" | eval ${FZF_MARKS_COMMAND} \
	--ansi \
	--expect="${FZF_MARKS_DELETE:-ctrl-d}" \
	--multi \
	--bind=ctrl-y:accept,ctrl-t:toggle \
	--query="$*" \
	--select-1 \
	--tac)
printf "%s\n" "${lines[@]}" |  sed 's/.*: \(.*\)$/\1/' | sed "s#~#${HOME}#"
}

cdm ()
{
if [[ ${#@} == 0 || ${#@} -gt 1 ]] ; then
	fzm
else
	matches=$(cat $FZF_MARKS_FILE | awk '{print $1}' | grep "$1" | wc -l) 

	if [[ $matches == 0 ]] ; then
		fzm
	elif [[ $matches -gt 1 ]] ; then
		directory=$(_fzm_color_marks <<< $(perl -ane '$F[0] =~ /'$1'/ and print $_' $FZF_MARKS_FILE) | fzf --ansi --height 50% --reverse) 
		[[ $? == 0 ]] && cd $(echo "$directory" | awk '{print $3}') || false
	else
		directory=$(perl -ane '$F[0] =~ /'$1'/ and print $F[2]' $FZF_MARKS_FILE) 
		[[ -n "directory" ]] && cd "$directory" || fzm "$1"
	fi
fi
}

_cdm_completion()
{
COMPREPLY=( $( compgen -W "$(cat $FZF_MARKS_FILE | awk '{print $1}' | ([[ -n $2 ]] && grep $2 || cat | tr '\n' ' '))" -- ${COMP_WORDS[$COMP_CWORD]} ))
}

complete -o default -F _cdm_completion cdm

p () # add OLDPWD to dirs stack 
{
top="$(dirs -l +1 2>/dev/null)"
[[ "$OLDPWD" != "" && "$OLDPWD" != "$PWD" &&  "$top" == "" || "$top" != "$OLDPWD" ]] && pushd -n "$OLDPWD" &>/dev/null
}

cdp () { cd "$1" && p ; }
cdfp() { cdf "$1" && p ; }
cdmf() { cdm "$1" && cdf ; }
cdmr() { cdm "$1" && cdr ; }
cdmp() { cdm "$1" && p ; }
rcdp() { rcd && p ; } #rcd always succeeds!


