#!/bin/sh -x

#send stdout to the log file
exec > /tmp/start_apps.log
#redirect stderr to stdout
exec 2>&1

date

#set default brightness value
echo 10000 | sudo tee /sys/class/backlight/intel_backlight/brightness

move_window ()
{
    for i in $(seq 25); do    # for i in {1..5} #bash only loop (not sh)
        wmctrl -r "$1" -t"$2" && return 0
        sleep 1
        echo "Sleep for 1 second, attempt #$i"
    done

	STR="ERROR: Cannot move window $1 to desktop $2"
    echo "$STR" #for log file output
    notify-send -t 0 "$STR"  # sudo apt-get --reinstall install libnotify-bin notify-osd
}

#touch /forcefsck

############################## run apps ###########################
google-chrome &
skypeforlinux&
#firefox &
telegram-desktop &
/opt/viber/Viber &

(nice -n 10 xterm -T term1)&
(nice -n 11 xterm -T term2)&
(nice -n 12 xterm -T term3)&
(nice -n 13 xterm -T term4)&
(nice -n 14 xterm -T term5)&
(nice -n 15 xterm -T term6)&
(nice -n 16 xterm -T term7)&
(nice -n 17 xterm -T term8)&
#(nice -n 18 xterm -T term9)&
#(nice -n 19 xterm -T term10)&
(nice -n 9 xterm -T term11 -e 'ping google.com')&
(nice -n  9 xterm -e 'while true; do sudo htop ; done')&

##################### move apps to workspaces ###################
move_window term1  0
move_window term2  0
move_window term3  1
move_window term4  1
move_window term5  2
move_window term6  2
move_window term7  3
move_window term8  3
#move_window term9  4
move_window term11 4
move_window htop   5
move_window skype  6
#move_window firefox 7
move_window Telegram  7
move_window Viber  7
move_window "Google Chrome" 8

##################### switch to the last desktop ################
wmctrl -s 8

test -f /usr/bin/update-manager && sudo mv /usr/bin/update-manager /usr/bin/update-manager_bak
test -f /usr/bin/update-notifier && sudo mv /usr/bin/update-notifier /usr/bin/update-notifier_bak

#run hosts specific applications or configuration
grep -q 3489 /etc/hostname && ~/configs/host_3489_start_apps.sh


#################################################################
#Lxde logout after config modification to test the script
#
# pkill -SIGTERM -f lxsession   #lubuntu
# pkill xfce4-session # xubuntu
