# windows guest boostrap
We can feed userdata into windows guests as well as linux ones due to cloud-init.
I have prepared a windows 10 21h1 and win2019 rs5 image with cloudbase-init installed/sysprepped.

Some basic houskeeping can be done with an example powershell script such as this.

I am also using the ansible bootstrap script to configure this host for remote control via ansible.

```
#ps1_sysnative
$ansible_config_script = 'https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'
$ansible_config_file = "C:\Windows\Temp\ConfigureRemotingForAnsible.ps1"
$local_admin_password = 'Benchmark1'


Write-Output "Updating local Administrator password"
net user Administrator $local_admin_password

Write-Output "Downloading ansible configuration script"
(new-object system.net.webclient).DownloadFile($ansible_config_script, $ansible_config_file)

Write-Output "Running ansible configuration script"
& $ansible_config_file

Write-Output "Updating computer name and reboot"
Rename-Computer -NewName $computerName -Restart
```

This gets kind of interesting when we have heat orchestrate the deployment of the instance and we can massage a cloud init template with
vital data provided via the stack:

Take for example me using this block : https://github.com/gprocunier/dcib/blob/main/openstack/benchmark/nested/node.yaml#L26-L39

To transform the $computerName variable into the instance name from the deployment by adding a param of ```___INSTANCE_NAME___``` :
Likewise I can have heat generate a random password for $local_admin_password and set it here using a similar method.

```
#ps1_sysnative
$ansible_config_script = 'https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'
$ansible_config_file = "C:\Windows\Temp\ConfigureRemotingForAnsible.ps1"
$local_admin_password = 'Benchmark1'
$computerName = '___INSTANCE_NAME___'

Write-Output "Updating local Administrator password"
net user Administrator $local_admin_password

Write-Output "Downloading ansible configuration script"
(new-object system.net.webclient).DownloadFile($ansible_config_script, $ansible_config_file)

Write-Output "Running ansible configuration script"
& $ansible_config_file

Write-Output "Updating computer name and reboot"
Rename-Computer -NewName $computerName -Restart```
```
