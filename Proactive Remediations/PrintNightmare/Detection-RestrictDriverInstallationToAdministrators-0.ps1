try {
    $RestrictDriverInstallationToAdministrators = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint' -Name RestrictDriverInstallationToAdministrators | Select-Object -ExpandProperty RestrictDriverInstallationToAdministrators
    
    if ($RestrictDriverInstallationToAdministrators -eq 0) {
        Write-Host "RestrictDriverInstallationToAdministrators=0"
        exit 0
    }
    else {
        Write-Host "Not compliant"
        exit 1
    }
}
catch {
    $LastError = $Error | Select-Object -First 1 -ExpandProperty Exception | Select-Object -ExpandProperty Message
    Write-Warning -Message $LastError
    exit 1
}
