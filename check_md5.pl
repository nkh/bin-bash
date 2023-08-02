open F0, "< $ARGV[0]" ; open F1, "< $ARGV[1]" ;

while(<F0>){ chomp; /^([0-9a-f]+)\s+(.*)/ ; $l{$1}=[$2, $.] ;}

$.=0 ;
while(<F1>){ chomp; ($k, $v) = /^([0-9a-f]+)\s+(.*)/ ; if (exists $l{$k}){print STDOUT "($.)$k: $v => ($l{$k}[1]) $l{$k}[0]\n"} else { print STDERR "not found ($.)[$k] $v\n" } }


