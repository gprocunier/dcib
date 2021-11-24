#!/bin/sh
echo benchmark | passwd --stdin root
dnf -y install tmux iperf3 fio pcp-system-tools sysstat
cat <<_E_O_F_ >>/etc/sysctl.conf
# allow testing with buffers up to 128MB
net.core.rmem_max = 134217728 
net.core.wmem_max = 134217728 
# increase Linux autotuning TCP buffer limit to 64MB
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
# recommended default congestion control is htcp 
net.ipv4.tcp_congestion_control = bbr
# recommended for hosts with jumbo frames enabled
# net.ipv4.tcp_mtu_probing=1
# recommended to enable 'fair queueing'
net.core.default_qdisc = fq

_E_O_F_
sysctl -p

cat <<_E_O_F_ >/etc/systemd/system/fio.service
[Unit]
Description=Start fio as a server in listen mode
After=syslog.target systemd-user-sessions.service

[Service]
ExecStart=/usr/bin/fio --server
KillMode=process

[Install]
WantedBy=multi-user.target
_E_O_F_

cat <<_E_O_F_ >/etc/systemd/system/iperf3.service
[Unit]
Description=Start iperf3 as a server in listen mode
After=syslog.target systemd-user-sessions.service

[Service]
ExecStart=/usr/bin/iperf3 -s
KillMode=process

[Install]
WantedBy=multi-user.target
_E_O_F_

chown root:root /etc/systemd/system/fio.service
chown root:root /etc/systemd/system/iperf3.service
chmod 644 /etc/systemd/system/fio.service
chmod 644 /etc/systemd/system/iperf3.service
restorecon -Rv /etc/systemd/system
systemctl daemon-reload
systemctl start fio
systemctl start iperf3
