#!/usr/bin/tcsh
set faces = (0 0 0 0 0 0 0 0 0 0 0 0 0)
set suits = (0 0 0 0)
set suitsym = (♦ ♥ ♠ ♣)
foreach i (`seq 0 51 | sort -R | head -n 5 | sort -g`)
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
        if ( `echo $suits[*]` =~ '*5*') set flush = \ Flush!
        if ( `echo $faces[*]`  =~ '*1 1 1 1 1*' ) then
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
                            echo Ace high! ;exit 0
                        case 12:
                            echo King high! ;exit 0
                        case 11:
                            echo Queen high! ;exit 0
                        case 10:
                            echo Jack high! ;exit 0
                        case 9:
                            echo 10 high! ;exit 0
                        case 8:
                            echo 9 high! ;exit 0
                        case 7:
                            echo 8 high! ;exit 0
                        case 6:
                            echo 7 high! ;exit 0
                        case 5:
                            echo 6 high! ;exit 0
                        case 4:
                            echo 5 high! ;exit 0
                        case 3:
                            echo 4 high! ;exit 0
                        case 2:
                            echo 3 high! ;exit 0
                        case 1:
                            echo 2 high! ;exit 0
                    endsw
                endif
            end
        endif
endsw
