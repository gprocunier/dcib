Using LVM as a storage backend requires an iscsi target service.
In Centos Stream/RHEL 8 we removed the legacy scsi-target-utils (tgtd) and replaced it with targetcli (lio).

1. Install targetcli in the host (dnf install targetcli)
2. Configure your lvm backends to use lio by setting target_helper
```
[stripe-vdo]
volume_backend_name=vdo
volume_driver=cinder.volume.drivers.lvm.LVMVolumeDriver
volume_group=stripe-vdo
backend_host=hostgroup
target_helper = lioadm <<<< this guy
volume_clear = zero
volume_clear_size = 1024
```
3. Update the pacemaker managed container for the cinder-volume service to use the host external /etc/target folder for storing the target configuration.  This will allow the iscsi configuration that occurs during cinder runtime to persist reboots and container updates.

```
# pcs resource disable openstack-cinder-volume
<wait a moment>
# pcs resource bundle update openstack-cinder-volume storage-map add id=cinder-volume-etc-target options=rw source-dir=/etc/target target-dir=/etc/target
# pcs resource enable openstack-cinder-volume
```

We can confirm this works by inspecting the running container for "-v /etc/target:/etc/target:rw" :

```
# echo -n $(podman inspect openstack-cinder-volume-podman-0 | jq -r '.[].Config.CreateCommand[]')
podman run -d --name=openstack-cinder-volume-podman-0 -e PCMK_stderr=1 --net=host -e PCMK_remote_port=3121 -v /etc/hosts:/etc/hosts:ro -v /etc/localtime:/etc/localtime:ro -v /etc/pki/ca-trust/extracted:/etc/pki/ca-trust/extracted:ro -v /etc/pki/ca-trust/source/anchors:/etc/pki/ca-trust/source/anchors:ro -v /etc/pki/tls/certs/ca-bundle.crt:/etc/pki/tls/certs/ca-bundle.crt:ro -v /etc/pki/tls/certs/ca-bundle.trust.crt:/etc/pki/tls/certs/ca-bundle.trust.crt:ro -v /etc/pki/tls/cert.pem:/etc/pki/tls/cert.pem:ro -v /dev/log:/dev/log:rw -v /etc/puppet:/etc/puppet:ro -v /var/lib/config-data/puppet-generated/cinder:/var/lib/kolla/config_files/src:ro -v /var/log/containers/cinder:/var/log/cinder:z -v /var/lib/kolla/config_files/cinder_volume.json:/var/lib/kolla/config_files/config.json:ro -v /etc/iscsi:/var/lib/kolla/config_files/src-iscsid:ro -v /etc/ceph:/var/lib/kolla/config_files/src-ceph:ro -v /lib/modules:/lib/modules:ro -v /dev/:/dev/:rw -v /run/:/run/:rw -v /sys:/sys:rw -v /var/lib/cinder:/var/lib/cinder:z -v /var/lib/iscsi:/var/lib/iscsi:z -v /etc/target:/etc/target:rw --ipc=host --privileged=true --user=root --log-driver=k8s-file --log-opt path=/var/log/containers/stdouts/openstack-cinder-volume.log -e KOLLA_CONFIG_STRATEGY=COPY_ALWAYS cluster.common.tag/openstack-cinder-volume:pcmklatest /bin/bash /usr/local/bin/kolla_start
```
