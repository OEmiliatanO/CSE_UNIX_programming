#!/bin/bash
echo "Random"
./tester.csh Random | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "Flush"
./tester.csh Flush | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "Straight"
./tester.csh Straight | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "House"
./tester.csh House | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "Pair"
./tester.csh Pair | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "4"
./tester.csh 4 | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "3"
./tester.csh 3 | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "2"
./tester.csh 2 | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
echo "1"
./tester.csh 1 | tr "\n" "," | sed 's/,$/\n/;s/,/, /g'
