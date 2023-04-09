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
switch ( `echo $faces[*] | tr " " "\n" | sort -gr | tr -d "0\n"` )
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
        if ( `echo $faces[*]`  =~ '1 1 1 1 1' ) then
            echo Straight$flush!
        else if ( `echo $faces[1] $faces[2] $faces[3] $faces[4] $faces[13]`  == '1 1 1 1 1' ) then
            echo Straight$flush!
        else if ( $flush != "" ) then
    	    echo Flush!
        else
            foreach i (`seq 13 -1 1`)
                if ( $faces[$i] != 0 ) then
                    switch ($i)
                        case 13:
                            echo Ace high! ;breaksw
                        case 12:
                            echo King high! ;breaksw
                        case 11:
                            echo Queen high! ;breaksw
                        case 10:
                            echo Jack high! ;breaksw
                        case 9:
                            echo Ten high! ;breaksw
                        case 8:
                            echo Nine high! ;breaksw
                        case 7:
                            echo Eight high! ;breaksw
                        case 6:
                            echo Seven high! ;breaksw
                        case 5:
                            echo Six high! ;breaksw
                        case 4:
                            echo Five high! ;breaksw
                        case 3:
                            echo Four high! ;breaksw
                        case 2:
                            echo Three high! ;breaksw
                        case 1:
                            echo Two high! ;breaksw
                    endsw
                    break
                endif
            end
        endif
endsw
