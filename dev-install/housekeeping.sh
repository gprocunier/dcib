#!/bin/bash
# misc housekeeping for rebuilds
# we dont have a pxe/kickstart environment so rebuilds require connecting to the lom and punting the usb 
# for the rhel 8.4 iso

subscription-manager release --set=8.4
dnf -y install tmux vim ansible git vdo
umount /home
lvchange -an /dev/rhel_rhosp-dcib/home
lvremove /dev/rhel_rhosp-dcib/home
lvresize -r -l 100%FREE /dev/rhel_rhosp-dcib/root
sed -i -e '/dcib-home/d' /etc/fstab
