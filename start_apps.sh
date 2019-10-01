#!/bin/sh -x

#send stdout to the log file
exec > /tmp/start_apps.log
#redirect stderr to stdout
exec 2>&1

date

#set -eu

die ()
{
    echo '>> ERROR:'
    echo '>>' "$*"
    exit 1
}


move_window ()
{
#    for i in {1..5} #bash only loop (not sh)
    for i in $(seq 25)
    do
        wmctrl -r "$1" -t"$2" && return 0
        sleep 1
        echo "Sleep for 1 second, attempt #$i"
    done

	STR="ERROR: Cannot move window $1 to desktop $2"
    echo "$STR" #for log file output
    notify-send -t 0 "$STR"
}

#touch /forcefsck

############################## run apps ###########################
skypeforlinux&

#Lubuntu 18.04 has bug with Xserver+xterm:
#Sometimes xterm windows cannot switch to full screen mode after startup
#The next sleep overcomes the issue. TBD
sleep 3

(nice -n 10 xterm -T term1)&
(nice -n 11 xterm -T term2)&
(nice -n 12 xterm -T term3)&
(nice -n 13 xterm -T term4)&
(nice -n 14 xterm -T term5)&
(nice -n 15 xterm -T term6)&
#(nice -n 16 xterm -T term7)&
#(nice -n 17 xterm -T term8)&
#(nice -n 18 xterm -T term9)&
#(nice -n 19 xterm -T term10)&
(nice -n 9 xterm -T term11 -e 'ping google.com')&
(nice -n  9 xterm -e 'while true; do sudo htop ; done')&
#(xterm -e 'sudo htop')$

firefox &
google-chrome &
/opt/telegram/telegram &

##################### move apps to workspaces ###################
move_window term1  0
move_window term2  0
move_window term3  1
move_window term4  1
move_window term5  2
move_window term6  2
#move_window term7  3
#move_window term8  3
move_window Telegram  3
#move_window term9  4
move_window term11 4
move_window htop   5
move_window skype  6
move_window firefox 7
move_window Google 8

##################### toggle full screen #########################
#wmctrl -r "Google Chrome" -b toggle,maximized_vert
#wmctrl -r "Google Chrome" -b toggle,maximized_horz

##################### switch to the last desktop ################
wmctrl -s 8

test -f /usr/bin/update-manager && sudo mv /usr/bin/update-manager /usr/bin/update-manager_bak
test -f /usr/bin/update-notifier && sudo mv /usr/bin/update-notifier /usr/bin/update-notifier_bak

#run hosts specific applications or configuration
if grep -q 3489 /etc/hostname ; then
	~/configs/host_3489_start_apps.sh
fi


#################################################################
#Lxde logout after config modification
#Allows to test the script after the updates
#
# pkill -SIGTERM -f lxsession
