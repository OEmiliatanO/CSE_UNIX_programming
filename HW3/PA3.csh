#!/usr/bin/tcsh
set faces = (0 0 0 0 0 0 0 0 0 0 0 0 0)
set suits = (0 0 0 0)
set suitsym = (♦ ♥ ♠ ♣)
foreach i (`seq 1 51 | sort -R | head -n 5 | sort -g`)
    @ su = 1 + ( $i / 13 )
    @ fa = 1 + ( $i % 13 )
    echo -n \  `echo  $fa | grep 1. | cut -c 2 | tr "0123" "JQKA" || expr $fa + 1`$suitsym[$su]
    @ faces[$fa]++
    @ suits[$su]++
end
echo -n ": "
switch ( `echo $faces[*] | tr " " "\n" | sort -gr | tr -d " \n"` )
    case 41:
        echo Four of a kind! ;breaksw
    case 32:
        echo Full house! ;breaksw
    case 311:
        echo Three of a kind! ;breaksw
    case 221:
        echo Two pair! ;breaksw
    case 2111:
        echo One pair! ;breaksw
    case 11111:

        set flush = ""
        if ( `echo $suits[*] | grep 5` ) set flush = \ Flush!
        if ( `echo $faces[*]`  =~ '11111' ) then
            echo Straight$flush!
        if ( `__1__`  == '1 1 1 1 1' ) then
            echo Straight$flush!
