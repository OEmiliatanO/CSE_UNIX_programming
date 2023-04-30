#!________________
# The above line defines the path to sed and the flags to sed

#Now recall that the lines of the allcards file have a specific format:
# - The first 2 characters of each line represent a character in a simple way.
# - The rest of the line represents that character in a colorful way which is
#   more suitable for pretty printing, but is less suitable for analyzing.



#The following lines print a pretty card (meaning that everything except for
#the first 2 characters is printed). These lines also take those first two
#characters and append them onto the end of the hold space.

 .
 .    <= lines go here
 .

#The following line loads the hold space into the pattern space:
____


#The following _____ is a single pattern that detects any flush:
s/____/Flush/p


#The following ____ pattern detects if the last 4 cards all have the same face:
s/____/Four of a kind/p


#The following ____ pattern detects if the first 4 cards have the same face:
s/____/Four of a kind/p


# Note that the input file will always be sorted based on the face. This is
# why the above only needed to check for two cases (ie, first 4 & last 4).
