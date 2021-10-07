#!/bin/sh

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

  if [[ ! -z $NUM_HUGEPAGES ]]
  then
    hugepage_division=$[NUM_HUGEPAGES / node_count]
    for node in ${nodes_path%\/}/node*
    do
      reserve_pages $hugepage_division ${node#$nodes_path}
    done
  fi
fi
