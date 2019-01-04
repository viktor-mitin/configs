#!/bin/sh

sleep 1
#touch /forcefsck

############################## run apps ###########################
google-chrome & 

(xterm -T term1)&
(xterm -T term2)&
(xterm -T term3)&
(xterm -T term4)&
(xterm -T term5)&
(xterm -T term6)&

sleep 1
(xterm -e 'while true; do sudo htop ; done')&
#(xterm -e 'sudo htop')$

#skype&

##################### move apps to workspases ###################
sleep 3
wmctrl -r "term1"  -t0 
wmctrl -r "term2"  -t0 
wmctrl -r "term3"  -t1 
wmctrl -r "term4"  -t1 
wmctrl -r "term5"  -t2 
wmctrl -r "term6"  -t2 

wmctrl -r "htop"   -t5 
wmctrl -r "skype"  -t6 
wmctrl -r "Google" -t8 

##################### toggle fullscreen #########################
#wmctrl -r "Google Chrome" -b toggle,maximized_vert
#wmctrl -r "Google Chrome" -b toggle,maximized_horz

############################# switch to last desktop ###########
sleep 1
wmctrl -s 8



sudo ifconfig enp2s0 192.168.1.1 up
sudo iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE
sudo service tftpd-hpa start
sudo service nfs-kernel-server start

