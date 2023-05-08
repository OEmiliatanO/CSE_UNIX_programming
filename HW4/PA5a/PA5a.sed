#!/usr/bin/sed -nf
s/\(.\{2\}\)\(.\{23,24\}\)/\2\n\1/; /.*\n/ P; //D;
H;
//d;
#N;N;N;N; #s/\n//g
G; s/^....//
s/.\([DSHC]\).\(.\1.\)\{3\}\(.\1\)$/Flush/p
s/..\n\([2-9TJQKA]\).\n\(\1.\n\)\{2\}\(\1.\)$/Four of a kind/p
s/\([2-9TJQKA]\).\n\(\1.\n\)\{3\}..$/Four of a kind/p

#s/.\([DSHC]\)\(.\1\)\{4\}/Flush/p
#s/..\([2-9JQKA]\).\(\1.\)\{3\}$/Four of a kind/p
#s/\([2-9JQKA]\).\(\1.\)\{3\}..$/Four of a kind/p
