# Reference: Installing VMware PowerCLI: https://pubs.vmware.com/vsphere-6-5/topic/com.vmware.powercli.ug.doc/GUID-2DD2454B-2B1E-4A7D-9134-B442254F0681.html

# Launch an administrative PowerShell session.
#Requires -RunAsAdministrator

# Verify this script is running in an administrator security context.
$IsAdmin=[Security.Principal.WindowsIdentity]::GetCurrent()
If ((New-Object Security.Principal.WindowsPrincipal $IsAdmin).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) -eq $FALSE)
{
      "`nERROR: This script will only run in an administrator context. Run this script after launching a Run As Administrator PowerShell session."
      pause
      exit
}

# Set the execution policy to RemoteSigned to run scripts and load configuration files with PowerCLI.
Set-ExecutionPolicy RemoteSigned

# As a default, PSGallery is an untrusted repository. Use Set-PSRepository to make PSGallery trusted.
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based repositories.
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

# Install the latest VMware PowerCLI version.
Install-Module -Name VMware.PowerCLI -AllowClobber -SkipPublisherCheck

# Enable connecting to multiple default servers. Also, ignore invalid certificate errors.
Set-PowerCLIConfiguration -DefaultVIServerMode multiple -InvalidCertificateAction Ignore -Confirm:$FALSE

# Updates the PowerCLI module.
Update-Module VMware.PowerCLI

# If the module is installed bring the module and its functions into your current PowerShell session.
Import-Module VMware.PowerCLI

# Download and install the newest help files on your computer.
Update-Help


# Post-installation commands. Uncomment as needed:

# List PowerCLI version
# Get-Module VMware.PowerCLI -ListAvailable | Format-Table Name,Version -AutoSize

# Validate that the module is running. This command should return a count of hundreds (600+) of modules.
# Get-Command -Module *vmware* | Measure

# List all PowerCLI module commands.
# Get-Command -Module *vmware* | Format-Table CommandType,Name,Version,Source -AutoSize


# VMware vSphere array.
$vcenters = @( 
    "vcenter1.lab.local", 
    "vcenter2.lab.local" 
);

# Connect to the vCenter servers.
Connect-VIServer -Server $vcenters -AllLinked
