#!/usr/bin/sed -nf
#/^$/ ba; /^..$/ H; /^..$/ D;
#s/\(.\{2\}\)\(.\{2\}\)/\2\n\1/; P; /^..\n/ D;
#:a;

N;N;N;N; #s/\n//g
s/.\([DSHC]\).\(.\1.\)\{3\}\(.\1\)$/Flush/p
s/..\n\([2-9JQKA]\).\n\(\1.\n\)\{2\}\(\1.\)$/Four of a kind/p
s/\([2-9JQKA]\).\n\(\1.\n\)\{3\}..$/Four of a kind/p

#s/.\([DSHC]\)\(.\1\)\{4\}/Flush/p
#s/..\([2-9JQKA]\).\(\1.\)\{3\}$/Four of a kind/p
#s/\([2-9JQKA]\).\(\1.\)\{3\}..$/Four of a kind/p
