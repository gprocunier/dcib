#!/bin/sh

# terribly insecure but easy!
echo benchmark | passwd --stdin root

# software
dnf -y install tmux iperf3 fio pcp-system-tools sysstat

# network tuning
cat <<_E_O_F_ >>/etc/sysctl.conf
# allow testing with buffers up to 128MB
net.core.rmem_max = 134217728 
net.core.wmem_max = 134217728 
# increase Linux autotuning TCP buffer limit to 64MB
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
# recommended for hosts with jumbo frames enabled
net.ipv4.tcp_mtu_probing=1
# recommended to enable 'fair queueing'
net.core.default_qdisc = fq

_E_O_F_
sysctl -p
