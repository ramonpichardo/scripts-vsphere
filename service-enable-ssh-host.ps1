# PowerCLI - Turn On SSH Service - Single Host Level

$VIServer = "vcenter1.lab.local"
$VMHost = "esxi01.lab.local"

Connect-VIServer $VIServer -AllLinked

Get-VMHost -name $VMHost | ForEach {Start-VMHostService -HostService ($_ | Get-VMHostService | Where {$_.Key -eq "TSM-SSH"}) -Confirm:$FALSE}
