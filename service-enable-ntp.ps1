$VIServer = "vcenter1.lab.local"
Connect-VIServer $VIServer -AllLinked
Get-VMhost | Get-VmHostService | Where-Object {$_.key -eq "ntpd"} | Set-VMHostService -policy "automatic"
Get-VMHost | Get-VmHostService | Where-Object {$_.key -eq "ntpd"} | Start-VMHostService
Get-VMHost | Sort | Get-VMHostService | Where-Object {$_.key -eq "ntpd"} | select vmhost, label, Key, Policy, Running | Format-Table –Autosize
Get-VMHost | Sort | Select Name, @{N="NTPServer";E={$_ |Get-VMHostNtpServer}}, @{N="ServiceRunning";E={(Get-VmHostService -VMHost $_ | Where-Object {$_.key-eq "ntpd"}).Running}}
