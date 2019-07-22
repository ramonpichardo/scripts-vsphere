# Patch a standalone VMware ESXi host via Online Bundle (i.e., no access to vCenter VUM? No problem!)
# Source: https://discuss.macstadium.com/t/update-standalone-esxi-host-via-online-bundle/60


# 1. Place the host in maintenance mode: Right-click host > Enter Maintenance Mode.

# 2. Enable the SSH service on the host: Manage > Services > Select TSM-SSH > Start.

# 3. Log into the host via SSH using PuTTY (Windows) or Terminal (Mac/Linux) or your favorite terminal client.

# 4. Open a second shell session and run this command:
# Source: https://unix.stackexchange.com/questions/137759/why-use-nohup-rather-than-exec
tail -f /var/log/esxupdate.log

# 5. Check the profile version you are running:
# Information Level: Full Details
esxcli software profile get
# Information Level: OS Version and Release Build
esxcli system version get

# 6. Set VM host to enter maintenance mode
esxcli system maintenanceMode set --enable true

# 7. Enable host firewall rule to allow web traffic
esxcli network firewall ruleset set -e true -r httpClient

# 8. List the online depot profiles available to you. Note: It may take a minute. Append the “ESXi-6.x.0” with more information to narrow the search further.
esxcli software sources profile list -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml | grep -i ESXi-6.5.0-2019

# 9. Select the package you want to install and insert it into the command. Below my version is “ESXi-6.5.0-20190504001-standard” to take me from the current Build to the latest Build package.
# Source: https://unix.stackexchange.com/questions/137759/why-use-nohup-rather-than-exec
# "nohup and &" example: nohup myprogram </dev/null >myprogram.log 2>&1 &
esxcli software profile update -p ESXi-6.5.0-20190504001-standard -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml 

# 10. After some time the following will appear:
# "Message: The update completed successfully, but the system needs to be rebooted for the changes to be effective."
# "Reboot Required: true"

# 11. Restart the host
reboot

# 12. Enable host firewall rule to disallow web traffic
esxcli network firewall ruleset set -e false -r httpClient

# 13. Set VM host to exit maintenance mode
esxcli system maintenanceMode set --enable false
