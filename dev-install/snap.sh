#!/bin/bash

[[ $(rpm -q boom-boot) ]] || (echo "install boom-boot and run with install then create to continue" && exit 1)

case $1 in
  install)
    boom profile create --from-host --uname-pattern el8
    boom create --backup --title "Root LV snapshot before changes" --rootlv rhel/pre-deploy
    grub2-mkconfig > /boot/grub2/grub.cfg
    ;;
  create)
    # based on having 1tb free in the rhel vg
    lvcreate -s rhel/root -n pre-deploy -L 1t
    ;;
  revert)
    lvconvert --merge rhel/pre-deploy
    ;;
  *)
    echo  "Usage $0 : [ create | revert | install ]"
    ;;
esac
