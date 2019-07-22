# Turn off DRS / HA within vSphere
# Warning: Disabling DRS will delete any resource pool on the cluster without warning!

$VIServer = "vcenter1.lab.local"

Connect-VIServer $VIServer -AllLinked
Get-Cluster | Set-Cluster -HAEnabled:$false -DrsEnabled:$false -Confirm:$false
exit
