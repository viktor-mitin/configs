#!/bin/sh -x

#configure 'internal' net card 
sudo ifconfig enp2s0 192.168.1.1 up
sudo iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE
sudo service tftpd-hpa start
sudo service nfs-kernel-server start

#NFS mount timing issue workaround, TBD
#sleep 12 

###### ARP configuration ########
##disable ARP completely
#sudo ip link set dev eno1 arp off
# #clear ARP cache
#sudo ip -s -s neigh flush all
##load static entries from /etc/ethers (format: mac ip)
#sudo arp -f       
##arp -s 10.0.0.2 00:0c:29:c0:94:bf

##### /etc/fstab ###############
### xen-troops-fs:/home/xtfs/storage/4VM /home/c/w/n   nfs    auto  0  0

##### /etc/fstab ###############
#/dev/sda1        /n              ext4      noatime        1      1
test -f ~/w/s/test || notify-send -t 0 "Warning: /dev/sda1 mount point is NOT available"
