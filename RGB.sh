#!/bin/sh

RED_PATH="/sys/class/leds/LED0_Red"
GREEN_PATH="/sys/class/leds/LED0_Green"
BLUE_PATH="/sys/class/leds/LED0_Blue"

DELAY_STEP="1"  
DELAY="100"  

while true
do
    for j in $(seq 0 $DELAY_STEP 765)
    do
        if [ $j -le 255 ]; then
            r=$j
            g=0
            b=$((255 - j))
        elif [ $j -le 511 ]; then
            r=$((511 - j))
            g=$((j - 256))
            b=0
        else
            r=0
            g=$((767 - j))
            b=$((j - 512))
        fi

        echo $r > $RED_PATH/brightness
        echo $g > $GREEN_PATH/brightness
        echo $b > $BLUE_PATH/brightness

        sleep $((DELAY_STEP / 1000))
    done

    sleep $((DELAY / 1000))
done
