# PowerCLI - Turn Off ESXi Shell Service - Cluster Level

$VIServer = "vcenter1.lab.local"
$VMClusterName = "VM_cluster_name"

Connect-VIServer $VIServer -AllLinked

Get-Cluster -name $VMClusterName | Get-VMHost | ForEach {Stop-VMHostService -HostService ($_ | Get-VMHostService | Where {$_.Key -eq "TSM"}) -Confirm:$FALSE}
