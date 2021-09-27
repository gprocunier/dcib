#!/bin/bash
                                                           
read -r -d '' containers <<'_E_O_F_'                  
registry.redhat.io/rhceph/rhceph-4-rhel8:latest    
registry.redhat.io/rhosp-rhel8/openstack-aodh-api:16.2                                                                 
registry.redhat.io/rhosp-rhel8/openstack-aodh-evaluator:16.2 
registry.redhat.io/rhosp-rhel8/openstack-aodh-listener:16.2 
registry.redhat.io/rhosp-rhel8/openstack-aodh-notifier:16.2     
registry.redhat.io/rhosp-rhel8/openstack-ceilometer-central:16.2
registry.redhat.io/rhosp-rhel8/openstack-ceilometer-compute:16.2
registry.redhat.io/rhosp-rhel8/openstack-ceilometer-notification:16.2
registry.redhat.io/rhosp-rhel8/openstack-cinder-api:16.2
registry.redhat.io/rhosp-rhel8/openstack-cinder-scheduler:16.2
registry.redhat.io/rhosp-rhel8/openstack-cinder-volume:16.2 
registry.redhat.io/rhosp-rhel8/openstack-collectd:16.2
registry.redhat.io/rhosp-rhel8/openstack-cron:16.2
registry.redhat.io/rhosp-rhel8/openstack-designate-api:16.2 
registry.redhat.io/rhosp-rhel8/openstack-designate-backend-bind9:16.2
registry.redhat.io/rhosp-rhel8/openstack-designate-central:16.2
registry.redhat.io/rhosp-rhel8/openstack-designate-mdns:16.2
registry.redhat.io/rhosp-rhel8/openstack-designate-producer:16.2
registry.redhat.io/rhosp-rhel8/openstack-designate-worker:16.2
registry.redhat.io/rhosp-rhel8/openstack-glance-api:16.2
registry.redhat.io/rhosp-rhel8/openstack-haproxy:16.2
registry.redhat.io/rhosp-rhel8/openstack-heat-api:16.2
registry.redhat.io/rhosp-rhel8/openstack-heat-api-cfn:16.2
registry.redhat.io/rhosp-rhel8/openstack-heat-engine:16.2
registry.redhat.io/rhosp-rhel8/openstack-horizon:16.2
registry.redhat.io/rhosp-rhel8/openstack-iscsid:16.2
registry.redhat.io/rhosp-rhel8/openstack-keystone:16.2
registry.redhat.io/rhosp-rhel8/openstack-manila-api:16.2
registry.redhat.io/rhosp-rhel8/openstack-manila-scheduler:16.2
registry.redhat.io/rhosp-rhel8/openstack-manila-share:16.2
registry.redhat.io/rhosp-rhel8/openstack-mariadb:16.2
registry.redhat.io/rhosp-rhel8/openstack-memcached:16.2
registry.redhat.io/rhosp-rhel8/openstack-neutron-metadata-agent-ovn:16.2
registry.redhat.io/rhosp-rhel8/openstack-neutron-server-ovn:16.2
registry.redhat.io/rhosp-rhel8/openstack-nova-api:16.2
registry.redhat.io/rhosp-rhel8/openstack-nova-compute:16.2
registry.redhat.io/rhosp-rhel8/openstack-nova-conductor:16.2
registry.redhat.io/rhosp-rhel8/openstack-nova-libvirt:16.2
registry.redhat.io/rhosp-rhel8/openstack-nova-novncproxy:16.2
registry.redhat.io/rhosp-rhel8/openstack-nova-scheduler:16.2
registry.redhat.io/rhosp-rhel8/openstack-octavia-api:16.2
registry.redhat.io/rhosp-rhel8/openstack-octavia-health-manager:16.2
registry.redhat.io/rhosp-rhel8/openstack-octavia-housekeeping:16.2
registry.redhat.io/rhosp-rhel8/openstack-octavia-worker:16.2
registry.redhat.io/rhosp-rhel8/openstack-ovn-controller:16.2
registry.redhat.io/rhosp-rhel8/openstack-ovn-northd:16.2
registry.redhat.io/rhosp-rhel8/openstack-placement-api:16.2 
registry.redhat.io/rhosp-rhel8/openstack-qdrouterd:16.2
registry.redhat.io/rhosp-rhel8/openstack-rabbitmq:16.2
registry.redhat.io/rhosp-rhel8/openstack-redis:16.2
registry.redhat.io/rhosp-rhel8/openstack-swift-account:16.2 
registry.redhat.io/rhosp-rhel8/openstack-swift-container:16.2
registry.redhat.io/rhosp-rhel8/openstack-swift-object:16.2
registry.redhat.io/rhosp-rhel8/openstack-swift-proxy-server:16.2
registry.redhat.io/rhosp-rhel8/openstack-zaqar-wsgi:16.2
_E_O_F_

podman login registry.redhat.io

forklimit=10

for runner in $containers
do
  ((i=i%forklimit)); ((i++==0)) && wait
  podman pull $runner &
done
