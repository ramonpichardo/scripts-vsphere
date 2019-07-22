# Turn on DRS / HA within vSphere

$VIServer = "vcenter1.lab.local"

Connect-VIServer $VIServer -AllLinked
Get-Cluster | Set-Cluster -HAEnabled:$true -DrsEnabled:$false -Confirm:$false
exit
