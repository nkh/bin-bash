countdown()
(

[[ "$2" ]] && message="$2" ; [[ "$3" ]] && end_message="$3"

IFS=:
set -- $*
secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))

while [ $secs -gt 0 ] ; do
	sleep 1 &
	printf "\r$message%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
	secs=$(( $secs - 1 ))
done

printf "\r$message%02d:%02d:%02d\n" 0 0 0 

[[ "$end_message" ]] ; then echo "$end_message" ; fi 

)

countdown_old()
(

if [ ! -z $2 ] ; then message="$2 " ; fi 
if [ ! -z $3 ] ; then end_message="$3" ; fi 

IFS=:
set -- $*
secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))

while [ $secs -gt 0 ]
	do
	sleep 1 &
	printf "\r$message%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
	secs=$(( $secs - 1 ))
	wait
	done

printf "\r$message%02d:%02d:%02d\n" 0 0 0 

if [ ! -z $end_message ] ; then echo "$end_message" ; fi 

)
