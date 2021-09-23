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
[root@rhosp-dcib ansible]# ansible-playbook -i inventory.yml prep_disks.yml 

PLAY [prep devices] **************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************************************************************
ok: [localhost]

TASK [shut down cinder volume groups] ********************************************************************************************************************************************************************************************************
failed: [localhost] (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an samsung_980p_vdo", "delta": "0:00:00.033709", "end": "2021-09-23 17:45:29.880293", "item": {"key": "samsung_980p_vdo", "value": {"compression": "enabled", "deduplication": "enabled", "device": "/dev/md0", "logical_size": "20t", "vcoCpuThreads": 6, "vdoAckThreads": 6, "vdoBioThreads": 8, "vdoHashZoneThreads": 3, "vdoLogicalThreads": 8, "vdoPhysicalThreads": 6, "vdoSlabSize": "32g"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:29.846584", "stderr": "  Volume group \"samsung_980p_vdo\" not found\n  Cannot process volume group samsung_980p_vdo", "stderr_lines": ["  Volume group \"samsung_980p_vdo\" not found", "  Cannot process volume group samsung_980p_vdo"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'samsung_983e_4x_r0', 'value': {'device': '/dev/md2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an samsung_983e_4x_r0", "delta": "0:00:00.033678", "end": "2021-09-23 17:45:30.018296", "item": {"key": "samsung_983e_4x_r0", "value": {"device": "/dev/md2", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:29.984618", "stderr": "  Volume group \"samsung_983e_4x_r0\" not found\n  Cannot process volume group samsung_983e_4x_r0", "stderr_lines": ["  Volume group \"samsung_983e_4x_r0\" not found", "  Cannot process volume group samsung_983e_4x_r0"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'samsung_983e_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an samsung_983e_00", "delta": "0:00:00.034671", "end": "2021-09-23 17:45:30.156228", "item": {"key": "samsung_983e_00", "value": {"device": "/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part2", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:30.121557", "stderr": "  Volume group \"samsung_983e_00\" not found\n  Cannot process volume group samsung_983e_00", "stderr_lines": ["  Volume group \"samsung_983e_00\" not found", "  Cannot process volume group samsung_983e_00"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'samsung_983e_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an samsung_983e_01", "delta": "0:00:00.033799", "end": "2021-09-23 17:45:30.292284", "item": {"key": "samsung_983e_01", "value": {"device": "/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part2", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:30.258485", "stderr": "  Volume group \"samsung_983e_01\" not found\n  Cannot process volume group samsung_983e_01", "stderr_lines": ["  Volume group \"samsung_983e_01\" not found", "  Cannot process volume group samsung_983e_01"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'samsung_983e_02', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an samsung_983e_02", "delta": "0:00:00.035698", "end": "2021-09-23 17:45:30.430305", "item": {"key": "samsung_983e_02", "value": {"device": "/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part2", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:30.394607", "stderr": "  Volume group \"samsung_983e_02\" not found\n  Cannot process volume group samsung_983e_02", "stderr_lines": ["  Volume group \"samsung_983e_02\" not found", "  Cannot process volume group samsung_983e_02"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'samsung_983e_03', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an samsung_983e_03", "delta": "0:00:00.034076", "end": "2021-09-23 17:45:30.568286", "item": {"key": "samsung_983e_03", "value": {"device": "/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part2", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:30.534210", "stderr": "  Volume group \"samsung_983e_03\" not found\n  Cannot process volume group samsung_983e_03", "stderr_lines": ["  Volume group \"samsung_983e_03\" not found", "  Cannot process volume group samsung_983e_03"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'intel_p5800x_2x_r0', 'value': {'device': '/dev/md3', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an intel_p5800x_2x_r0", "delta": "0:00:00.034903", "end": "2021-09-23 17:45:30.707295", "item": {"key": "intel_p5800x_2x_r0", "value": {"device": "/dev/md3", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:30.672392", "stderr": "  Volume group \"intel_p5800x_2x_r0\" not found\n  Cannot process volume group intel_p5800x_2x_r0", "stderr_lines": ["  Volume group \"intel_p5800x_2x_r0\" not found", "  Cannot process volume group intel_p5800x_2x_r0"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'intel_p5800x_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an intel_p5800x_00", "delta": "0:00:00.031663", "end": "2021-09-23 17:45:30.842346", "item": {"key": "intel_p5800x_00", "value": {"device": "/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part2", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:30.810683", "stderr": "  Volume group \"intel_p5800x_00\" not found\n  Cannot process volume group intel_p5800x_00", "stderr_lines": ["  Volume group \"intel_p5800x_00\" not found", "  Cannot process volume group intel_p5800x_00"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': 'intel_p5800x_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vgchange -an intel_p5800x_01", "delta": "0:00:00.031527", "end": "2021-09-23 17:45:30.976355", "item": {"key": "intel_p5800x_01", "value": {"device": "/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part2", "pe_size": "32", "vg_options": "--alloc contiguous"}}, "msg": "non-zero return code", "rc": 5, "start": "2021-09-23 17:45:30.944828", "stderr": "  Volume group \"intel_p5800x_01\" not found\n  Cannot process volume group intel_p5800x_01", "stderr_lines": ["  Volume group \"intel_p5800x_01\" not found", "  Cannot process volume group intel_p5800x_01"], "stdout": "", "stdout_lines": []}
...ignoring

TASK [remove cinder volume groups] ***********************************************************************************************************************************************************************************************************
ok: [localhost] => (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}})
ok: [localhost] => (item={'key': 'samsung_983e_4x_r0', 'value': {'device': '/dev/md2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_02', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'samsung_983e_03', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'intel_p5800x_2x_r0', 'value': {'device': '/dev/md3', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'intel_p5800x_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
ok: [localhost] => (item={'key': 'intel_p5800x_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})

TASK [shut down pre-existing vdo sets] *******************************************************************************************************************************************************************************************************
failed: [localhost] (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "vdo remove -n samsung_980p_vdo", "delta": "0:00:00.068440", "end": "2021-09-23 17:45:32.494227", "item": {"key": "samsung_980p_vdo", "value": {"compression": "enabled", "deduplication": "enabled", "device": "/dev/md0", "logical_size": "20t", "vcoCpuThreads": 6, "vdoAckThreads": 6, "vdoBioThreads": 8, "vdoHashZoneThreads": 3, "vdoLogicalThreads": 8, "vdoPhysicalThreads": 6, "vdoSlabSize": "32g"}}, "msg": "non-zero return code", "rc": 7, "start": "2021-09-23 17:45:32.425787", "stderr": "vdo: ERROR - VDO volume samsung_980p_vdo not found", "stderr_lines": ["vdo: ERROR - VDO volume samsung_980p_vdo not found"], "stdout": "", "stdout_lines": []}
...ignoring

TASK [shut down pre-existing raid sets] ******************************************************************************************************************************************************************************************************
failed: [localhost] (item={'key': '/dev/md0', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part1', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part1', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1', '/dev/disk/by-id/nvme-eui.002538b211508b77-part1', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1', '/dev/disk/by-id/nvme-eui.002538b211508b79-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --stop /dev/md0", "delta": "0:00:00.001859", "end": "2021-09-23 17:45:32.631405", "item": {"key": "/dev/md0", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1", "/dev/disk/by-id/nvme-eui.002538b21150aa92-part1", "/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1", "/dev/disk/by-id/nvme-eui.002538b2115098b3-part1", "/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1", "/dev/disk/by-id/nvme-eui.002538b211508b77-part1", "/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1", "/dev/disk/by-id/nvme-eui.002538b211508b79-part1"], "members": 8}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:32.629546", "stderr": "mdadm: error opening /dev/md0: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md0: No such file or directory"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md1', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part2', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part2', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2', '/dev/disk/by-id/nvme-eui.002538b211508b77-part2', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2', '/dev/disk/by-id/nvme-eui.002538b211508b79-part2']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --stop /dev/md1", "delta": "0:00:00.001772", "end": "2021-09-23 17:45:32.735203", "item": {"key": "/dev/md1", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2", "/dev/disk/by-id/nvme-eui.002538b21150aa92-part2", "/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2", "/dev/disk/by-id/nvme-eui.002538b2115098b3-part2", "/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2", "/dev/disk/by-id/nvme-eui.002538b211508b77-part2", "/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2", "/dev/disk/by-id/nvme-eui.002538b211508b79-part2"], "members": 8}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:32.733431", "stderr": "mdadm: error opening /dev/md1: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md1: No such file or directory"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md2', 'value': {'members': 4, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1', '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --stop /dev/md2", "delta": "0:00:00.001585", "end": "2021-09-23 17:45:32.838768", "item": {"key": "/dev/md2", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1", "/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1", "/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1", "/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1"], "members": 4}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:32.837183", "stderr": "mdadm: error opening /dev/md2: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md2: No such file or directory"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md3', 'value': {'members': 2, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1', '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --stop /dev/md3", "delta": "0:00:00.001631", "end": "2021-09-23 17:45:32.940983", "item": {"key": "/dev/md3", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1", "/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1"], "members": 2}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:32.939352", "stderr": "mdadm: error opening /dev/md3: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md3: No such file or directory"], "stdout": "", "stdout_lines": []}
...ignoring

TASK [remove pre-existing raid sets] *********************************************************************************************************************************************************************************************************
failed: [localhost] (item={'key': '/dev/md0', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part1', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part1', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1', '/dev/disk/by-id/nvme-eui.002538b211508b77-part1', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1', '/dev/disk/by-id/nvme-eui.002538b211508b79-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --remove /dev/md0", "delta": "0:00:00.001691", "end": "2021-09-23 17:45:33.072346", "item": {"key": "/dev/md0", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1", "/dev/disk/by-id/nvme-eui.002538b21150aa92-part1", "/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1", "/dev/disk/by-id/nvme-eui.002538b2115098b3-part1", "/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1", "/dev/disk/by-id/nvme-eui.002538b211508b77-part1", "/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1", "/dev/disk/by-id/nvme-eui.002538b211508b79-part1"], "members": 8}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:33.070655", "stderr": "mdadm: error opening /dev/md0: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md0: No such file or directory"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md1', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part2', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part2', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2', '/dev/disk/by-id/nvme-eui.002538b211508b77-part2', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2', '/dev/disk/by-id/nvme-eui.002538b211508b79-part2']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --remove /dev/md1", "delta": "0:00:00.001632", "end": "2021-09-23 17:45:33.176545", "item": {"key": "/dev/md1", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2", "/dev/disk/by-id/nvme-eui.002538b21150aa92-part2", "/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2", "/dev/disk/by-id/nvme-eui.002538b2115098b3-part2", "/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2", "/dev/disk/by-id/nvme-eui.002538b211508b77-part2", "/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2", "/dev/disk/by-id/nvme-eui.002538b211508b79-part2"], "members": 8}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:33.174913", "stderr": "mdadm: error opening /dev/md1: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md1: No such file or directory"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md2', 'value': {'members': 4, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1', '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --remove /dev/md2", "delta": "0:00:00.001529", "end": "2021-09-23 17:45:33.278796", "item": {"key": "/dev/md2", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1", "/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1", "/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1", "/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1"], "members": 4}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:33.277267", "stderr": "mdadm: error opening /dev/md2: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md2: No such file or directory"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md3', 'value': {'members': 2, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1', '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --remove /dev/md3", "delta": "0:00:00.001583", "end": "2021-09-23 17:45:33.381373", "item": {"key": "/dev/md3", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1", "/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1"], "members": 2}}, "msg": "non-zero return code", "rc": 1, "start": "2021-09-23 17:45:33.379790", "stderr": "mdadm: error opening /dev/md3: No such file or directory", "stderr_lines": ["mdadm: error opening /dev/md3: No such file or directory"], "stdout": "", "stdout_lines": []}
...ignoring

TASK [zero superblocks] **********************************************************************************************************************************************************************************************************************
failed: [localhost] (item={'key': '/dev/md0', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part1', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part1', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1', '/dev/disk/by-id/nvme-eui.002538b211508b77-part1', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1', '/dev/disk/by-id/nvme-eui.002538b211508b79-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --zero-superblock /dev/disk/by-id/nvme-eui.002538b11150b8c8-part1 /dev/disk/by-id/nvme-eui.002538b21150aa92-part1 /dev/disk/by-id/nvme-eui.002538b11150b8c9-part1 /dev/disk/by-id/nvme-eui.002538b2115098b3-part1 /dev/disk/by-id/nvme-eui.002538b11150c7b6-part1 /dev/disk/by-id/nvme-eui.002538b211508b77-part1 /dev/disk/by-id/nvme-eui.002538b11150b7c8-part1 /dev/disk/by-id/nvme-eui.002538b211508b79-part1", "delta": "0:00:00.001570", "end": "2021-09-23 17:45:33.510923", "item": {"key": "/dev/md0", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1", "/dev/disk/by-id/nvme-eui.002538b21150aa92-part1", "/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1", "/dev/disk/by-id/nvme-eui.002538b2115098b3-part1", "/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1", "/dev/disk/by-id/nvme-eui.002538b211508b77-part1", "/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1", "/dev/disk/by-id/nvme-eui.002538b211508b79-part1"], "members": 8}}, "msg": "non-zero return code", "rc": 2, "start": "2021-09-23 17:45:33.509353", "stderr": "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c8-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b21150aa92-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c9-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b2115098b3-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150c7b6-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b77-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b7c8-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b79-part1 for write - not zeroing", "stderr_lines": ["mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c8-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b21150aa92-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c9-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b2115098b3-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150c7b6-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b77-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b7c8-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b79-part1 for write - not zeroing"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md1', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part2', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part2', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2', '/dev/disk/by-id/nvme-eui.002538b211508b77-part2', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2', '/dev/disk/by-id/nvme-eui.002538b211508b79-part2']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --zero-superblock /dev/disk/by-id/nvme-eui.002538b11150b8c8-part2 /dev/disk/by-id/nvme-eui.002538b21150aa92-part2 /dev/disk/by-id/nvme-eui.002538b11150b8c9-part2 /dev/disk/by-id/nvme-eui.002538b2115098b3-part2 /dev/disk/by-id/nvme-eui.002538b11150c7b6-part2 /dev/disk/by-id/nvme-eui.002538b211508b77-part2 /dev/disk/by-id/nvme-eui.002538b11150b7c8-part2 /dev/disk/by-id/nvme-eui.002538b211508b79-part2", "delta": "0:00:00.001652", "end": "2021-09-23 17:45:33.613795", "item": {"key": "/dev/md1", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2", "/dev/disk/by-id/nvme-eui.002538b21150aa92-part2", "/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2", "/dev/disk/by-id/nvme-eui.002538b2115098b3-part2", "/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2", "/dev/disk/by-id/nvme-eui.002538b211508b77-part2", "/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2", "/dev/disk/by-id/nvme-eui.002538b211508b79-part2"], "members": 8}}, "msg": "non-zero return code", "rc": 2, "start": "2021-09-23 17:45:33.612143", "stderr": "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c8-part2 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b21150aa92-part2 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c9-part2 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b2115098b3-part2 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150c7b6-part2 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b77-part2 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b7c8-part2 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b79-part2 for write - not zeroing", "stderr_lines": ["mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c8-part2 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b21150aa92-part2 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b8c9-part2 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b2115098b3-part2 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150c7b6-part2 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b77-part2 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b11150b7c8-part2 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.002538b211508b79-part2 for write - not zeroing"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md2', 'value': {'members': 4, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1', '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --zero-superblock /dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1 /dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1 /dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1 /dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1", "delta": "0:00:00.001581", "end": "2021-09-23 17:45:33.715903", "item": {"key": "/dev/md2", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1", "/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1", "/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1", "/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1"], "members": 4}}, "msg": "non-zero return code", "rc": 2, "start": "2021-09-23 17:45:33.714322", "stderr": "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1 for write - not zeroing", "stderr_lines": ["mdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1 for write - not zeroing"], "stdout": "", "stdout_lines": []}
failed: [localhost] (item={'key': '/dev/md3', 'value': {'members': 2, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1', '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1']}}) => {"ansible_loop_var": "item", "changed": true, "cmd": "/usr/sbin/mdadm --zero-superblock /dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1 /dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1", "delta": "0:00:00.001716", "end": "2021-09-23 17:45:33.818167", "item": {"key": "/dev/md3", "value": {"chunk": 512, "devices": ["/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1", "/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1"], "members": 2}}, "msg": "non-zero return code", "rc": 2, "start": "2021-09-23 17:45:33.816451", "stderr": "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1 for write - not zeroing\nmdadm: Couldn't open /dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1 for write - not zeroing", "stderr_lines": ["mdadm: Couldn't open /dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1 for write - not zeroing", "mdadm: Couldn't open /dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1 for write - not zeroing"], "stdout": "", "stdout_lines": []}
...ignoring

TASK [wipe devs] *****************************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b11150b8c8', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b21150aa92', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b11150b8c9', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b2115098b3', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b11150c7b6', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b211508b77', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b11150b7c8', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.002538b211508b79', 'table': [{'size': '512GiB', 'raid': '/dev/md0'}, {'size': 'remain', 'raid': '/dev/md1'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003', 'table': [{'size': '1024GiB', 'raid': '/dev/md2'}, {'size': 'remain', 'raid': 'none'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003', 'table': [{'size': '1024GiB', 'raid': '/dev/md2'}, {'size': 'remain', 'raid': 'none'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004', 'table': [{'size': '1024GiB', 'raid': '/dev/md2'}, {'size': 'remain', 'raid': 'none'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004', 'table': [{'size': '1024GiB', 'raid': '/dev/md2'}, {'size': 'remain', 'raid': 'none'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351', 'table': [{'size': '256GiB', 'raid': '/dev/md3'}, {'size': 'remain', 'raid': 'none'}]})
changed: [localhost] => (item={'path': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351', 'table': [{'size': '256GiB', 'raid': '/dev/md3'}, {'size': 'remain', 'raid': 'none'}]})

TASK [create partition schema for samsung_980p_1tb devices] **********************************************************************************************************************************************************************************
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost

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
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '1024GiB', 'raid': '/dev/md2'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '1024GiB', 'raid': '/dev/md2'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '1024GiB', 'raid': '/dev/md2'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '1024GiB', 'raid': '/dev/md2'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition schema for intel_optane_p5800x devices] *******************************************************************************************************************************************************************************
included: /root/ansible/task_create_table.yml for localhost
included: /root/ansible/task_create_table.yml for localhost

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '256GiB', 'raid': '/dev/md3'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create partition] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'size': '256GiB', 'raid': '/dev/md3'})
changed: [localhost] => (item={'size': 'remain', 'raid': 'none'})

TASK [create raid sets] **********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': '/dev/md0', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part1', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part1', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part1', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part1', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part1', '/dev/disk/by-id/nvme-eui.002538b211508b77-part1', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part1', '/dev/disk/by-id/nvme-eui.002538b211508b79-part1']}})
changed: [localhost] => (item={'key': '/dev/md1', 'value': {'members': 8, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.002538b11150b8c8-part2', '/dev/disk/by-id/nvme-eui.002538b21150aa92-part2', '/dev/disk/by-id/nvme-eui.002538b11150b8c9-part2', '/dev/disk/by-id/nvme-eui.002538b2115098b3-part2', '/dev/disk/by-id/nvme-eui.002538b11150c7b6-part2', '/dev/disk/by-id/nvme-eui.002538b211508b77-part2', '/dev/disk/by-id/nvme-eui.002538b11150b7c8-part2', '/dev/disk/by-id/nvme-eui.002538b211508b79-part2']}})
changed: [localhost] => (item={'key': '/dev/md2', 'value': {'members': 4, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part1', '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part1', '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part1']}})
changed: [localhost] => (item={'key': '/dev/md3', 'value': {'members': 2, 'chunk': 512, 'devices': ['/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part1', '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part1']}})

TASK [create vdo sets] ***********************************************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}})

TASK [attach vdo-lvm for consumption by cinder] **********************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': 'samsung_980p_vdo', 'value': {'device': '/dev/md0', 'logical_size': '20t', 'compression': 'enabled', 'deduplication': 'enabled', 'vdoLogicalThreads': 8, 'vdoPhysicalThreads': 6, 'vcoCpuThreads': 6, 'vdoHashZoneThreads': 3, 'vdoAckThreads': 6, 'vdoBioThreads': 8, 'vdoSlabSize': '32g'}})

TASK [attach standard lvm for consumption by cinder] *****************************************************************************************************************************************************************************************
changed: [localhost] => (item={'key': 'samsung_983e_4x_r0', 'value': {'device': '/dev/md2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9172650025384100000003-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304e9166570025384100000003-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_02', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223120025384100000004-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'samsung_983e_03', 'value': {'device': '/dev/disk/by-id/nvme-eui.343336304d8223100025384100000004-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'intel_p5800x_2x_r0', 'value': {'device': '/dev/md3', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'intel_p5800x_00', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e41f893b5351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})
changed: [localhost] => (item={'key': 'intel_p5800x_01', 'value': {'device': '/dev/disk/by-id/nvme-eui.01000000000000005cd2e49227155351-part2', 'pe_size': '32', 'vg_options': '--alloc contiguous'}})

PLAY RECAP ***********************************************************************************************************************************************************************************************************************************
localhost                  : ok=40   changed=24   unreachable=0    failed=0    skipped=0    rescued=0    ignored=5  
```

# Post Config
```
[root@rhosp-dcib ansible]# lsblk -o MODEL,NAME,SIZE
MODEL                                    NAME                     SIZE
MKNSSDGA2TB-D8                           nvme14n1                 1.8T
                                         ├─nvme14n1p1               1M
                                         ├─nvme14n1p2             513M
                                         ├─nvme14n1p3               1G
                                         └─nvme14n1p4             1.7T
                                           ├─rhel-root            1.7T
                                           └─rhel-swap              4G
SAMSUNG MZ1LB1T9HALS-00007               nvme10n1                 1.8T
                                         ├─nvme10n1p2           764.5G
                                         └─nvme10n1p1            1024G
                                           └─md2                    4T
SAMSUNG MZ1LB1T9HALS-00007               nvme13n1                 1.8T
                                         ├─nvme13n1p2           764.5G
                                         └─nvme13n1p1            1024G
                                           └─md2                    4T
SAMSUNG MZ1LB1T9HALS-00007               nvme12n1                 1.8T
                                         ├─nvme12n1p1            1024G
                                         │ └─md2                    4T
                                         └─nvme12n1p2           764.5G
SAMSUNG MZ1LB1T9HALS-00007               nvme11n1                 1.8T
                                         ├─nvme11n1p1            1024G
                                         │ └─md2                    4T
                                         └─nvme11n1p2           764.5G
INTEL SSDPF21Q800GB                      nvme8n1                745.2G
                                         ├─nvme8n1p1              256G
                                         │ └─md3                511.8G
                                         └─nvme8n1p2            489.2G
INTEL SSDPF21Q800GB                      nvme9n1                745.2G
                                         ├─nvme9n1p1              256G
                                         │ └─md3                511.8G
                                         └─nvme9n1p2            489.2G
Samsung SSD 980 PRO 1TB                  nvme3n1                931.5G
                                         ├─nvme3n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme3n1p2            419.5G
                                           └─md1                  3.3T
Samsung SSD 980 PRO 1TB                  nvme4n1                931.5G
                                         ├─nvme4n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme4n1p2            419.5G
                                           └─md1                  3.3T
Samsung SSD 980 PRO 1TB                  nvme0n1                931.5G
                                         ├─nvme0n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme0n1p2            419.5G
                                           └─md1                  3.3T
Samsung SSD 980 PRO 1TB                  nvme2n1                931.5G
                                         ├─nvme2n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme2n1p2            419.5G
                                           └─md1                  3.3T
Samsung SSD 980 PRO 1TB                  nvme6n1                931.5G
                                         ├─nvme6n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme6n1p2            419.5G
                                           └─md1                  3.3T
Samsung SSD 980 PRO 1TB                  nvme7n1                931.5G
                                         ├─nvme7n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme7n1p2            419.5G
                                           └─md1                  3.3T
Samsung SSD 980 PRO 1TB                  nvme5n1                931.5G
                                         ├─nvme5n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme5n1p2            419.5G
                                           └─md1                  3.3T
Samsung SSD 980 PRO 1TB                  nvme1n1                931.5G
                                         ├─nvme1n1p1              512G
                                         │ └─md0                    4T
                                         │   └─samsung_980p_vdo    20T
                                         └─nvme1n1p2            419.5G
                                           └─md1                  3.3T
```
