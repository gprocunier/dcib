#!/bin/sh
# 
# example /etc/sysconfig/hugepages that assigns 40 1gb huge pages to numa
# domain 3-7 (socket0) and domain 11-15 (socket1).  This is meant to be used 
# in conjunction with isolcpus / nova cpu share groups for isolating vm workloads 
# from the os/cloud internals.  If NODE_MAP is not defined/populated it will 
# try and divide NUM_HUGEPAGES evenly across all numa domains.
# 
# ---------->8----------
# NUM_HUGEPAGES=400
# declare -a NODE_MAP
# NODE_MAP[3]=40
# NODE_MAP[4]=40
# NODE_MAP[5]=40
# NODE_MAP[6]=40
# NODE_MAP[7]=40
# NODE_MAP[11]=40
# NODE_MAP[12]=40
# NODE_MAP[13]=40
# NODE_MAP[14]=40
# NODE_MAP[15]=40
# ---------->8----------

nodes_path=/sys/devices/system/node/
if [ ! -d $nodes_path ]; then
    echo "ERROR: $nodes_path does not exist"
    exit 1
fi

reserve_pages()
{
    echo $1 > $nodes_path/$2/hugepages/hugepages-1048576kB/nr_hugepages
}

node_count=0
for i in /sys/devices/system/node/node*
do
  let node_count="$node_count +1"
done

if [[ -f /etc/sysconfig/hugepages ]]
then
  source /etc/sysconfig/hugepages

  if [[ ! -z ${NODE_MAP[@]} ]]
  then
    for node in "${!NODE_MAP[@]}"
    do
      reserve_pages ${NODE_MAP[node]} node$node
    done
  else
    if [[ ! -z $NUM_HUGEPAGES ]]
    then
      hugepage_division=$[NUM_HUGEPAGES / node_count]
      for node in ${nodes_path%\/}/node*
      do
        reserve_pages $hugepage_division ${node#$nodes_path}
      done
    fi
  fi
fi

