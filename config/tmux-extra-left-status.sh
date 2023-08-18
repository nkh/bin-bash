#!/bin/bash

sliders=$(/home/nadim/nadim/bin/bash/tmuxslider status)
 
if [[ $sliders == "[0]" ]] ; then
        sliders=''
else
        sliders="$sliders "
fi

side_pane=$(/home/nadim/nadim/bin/bash/tmuxake status2)

echo "$sliders$side_pane"
