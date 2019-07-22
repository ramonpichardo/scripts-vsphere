$VIServer = "vcenter1.lab.local"

Connect-VIServer $VIServer -AllLinked

Get-VM * | Get-CDDrive | select @{N="VM";E="Parent"},IsoPath | where {$_.IsoPath -ne $null} | Format-Table VM,IsoPath -AutoSize > C:\temp\isos.txt
