# We want this ..

![](https://raw.githubusercontent.com/gprocunier/dcib/main/ansible/disk_prep/storage_layout.png)
# From Clean

```
[root@rhosp-dcib ansible]# lsblk -o MODEL,NAME,SIZE
MODEL                                    NAME            SIZE
MKNSSDGA2TB-D8                           nvme14n1        1.8T
                                         ├─nvme14n1p1      1M
                                         ├─nvme14n1p2    513M
                                         ├─nvme14n1p3      1G
                                         └─nvme14n1p4    1.7T
                                           ├─rhel-root   1.7T
                                           └─rhel-swap     4G
SAMSUNG MZ1LB1T9HALS-00007               nvme10n1        1.8T
SAMSUNG MZ1LB1T9HALS-00007               nvme13n1        1.8T
SAMSUNG MZ1LB1T9HALS-00007               nvme12n1        1.8T
SAMSUNG MZ1LB1T9HALS-00007               nvme11n1        1.8T
INTEL SSDPF21Q800GB                      nvme8n1       745.2G
INTEL SSDPF21Q800GB                      nvme9n1       745.2G
Samsung SSD 980 PRO 1TB                  nvme3n1       931.5G
Samsung SSD 980 PRO 1TB                  nvme4n1       931.5G
Samsung SSD 980 PRO 1TB                  nvme0n1       931.5G
Samsung SSD 980 PRO 1TB                  nvme2n1       931.5G
Samsung SSD 980 PRO 1TB                  nvme6n1       931.5G
Samsung SSD 980 PRO 1TB                  nvme7n1       931.5G
Samsung SSD 980 PRO 1TB                  nvme5n1       931.5G
Samsung SSD 980 PRO 1TB                  nvme1n1       931.5G
```

# Ansible doin the things..
```
# ansible-playbook -i inventory.yml prep_disks.yaml

PLAY [prep devices] **************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************************************
ok: [localhost]

TASK [shut down cinder volume groups] ********************************************************************************************************************************************************************************************************
...ignoring

TASK [shut down pre-existing vdo sets] *******************************************************************************************************************************************************************************************************
...ignoring

TASK [deactivate and remove lvs] *************************************************************************************************************************************************************************************************************
...ignoring

TASK [remove cinder volume groups] ***********************************************************************************************************************************************************************************************************
ok: [localhost] => (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}})
ok: [localhost] => (item={'key': 'samsung_980p_8x_r0', 'value': {'device': '/dev/md1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_02', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_03', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'intel_p5800x_2x_r0', 'value': {'device': '/dev/md2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'intel_p5800x_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'intel_p5800x_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})

TASK [shut down pre-existing raid sets] ******************************************************************************************************************************************************************************************************
...ignoring

TASK [remove pre-existing raid sets] *********************************************************************************************************************************************************************************************************
...ignoring

TASK [zero superblocks] **********************************************************************************************************************************************************************************************************************
...ignoring

TASK [remove lvm signature from pvs] *********************************************************************************************************************************************************************************************************
...ignoring

TASK [create partition schema for samsung_980p_1tb devices] **********************************************************************************************************************************************************************************
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '512GiB', 'raid': '/dev/md0'})
changed: [localhost] => (item={'size': 'remain', 'raid': '/dev/md1'})

TASK [create partition schema for samsung_983e_2tb devices] **********************************************************************************************************************************************************************************
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition schema for intel_optane_p5800x devices] *******************************************************************************************************************************************************************************
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost
included: /root/dcib/ansible/disk_prep/task_create_table.yml for localhost

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '256GiB', 'raid': '/dev/md2'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '256GiB', 'raid': '/dev/md2'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create raid sets] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': '/dev/md0', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part1', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part1', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1', '/dev/disk/by-id/nvme-eui.002538b211508b77-part1', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1', '/dev/disk/by-id/nvme-eui.002538b211508b79-part1']}})
changed: [localhost] => (item={'key': '/dev/md1', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part2', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part2', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2', '/dev/disk/by-id/nvme-eui.002538b211508b77-part2', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2', '/dev/disk/by-id/nvme-eui.002538b211508b79-part2']}})
changed: [localhost] => (item={'key': '/dev/md2', 'value': {'members': 2, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1', '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1']}})

TASK [create vdo sets] ***********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}})

TASK [attach vdo-lvm for consumption by cinder] **********************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}})

TASK [attach standard lvm for consumption by cinder] *****************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': 'samsung_980p_8x_r0', 'value': {'device': '/dev/md1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_02', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_03', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'intel_p5800x_2x_r0', 'value': {'device': '/dev/md2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'intel_p5800x_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'intel_p5800x_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})

TASK [crete ceph volumes] ********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': 'ceph-osd-0', 'value': {'vg': 'samsung_983e_00', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-1', 'value': {'vg': 'samsung_983e_00', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-2', 'value': {'vg': 'samsung_983e_01', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-3', 'value': {'vg': 'samsung_983e_01', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-4', 'value': {'vg': 'samsung_983e_02', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-5', 'value': {'vg': 'samsung_983e_02', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-6', 'value': {'vg': 'samsung_983e_03', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-7', 'value': {'vg': 'samsung_983e_03', 'size': '850g'}})
changed: [localhost] => (item={'key': 'ceph-osd-0-db', 'value': {'vg': 'intel_p5800x_00', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-1-db', 'value': {'vg': 'intel_p5800x_00', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-2-db', 'value': {'vg': 'intel_p5800x_00', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-3-db', 'value': {'vg': 'intel_p5800x_00', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-4-db', 'value': {'vg': 'intel_p5800x_01', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-5-db', 'value': {'vg': 'intel_p5800x_01', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-6-db', 'value': {'vg': 'intel_p5800x_01', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-7-db', 'value': {'vg': 'intel_p5800x_01', 'size': '40g'}})
changed: [localhost] => (item={'key': 'ceph-osd-0-wal', 'value': {'vg': 'intel_p5800x_00', 'size': '10g'}})
changed: [localhost] => (item={'key': 'ceph-osd-1-wal', 'value': {'vg': 'intel_p5800x_00', 'size': '10g'}})
changed: [localhost] => (item={'key': 'ceph-osd-2-wal', 'value': {'vg': 'intel_p5800x_00', 'size': '10g'}})
changed: [localhost] => (item={'key': 'ceph-osd-3-wal', 'value': {'vg': 'intel_p5800x_00', 'size': '10g'}})
changed: [localhost] => (item={'key': 'ceph-osd-4-wal', 'value': {'vg': 'intel_p5800x_01', 'size': '10g'}})
changed: [localhost] => (item={'key': 'ceph-osd-5-wal', 'value': {'vg': 'intel_p5800x_01', 'size': '10g'}})
changed: [localhost] => (item={'key': 'ceph-osd-6-wal', 'value': {'vg': 'intel_p5800x_01', 'size': '10g'}})
changed: [localhost] => (item={'key': 'ceph-osd-7-wal', 'value': {'vg': 'intel_p5800x_01', 'size': '10g'}})

PLAY RECAP ***********************************************************************************************************************************************************************************************************************************
localhost                  : ok=42   changed=26   unreachable=0    failed=0    skipped=0    rescued=0    ignored=7
```

# Post Config
```

[root@rhosp-dcib disk_prep]# lsblk -o MODEL,NAME,SIZE
MODEL                                    NAME                                    SIZE
MKNSSDGA2TB-D8                           nvme14n1                                1.8T
                                         ├─nvme14n1p1                            600M
                                         ├─nvme14n1p2                              1G
                                         └─nvme14n1p3                            1.8T
                                           ├─rhel-swap                             4G
                                           ├─rhel-root-real                      256G
                                           │ ├─rhel-root                         256G
                                           │ └─rhel-pre--deploy                  256G
                                           └─rhel-pre--deploy-cow                257G
                                             └─rhel-pre--deploy                  256G
SAMSUNG MZ1LB1T9HALS-00007               nvme11n1                                1.8T
                                         └─nvme11n1p1                            1.8T
                                           ├─samsung_983e_01-ceph--osd--2        850G
                                           └─samsung_983e_01-ceph--osd--3        850G
SAMSUNG MZ1LB1T9HALS-00007               nvme10n1                                1.8T
                                         └─nvme10n1p1                            1.8T
                                           ├─samsung_983e_00-ceph--osd--0        850G
                                           └─samsung_983e_00-ceph--osd--1        850G
SAMSUNG MZ1LB1T9HALS-00007               nvme13n1                                1.8T
                                         └─nvme13n1p1                            1.8T
                                           ├─samsung_983e_03-ceph--osd--6        850G
                                           └─samsung_983e_03-ceph--osd--7        850G
SAMSUNG MZ1LB1T9HALS-00007               nvme12n1                                1.8T
                                         └─nvme12n1p1                            1.8T
                                           ├─samsung_983e_02-ceph--osd--4        850G
                                           └─samsung_983e_02-ceph--osd--5        850G
INTEL SSDPF21Q800GB                      nvme8n1                               745.2G
                                         ├─nvme8n1p2                           489.2G
                                         │ ├─intel_p5800x_00-ceph--osd--0--db     40G
                                         │ ├─intel_p5800x_00-ceph--osd--1--db     40G
                                         │ ├─intel_p5800x_00-ceph--osd--2--db     40G
                                         │ ├─intel_p5800x_00-ceph--osd--3--db     40G
                                         │ ├─intel_p5800x_00-ceph--osd--0--wal    10G
                                         │ ├─intel_p5800x_00-ceph--osd--1--wal    10G
                                         │ ├─intel_p5800x_00-ceph--osd--2--wal    10G
                                         │ └─intel_p5800x_00-ceph--osd--3--wal    10G
                                         └─nvme8n1p1                             256G
                                           └─md2                               511.8G
INTEL SSDPF21Q800GB                      nvme9n1                               745.2G
                                         ├─nvme9n1p2                           489.2G
                                         │ ├─intel_p5800x_01-ceph--osd--4--db     40G
                                         │ ├─intel_p5800x_01-ceph--osd--5--db     40G
                                         │ ├─intel_p5800x_01-ceph--osd--6--db     40G
                                         │ ├─intel_p5800x_01-ceph--osd--7--db     40G
                                         │ ├─intel_p5800x_01-ceph--osd--4--wal    10G
                                         │ ├─intel_p5800x_01-ceph--osd--5--wal    10G
                                         │ ├─intel_p5800x_01-ceph--osd--6--wal    10G
                                         │ └─intel_p5800x_01-ceph--osd--7--wal    10G
                                         └─nvme9n1p1                             256G
                                           └─md2                               511.8G
Samsung SSD 980 PRO 1TB                  nvme4n1                               931.5G
                                         ├─nvme4n1p1                             512G
                                         │ └─md0                                   4T
                                         │   └─samsung_980p_vdo                   20T
                                         └─nvme4n1p2                           419.5G
                                           └─md1                                 3.3T
Samsung SSD 980 PRO 1TB                  nvme3n1                               931.5G
                                         ├─nvme3n1p1                             512G
                                         │ └─md0                                   4T
                                         │   └─samsung_980p_vdo                   20T
                                         └─nvme3n1p2                           419.5G
                                           └─md1                                 3.3T
Samsung SSD 980 PRO 1TB                  nvme5n1                               931.5G
                                         ├─nvme5n1p1                             512G
                                         │ └─md0                                   4T
                                         │   └─samsung_980p_vdo                   20T
                                         └─nvme5n1p2                           419.5G
                                           └─md1                                 3.3T
Samsung SSD 980 PRO 1TB                  nvme1n1                               931.5G
                                         ├─nvme1n1p2                           419.5G
                                         │ └─md1                                 3.3T
                                         └─nvme1n1p1                             512G
                                           └─md0                                   4T
                                             └─samsung_980p_vdo                   20T
Samsung SSD 980 PRO 1TB                  nvme7n1                               931.5G
                                         ├─nvme7n1p1                             512G
                                         │ └─md0                                   4T
                                         │   └─samsung_980p_vdo                   20T
                                         └─nvme7n1p2                           419.5G
                                           └─md1                                 3.3T
Samsung SSD 980 PRO 1TB                  nvme2n1                               931.5G
                                         ├─nvme2n1p1                             512G
                                         │ └─md0                                   4T
                                         │   └─samsung_980p_vdo                   20T
                                         └─nvme2n1p2                           419.5G
                                           └─md1                                 3.3T
Samsung SSD 980 PRO 1TB                  nvme6n1                               931.5G
                                         ├─nvme6n1p1                             512G
                                         │ └─md0                                   4T
                                         │   └─samsung_980p_vdo                   20T
                                         └─nvme6n1p2                           419.5G
                                           └─md1                                 3.3T
Samsung SSD 980 PRO 1TB                  nvme0n1                               931.5G
                                         ├─nvme0n1p1                             512G
                                         │ └─md0                                   4T
                                         │   └─samsung_980p_vdo                   20T
                                         └─nvme0n1p2                           419.5G
                                           └─md1                                 3.3T

```
