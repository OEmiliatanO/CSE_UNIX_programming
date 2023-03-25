#!/usr/bin/tcsh
cd $1
ls ?? | xargs -l fgrep ../allcards -e | cut --complement -c 1-2
ls ?H |& fgrep -v : | wc -l >  ___tempfile1
ls ?C |& fgrep -v : | wc -l >> ___tempfile1
ls ?D |& fgrep -v : | wc -l >> ___tempfile1
ls ?S |& fgrep -v : | wc -l >> ___tempfile1
fgrep 5 ___tempfile1 |& cat>/dev/null && echo Flush!
ls [2-9][CSHD] |& fgrep -v : | cut -c 1 > faces
ls [TJQKA][CSHD] |& fgrep -v : | cat -n | tr "\tTJQKA" "101234" | cut -c 7,8  >> faces
uniq -c faces | cut -c 7 > facecounts
expr `cat facecounts | grep 2 | wc -l` = 1 |& cat >/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 4 |& cat >/dev/null && echo One pair!
expr `cat facecounts | grep 2 | wc -l` = 2 |& cat >/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 3 |& cat >/dev/null && echo Two pair!
expr `cat facecounts | grep 3 | wc -l` = 1 |& cat>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 3 |& cat >/dev/null && echo Three of a kind!
expr `cat facecounts | grep 4 | wc -l` = 1 |& cat>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 2 |& cat >/dev/null && echo Four of a kind!
expr `cat facecounts | grep 3 | wc -l` = 1 |& cat>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 2 |& cat >/dev/null && echo Full house!
expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 5 |& cat>/dev/null && expr `sort -g faces | tail -n 1` - `sort -g faces | head -n 1` = 4 |& cat>/dev/null && echo Straight!
expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 5 |& cat>/dev/null && sort -g faces | head -n 1 | grep -q 2 && sort -g faces | tail -n 2 | grep -q 14 && sort -g faces | tail -n 2 | grep -q 5 && echo Straight!
