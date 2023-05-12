#!/usr/bin/sed -nf
s/\(.\{2\}\)\(.\{23,24\}\)/\2\n\1/; /.*\n/ P; //D;
H;
//d;

G; s/^....//
:J;tJ
s/.\([DSHC]\).\(.\1.\)\{3\}\(.\1\)$/Flush/p
s/..\n\([2-9TJQKA]\).\n\(\1.\n\)\{2\}\(\1.\)$/Four of a kind/p
s/\([2-9TJQKA]\).\n\(\1.\n\)\{3\}..$/Four of a kind/p

/$/! d;

# flush or four of a kind
be
:a q;
:e s/\(Flush|Four of a kind\)/\1/
ta

# del suits
s/[DSHC]\(\n\|$\)//g;
# ps: 2345T

# branch if no three identical numbers
s/\([2-9TJQKA]\)\1\1/\1\1\1/; To
# AAABB
# BBAAA
/\(\([2-9TJQKA]\)\2\2\([2-9TJQKA]\)\3\|\([2-9TJQKA]\)\4\([2-9TJQKA]\)\5\5\)/ c\
Full house
# AAABC
# BAAAC
# BCAAA
/\(\([2-9TJQKA]\)\2\2[2-9TJQKA]\{2\}\|[2-9TJQKA]\{2\}\([2-9TJQKA]\)\3\3\|[2-9TJQKA]\([2-9TJQKA]\)\4\4[2-9TJQKA]\)/ c\
Three of a kind
:o

# branch if no two identical numbers
s/\([2-9TJQKA]\)\1/\1\1/; Tk
# AABBC
# AACBB
# CAABB
/\(\([2-9TJQKA]\)\2\([2-9TJQKA]\)\3[2-9TJQKA]\{1\}\|\([2-9TJQKA]\)\4[2-9TJQKA]\{1\}\([2-9TJQKA]\)\5\|[2-9TJQKA]\{1\}\([2-9TJQKA]\)\6\([2-9TJQKA]\)\7\)/ c\
Two pair
# AABCD
# BAACD
# BCAAD
# BCDAA
/\(\([2-9TJQKA]\)\2[2-9TJQKA]\{3\}\|[2-9TJQKA]\{1\}\([2-9TJQKA]\)\3[2-9TJQKA]\{2\}\|[2-9TJQKA]\{2\}\([2-9TJQKA]\)\4[2-9TJQKA]\{1\}\|[2-9TJQKA]\{3\}\([2-9TJQKA]\)\5\)/ c\
One pair
:k

s/$/_23456789T/

/\([2-9T]\{5\}\).*\1/ c\
Straight

# 2345A
/2345A/ c\
Straight

# AJKQT
#The following line handles both: 9, T, J, Q, K and T, J, Q, K, A
#Hint: Both "A" and "9" will sort earlier than 'J'.
/\(9|A\)JKQT/ c\
Straight

#The following line handles: 8, 9, T, J, Q
/89JQT/ c\
Straight

#The following line handles: 7, 8, 9, T, J
/789JT/ c\
Straight

#The following line handles the "Nothing" case
/....._23456789T$/ c\
Nothing
