# PowerCLI - Turn On SSH Service - Cluster Level

$VIServer = "vcenter1.lab.local"
$VMClusterName = "VM_cluster_name"

Connect-VIServer $VIServer -AllLinked

Get-Cluster -name $VMClusterName | Get-VMHost | ForEach {Start-VMHostService -HostService ($_ | Get-VMHostService | Where {$_.Key -eq "TSM-SSH"}) -Confirm:$FALSE}
