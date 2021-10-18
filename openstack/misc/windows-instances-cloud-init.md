# windows guest boostrap
We can feed userdata into windows guests as well as linux ones due to cloud-init.
I have prepared a windows 10 21h1 and win2019 rs5 image with cloudbase-init installed/sysprepped.

Some basic houskeeping can be done with an example powershell script such as this.

I am also using the ansible bootstrap script to configure this host for remote control via ansible.

```
#ps1_sysnative
$ansible_config_script='https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'
$local_admin_password='Benchmark1' | ConvertTo-SecureString -AsPlainText -Force
$computerName='windows-test'

Write-Output "Updating local Administrator password"
net user Administrator $local_admin_password

Write-Output "Downloading ansible configuration script"
(new-object system.net.webclient).DownloadFile($ansible_config_script)

Write-Output "Running ansible configuration script"
C:\Temp\ConfigureRemotingForAnsible.ps1


Write-Output "Updating computer name and reboot"
Rename-Computer -NewName $computerName -Restart
```
