# Tuning for scale

Some variables required to deal with large scale deployments and slow disks (vdo):

/var/lib/config-data/puppet-generated/nova_libvirt/etc/nova/nova.conf:
/var/lib/config-data/puppet-generated/nova/etc/nova/nova.conf:

```
[DEFAULT]
# default 64
executor_thread_pool_size=256
# default 60s
rpc_response_timeout=3600
```
/var/lib/config-data/puppet-generated/cinder/etc/cinder/cinder.conf:
```
[DEFAULT]
# typically 1 worker per core.
# We have 24 pCore and 48 threads in the cpu isolation config, 24 is reasonable
osapi_volume_workers=24
# zero out deleted volumes
volume_clear = zero
# only zero out the first 1gb, the default is to do all space and this is slow on vdo
# as it will try and analyze the zeros to dedupe/compress needlessly
volume_clear_size = 1024
# default 64
executor_thread_pool_size = 256
# default 60s
rpc_response_timeout=3600
```
