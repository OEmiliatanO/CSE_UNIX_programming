#!/usr/bin/tcsh
#The line above here will be the first line of your PA2 script. You can change
#the path, however, if your tcsh file is in a different place.


#Your previous programming assignment (PA1) displayed cards and then told you
#if you had a flush. Now, this new assignment (PA2) will extend that to also
#print messages for straights and for matching cards (eg three-of-a-kind).


#n this assignment: only use commands from Lectures 1-4, and don't use any ";".
#When filling in the blanks indicated below, you may use any piping sequence
#of commands, and you may use "&&" and "||". So, for example, if you saw:
#  __________________ echo forexample
#Then something must go before the "echo" that would not break UNIX syntax.
#So it could be "... | echo forexample" or "... | xargs echo forexample" or
#"... || echo forexample" or "... && echo forexample". (But not "...; echo",
#because I am not allowing you to use ";" in this programming assignment.


# -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -


#Below, I comment PA1's solution, and I indicate what to add or to change:

#PA1 line #1
# cd $*  <= This was PA2. But for PA2, you must use the first parameter, not $*.
cd $1

#PA1 lines #2-6
#The next 5 lines are the same in PA2 as they were in PA1 (so copy these lines):
ls ?? | xargs -l fgrep ../allcards -e | cut --complement -c 1-2
#ls ?H 2>/dev/null | wc -l > ___tempfile1
#ls ?C 2>/dev/null | wc -l >> ___tempfile1
#ls ?D 2>/dev/null | wc -l >> ___tempfile1
#ls ?S 2>/dev/null | wc -l >> ___tempfile1

ls ?H |& fgrep -v : | wc -l >  ___tempfile1
ls ?C |& fgrep -v : | wc -l >> ___tempfile1
ls ?D |& fgrep -v : | wc -l >> ___tempfile1
ls ?S |& fgrep -v : | wc -l >> ___tempfile1
#cat ___tempfile1

#PA1 lines #7-9
#The next 3 lines printed "Flush!", but they needed a tempfile:
# echo Flush! > ___tempfile2
# fgrep 5 ___tempfile1 | paste - ___tempfile2 | cut --complement -c1-2 | fgrep F
# rm ___tempfile?

#In PA2, however, we now know about command coordination with || and &&. This
#will allow us to only print "Flush!" if there is a "5" in the tempfile. So,
#on the following line you must achieve printing Flush! using only fgrep & echo:
#fgrep 5 ___tempfile1 &>/dev/null && echo Flush!
fgrep 5 ___tempfile1 |& cat>/dev/null && echo Flush!

#That is the end of the section that is like PA1. Now for the new behavior:
#In PA2, we do not only check for flushes (all cards being one suit). We also
#check for straights (all cards are in sequence), and for matching card faces.
#For these checks, the suit of the cards does not matter. Therefore, on the
#next two lines of your answer, you will create a file for just the faces (not
#the suits). Moreover, the faces of the T, J, Q, K, and A will be converted into
#the numbers 10, 11, 12, 13, and 14, respectively.
#
#Not clear? Then consider the following example, where I have already run the
#two lines to create the faces file:
#  % basename `pwd`
#  sample1
#  % ls
#  2C  3C  5C  AC  TC  faces
#  % ls ?[CSHD] | paste - faces
#  2C      2
#  3C      3
#  5C      5
#  AC      14
#  TC      10
#  % 
#
#Understand? The cards 2-9 display their filenames' first character; the other
#cards display a number code.
#
#As I said above, you will need 2 lines of code to accomplish this. The first
#line is for all cards from 2 to 9:
#ls [2-9][CSHD] 2>/dev/null | cut -c 1 > faces 2>/dev/null
ls [2-9][CSHD] |& fgrep -v : | cut -c 1 > faces

#The second line is for the ten, jack, queen, king and ace. This line is harder,
#because the letters for these cards need to be converted to numbers. To make
#things even harder, these are 2-digit numbers. The solution will need to do two
#things: 1) Insert a "1" in front of each of these cards, and 2) Convert T to 0,
#J to 1, Q to 2, K to 3, and A to 4. The harder of these parts is the putting
#of the "1" in the front, because we can only use commands from lectures 1-4,
#and that does not give us many ways to put something in from of each line of
#input. The answer is to use "cat -n" to put a "\t" in front of each line (along
#with some other things that "cat -n" will insert, but that you can then remove.
#ls [TJQKA][CSHD] 2>/dev/null | cat -n | tr "\tTJQKA" "101234" | cut -c 7,8  >> faces
ls [TJQKA][CSHD] |& fgrep -v : | cat -n | tr "\tTJQKA" "101234" | cut -c 7,8  >> faces

#Now that we have a list of faces, we can analyze which cards match each other.
#To this end, we wish to create a file, facecounts, that contains a list of
#numbers, 1 number per line. If we add these numbers, they always add up to 5.
#
#Not clear? Here are all of the cases (in each case line order is unimportant).
#
# If you had:                                  Then facecounts will have:
# ------------------------------------------   -------------------------------
# 4-of-a-kind (eg 4 fives + 1 side card)       Two lines: a '4' and a '1'
# 3-of-a-kind (eg 3 tens + 2 side cards)       Three lines: a '3' and two '1'
# 2-of-a-kind (eg 2 sevens + 3 side cards)     Four lines: a '2' and three '1'
# 2-pair (eg 2 aces + 2 twos + 1 side card)    Three lines: a '1' and two '2'
# Full-house (eg 2 fives + 3 kings)            Two lines: a '2' and a '3'
# No matches (ie, either a flush or garbage)   Five lines: all '1'
#
# So put that line here. (Hint: uniq -c)
uniq -c faces | cut -c 7 > facecounts

# The next line controls whether to print "One pair!"
# Hint: In this case facecounts would have 4 lines.
# Hint: expr understands the "==" operator.
#expr `cat facecounts | grep 2 | wc -l` = 1 &> /dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 4 &>/dev/null && echo One pair!
expr `cat facecounts | grep 2 | wc -l` = 1 |& cat >/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 4 |& cat >/dev/null && echo One pair!
#cat facecounts | grep 2 | wc -l | grep 1 -q && expr `wc -l facecounts` = 4 && echo one pair!

# The next line controls whether to print "Two pair!"
# Hint: In this case facecounts would have 3 lines. <= But so would 3-of-a-kind
# Hint: facecounts would have a '2'
#expr `cat facecounts | grep 2 | wc -l` = 2 &>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 3 &>/dev/null && echo Two pair!
expr `cat facecounts | grep 2 | wc -l` = 2 |& cat >/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 3 |& cat >/dev/null && echo Two pair!
#cat facecounts | grep 2 | wc -l | grep 2 -q && expr `wc -l facecounts` = 3 && echo Two pair!

# The next line controls whether to print "Three of a kind!"
# Hint: In this case facecounts would have 3 lines. <= But so would 2-pair
# Hint: facecounts would have a '3'
#expr `cat facecounts | grep 3 | wc -l` = 1 &>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 3 &>/dev/null && echo Three of a kind!
expr `cat facecounts | grep 3 | wc -l` = 1 |& cat>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 3 |& cat >/dev/null && echo Three of a kind!
#cat facecounts | grep 3 | wc -l | grep 3 -q && expr `wc -l facecounts` = 3 && echo Three of a kind!

# The next line controls whether to print "Four of a kind!"
# Hint: In this case facecounts would have 2 lines. <= But so would full-house
# Hint: facecounts would have a '4'
#expr `cat facecounts | grep 4 | wc -l` = 1 &>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 2 &>/dev/null && echo Four of a kind!
expr `cat facecounts | grep 4 | wc -l` = 1 |& cat>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 2 |& cat >/dev/null && echo Four of a kind!
#cat facecounts | grep 4 | wc -l | grep 4 -q && expr `wc -l facecounts` = 2 && echo Four of a kind!

# The next line controls whether to print "Full house!"
# Hint: In this case facecounts would have 2 lines. <= But so would 4-of-a-kind
# Hint: facecounts would have a '3'
#expr `cat facecounts | grep 3 | wc -l` = 1 &>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 2 &>/dev/null && echo Full house!
expr `cat facecounts | grep 3 | wc -l` = 1 |& cat>/dev/null && expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 2 |& cat >/dev/null && echo Full house!
#cat facecounts | grep 3 | wc -l | grep 1 -q && expr `wc -l facecounts` = 2 && echo Full house!

# The next line controls whether to print "Straight!" (which means that all of)
# the cards are sequential). Note that, when you have a straight, you might also
# have flush -- and that is OK, you script will just print both messages.
# Further note that, when you have a straight, facecount will be all '1's.
# Finally, note that there is a special kind of straight that this current line
# will not catch: the ace-low straight (14, 2, 3, 4, 5).
#
# So how to do it? First, you will test facecounts to make sure that all of
# the cards are different, then you will use expr, ``, sort, tail, and head,
# in order to test whether the value difference between the high card and low
# the card is 4. In that case, you have a straight.
# Q: "Do I have to use expr, ``, sort, tail, and head?"  A: "Yes."
#expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 5 &>/dev/null && expr `sort -g faces | tail -n 1` - `sort -g faces | head -n 1` = 4 &>/dev/null && echo Straight!
expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 5 |& cat>/dev/null && expr `sort -g faces | tail -n 1` - `sort -g faces | head -n 1` = 4 |& cat>/dev/null && echo Straight!
#expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 5 && expr `sort -g faces | tail -n 1` - `sort -g faces | head -n 1` = 4 && echo Straight!

#This final line handles the ace-low straight (14, 2, 3, 4, 5). Implement it
#any way that you want, but only using commands from lectures 1-4 
#expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 5 &>/dev/null && sort -g faces | head -n 1 | grep -q 2 && sort -g faces | tail -n 2 | grep -q 14 && sort -g faces | tail -n 2 | grep -q 5 && echo Straight!
expr `wc -l facecounts | cut -f 1 --delimiter=' '` = 5 |& cat>/dev/null && sort -g faces | head -n 1 | grep -q 2 && sort -g faces | tail -n 2 | grep -q 14 && sort -g faces | tail -n 2 | grep -q 5 && echo Straight!


#And that is the end of your script. You will notice that there is no output for
#garbage hands (ie, hands that have no matches or straights or flushes).
