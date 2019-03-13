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
    echo '>>' $*
    exit 1
}


move_window ()
{
#    for i in {1..5} #bash only loop (not sh)
    for i in `seq 5`
    do
        wmctrl -r "$1" -t$2 && return 0
        sleep 1
        echo "sleeping attempt $i"
    done

	STR="ERROR: Cannot move window $1 to desktop $2"
    echo $STR #for log file output
    notify-send -t 0 $STR
}

#touch /forcefsck

############################## run apps ###########################
(xterm -T term1)&
(xterm -T term2)&
(xterm -T term3)&
(xterm -T term4)&
(xterm -T term5)&
(xterm -T term6)&
(xterm -T term7)&
(xterm -T term8)&
(xterm -T term9)&
(xterm -T term10)&
(xterm -e 'while true; do sudo htop ; done')&
#(xterm -e 'sudo htop')$

skypeforlinux&
google-chrome & 

##################### move apps to workspaces ###################
move_window term1  0
move_window term2  0 
move_window term3  1 
move_window term4  1 
move_window term5  2 
move_window term6  2 
move_window term7  3 
move_window term8  3 
move_window term9  4 
move_window term10 4 
move_window htop   5 
move_window skype  6 
move_window Google 8

##################### toggle full screen #########################
#wmctrl -r "Google Chrome" -b toggle,maximized_vert
#wmctrl -r "Google Chrome" -b toggle,maximized_horz

##################### switch to the last desktop ################
wmctrl -s 8


#sudo ifconfig enp2s0 192.168.1.1 up
#sudo iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE
#sudo service tftpd-hpa start
#sudo service nfs-kernel-server start


test -f /usr/bin/update-manager && sudo mv /usr/bin/update-manager /usr/bin/update-manager_bak
test -f /usr/bin/update-notifier && sudo mv /usr/bin/update-notifier /usr/bin/update-notifier_bak

sleep 5 
if grep -q 3489 /etc/hostname ; then  

	##### /etc/fstab #####
	### xen-troops-fs:/home/xtfs/storage/4VM /home/c/w/n   nfs    auto  0  0
	test -f "$HOME/w/n/test" || notify-send -t 0 "ERROR: NFS server (mount point ~/w/n) is NOT available"

	##### ARP configuration ########
	sudo ip link set dev eno1 arp off #disable ARP completely
	sudo ip -s -s neigh flush all #clear ARP cache
	sudo arp -f #load static entries from /etc/ethers (format: mac ip)
	#arp -s 10.0.0.2 00:0c:29:c0:94:bf

fi
