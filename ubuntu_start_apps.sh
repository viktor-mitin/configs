#!/bin/sh

sleep 1

############################## run apps ###########################
google-chrome & 

(xterm -T term1)&
(xterm -T term2)&
(xterm -T term3)&
#(xterm -T term4)&

#(xterm -T term5)&
#(xterm -e 'mc')&

sleep 2
(xterm -e 'while true; do sudo htop ; done')&
#(xterm -e 'sudo htop')$

#skype&

##################### move apps to workspases ###################
sleep 3
wmctrl -r "term1"  -t0 
wmctrl -r "term2"  -t0 
wmctrl -r "term3"  -t1 
#wmctrl -r "term4"  -t1 
#wmctrl -r "term5"  -t2 

wmctrl -r "htop"   -t5 
wmctrl -r "Google" -t8 

##################### toggle fullscreen #########################
#wmctrl -r "Google Chrome" -b toggle,maximized_vert
#wmctrl -r "Google Chrome" -b toggle,maximized_horz

############################# switch to last desktop ###########
sleep 1
wmctrl -s 8


