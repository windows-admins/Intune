#Uninstall SCCM Client Variables
    $UninstallPath = "C:\Windows\ccmsetup"
    $UninstallerName = "ccmsetup.exe"
    $UninstallerArguments = "/Uninstall"

    #Uninstall SCCM Client action
    Start-Process -FilePath "$UninstallPath\$UninstallerName" -ArgumentList $UninstallerArguments -Wait -PassThru

    #Remove register key
    $registryPath = "HKLM:\SOFTWARE\Microsoft\DeviceManageabilityCSP"
    Remove-Item $registryPath -Force

    #Sysprep Variables
    $sysprepPath = "c:\windows\system32\sysprep"
    $sysprepName = "sysprep.exe"
    $sysprepArguments = "/oobe /reboot"

    #sysprep execution
    Start-Process -FilePath "$sysprepPath\$sysprepName" -ArgumentList $sysprepArguments