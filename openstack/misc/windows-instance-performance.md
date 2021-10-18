# enabling more hyperV englightenments for windows instances

Apply the patch to config.py and create the path usr/lib/python3.6/site-packages/nova/virt/libvirt 
under /var/lib/config-data/puppet-generated/nova_libvirt placing the patched config.py here.  Then
restart the nova_libvirt container.

```
--- /usr/lib/python3.6/site-packages/nova/virt/libvirt/config.py      2021-08-27 13:39:16.000000000 +0000
+++ /usr/lib/python3.6/site-packages/nova/virt/libvirt/config.py      2021-10-05 19:05:22.555137742 +0000
@@ -2505,7 +2505,7 @@
 class LibvirtConfigGuestFeatureHyperV(LibvirtConfigGuestFeature):
 
     # QEMU requires at least this value to be set
-    MIN_SPINLOCK_RETRIES = 4095
+    MIN_SPINLOCK_RETRIES = 8191
     # The spoofed vendor_id can be any alphanumeric string
     SPOOFED_VENDOR_ID = "1234567890ab"
 
@@ -2522,6 +2522,11 @@
 
     def format_dom(self):
         root = super(LibvirtConfigGuestFeatureHyperV, self).format_dom()
+        root.append(etree.Element("vpindex", state="on"))
+        root.append(etree.Element("frequencies", state="on"))
+        root.append(etree.Element("stimer", state="on"))
+        root.append(etree.Element("runtime", state="on"))
+        root.append(etree.Element("synic", state="on"))
 
         if self.relaxed:
             root.append(etree.Element("relaxed", state="on"))
```

This adds some key performance features present in KVM for windows guests.

Eg.

```
# windows instance is domain 312
$ sudo podman exec -it nova_libvirt virsh dumpxml 312
... snip ...
  <sysinfo type='smbios'>
    <system>
      <entry name='manufacturer'>Red Hat</entry>
      <entry name='product'>OpenStack Compute</entry>
      <entry name='version'>20.6.2-2.20210607104828.el8ost.4</entry>
      <entry name='serial'>7da643ec-b9fe-481e-8ddc-e3112a2deece</entry>
      <entry name='uuid'>7da643ec-b9fe-481e-8ddc-e3112a2deece</entry>
      <entry name='family'>Virtual Machine</entry>
    </system>
  </sysinfo>
  <os>
    <type arch='x86_64' machine='pc-i440fx-rhel7.6.0'>hvm</type>
    <boot dev='hd'/>
    <smbios mode='sysinfo'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <hyperv>
      <relaxed state='on'/>
      <vapic state='on'/>
      <spinlocks state='on' retries='8191'/>
      <vpindex state='on'/>
      <runtime state='on'/>
      <synic state='on'/>
      <stimer state='on'/>
      <frequencies state='on'/>
    </hyperv>
  </features>
... snip ...
```

# references
1. https://archive.fosdem.org/2019/schedule/event/vai_enlightening_kvm/attachments/slides/2860/export/events/attachments/vai_enlightening_kvm/slides/2860/vkuznets_fosdem2019_enlightening_kvm.pdf
2. https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_virtualization/installing-and-managing-windows-virtual-machines-on-rhel8_configuring-and-managing-virtualization#enabling-hyper-v-enlightenments-on-a-windows-virtual-machine-in-rhel-8_enabling-hyper-v-enlightenments

