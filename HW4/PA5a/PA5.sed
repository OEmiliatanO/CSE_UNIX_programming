#!/usr/bin/sed -nf
#/^$/ ba; /^..$/ H; /^..$/ D;
#s/\(.\{2\}\)\(.\{2\}\)/\2\n\1/; P; /^..\n/ D;
#:a;

#s/.\([DSHC]\).\(.\1.\)\{4\}/Flush/p
#s/...\([2-9JQKA]\)..\(\1..\)\{3\}$/Four of a kind/p
#s/\([2-9JQKA]\)..\(\1..\)\{3\}...$/Four of a kind/p

#s/.\([DSHC]\)\(.\1\)\{4\}/Flush/p
#s/..\([2-9JQKA]\).\(\1.\)\{3\}$/Four of a kind/p
#s/\([2-9JQKA]\).\(\1.\)\{3\}..$/Four of a kind/p
