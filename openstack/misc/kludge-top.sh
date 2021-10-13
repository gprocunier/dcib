#!/bin/sh
# meant to be used as part of the cgroup testing with the bench heat stack
#
# run this from inside the nova_libvirt container as the cloud operator
#
# PS - this is deliciously kludgy but it works for me!


rm -f pids 
# adjust this to provide the domain id's from virsh list
for i in {83..113}
do
  instance=$(virsh dumpxml $i | head -10 | perl -lne 'if(/\<name\>(\S+)\<\/name\>/) { print $1 } ')
  instance_name=$(virsh dumpxml $i | head -10 | perl -lne 'if(/\<nova:name\>(\S+)\<\/nova:name\>/) { print $1 }')
  instance_pid=$( pgrep -f $instance )
  echo $instance_name $instance $instance_pid >> pids
done

echo "gold instances:"
echo "top -d 0.5 -p " $(grep gold pids  | cut -d' ' -f3 | paste -sd ",")

echo "silver instances:"
echo "top -d 0.5 -p " $(grep silver pids  | cut -d' ' -f3 | paste -sd ",")

echo "bronze instances:"
echo "top -d 0.5 -p " $(grep bronze pids  | cut -d' ' -f3 | paste -sd ",")

