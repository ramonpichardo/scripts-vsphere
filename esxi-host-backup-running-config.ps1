# Save ESXi host running configuration using VMware PowerCLI

$VIServer = "vcenter1.lab.local"
$VMHost = "esxi01.lab.local"

Connect-VIServer $VIServer -AllLinked
mkdir C:\Windows\Temp\running-config-esxi-host
Get-VMHost $VMHost | Get-VMHostFirmware -BackupConfiguration -DestinationPath 'C:\Windows\Temp\running-config-esxi-host\'
exit
