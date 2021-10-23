$VIServer = "vcenter1.lab.local"
 
Connect-VIServer $VIServer -AllLinked
 
# Query NTP daemon policy and running status
Get-VMHost | Sort | Get-VMHostService | Where-Object {$_.key -eq "ntpd"} | select vmhost, label, Key, Policy, Running | Format-Table –Autosize
 

# Query configured NTP server and is NTP service is running
Get-VMHost | Sort | Select Name, @{N="NTPServer";E={$_ |Get-VMHostNtpServer}}, @{N="ServiceRunning";E={(Get-VmHostService -VMHost $_ | Where-Object {$_.key-eq "ntpd"}).Running}}
