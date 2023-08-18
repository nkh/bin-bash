ditto () { for F in $(find $1 -type f) ; do mkdir -p $2/$(dirname ${F#$1}) ; cp $F $2/${F#$1} ; done ; } 

ditto3 ()
{
[[ $# < 3 ]] && printf "usage: ditto3 source '-type d | grep -v to_remove' destination [-p]\n" && return 1 

mkdir $4 $3 &&
printf "%s\n" $(eval "find $1 -maxdepth 1 -mindepth 1 $2") | xargs -n 1 -I{} cp -v -r {} $3

#find A -maxdepth 1 -mindepth 1 -type d -exec cp -v -r {} dest \;
}

ffc () 
{
if [[ -z "$1" || -z $2 ]] ; then 
	cat <<'EOH'
ffc: find files, filter them, and copies them into a destination directory

	source and filters are passed in the first argument.

	simple source:
		ffc source destination
 
	source and arguments to find: 
		ffc 'source -type d' destination

	source, arguments to find, and filter: 
		ffc 'source -type f | grep .c | grep -v not_this_one' destinations
EOH

	return 1
fi

local src=$(echo $1 | awk '{print $1}')

for F in $(eval "find $1" | sort -n ) ; do
	test -d "${F}" && ! test -e $2${F#$src} && mkdir -p $2${F#$src}

	test -f "${F}" && ! test -e $2$(dirname ${F#$src}) && mkdir -p $2$(dirname ${F#$src})

	test -f "$F" && cp $F $2${F#$src} && test -z "$quiet" && echo -e ${F#$src\/} >&2
done

return 0
} 

