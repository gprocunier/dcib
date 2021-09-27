#!/bin/bash

case $1 in
  install)
    boom profile create --from-host --uname-pattern el8
    boom create --backup --title "Root LV snapshot before changes" --rootlv rhel_rhosp-dcib/pre-deploy
    grub2-mkconfig > /boot/grub2/grub.cfg
  create)
    lvcreate -s rhel_rhosp-dcib/root -n pre-deploy -L 1t
    ;;
  revert)
    lvconvert --merge rhel_rhosp-dcib/pre-deploy
    ;;
  *)
    echo  "Usage $0 : [ create | revert | install ]"
    ;;
esac
