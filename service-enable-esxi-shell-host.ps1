# PowerCLI - Turn On ESXi Shell Service - Single Host Level

$VIServer = "vcenter1.lab.local"
$VMHost = "esxi01.lab.local"

Connect-VIServer $VIServer -AllLinked

Get-VMHost -name $VMHost | ForEach {Start-VMHostService -HostService ($_ | Get-VMHostService | Where {$_.Key -eq "TSM"}) -Confirm:$FALSE}
