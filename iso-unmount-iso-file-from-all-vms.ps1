$VIServer = "vcenter1.lab.local"

Connect-VIServer $VIServer -AllLinked

Get-VM * | Get-CDDrive | where {$_.IsoPath -ne $null} | Set-CDDrive -NoMedia -Confirm:$False
