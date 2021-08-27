$Tenant = ""
$clientid = ""
$clientSecret = ""
$grouptag = "TSUpload"
$teamsURI = ''
$alerts = $false

Try{
    $serial = (Get-CimInstance win32_bios).SerialNumber
    Set-Location "$env:ProgramFiles\Scripts\"
    ./Get-WindowsAutoPilotInfo.ps1 -Online -groupTag $grouptag -TenantId $tenant -AppId $clientid -AppSecret $clientSecret
   
     remove-item  $env:ProgramFiles\Scripts\ -force -Recurse
    if($alerts -eq $true){
     # Force TLS 1.2 protocol. Invoke-RestMethod uses 1.0 by default. Required for Teams notification to work
     Write-Verbose -Message ('{0} - Forcing TLS 1.2 protocol for invoking REST method.' -f $MyInvocation.MyCommand.Name)
     [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
     
     $body = ConvertTo-Json -Depth 4 @{
         title    = "Hash Upload Status"
         text   = " "
         sections = @(
           @{
             activityTitle    = 'Succesful Upload of Hardware Hash'
             activitySubtitle = "Device with Serial $serial uploaded succesfully, with the group tag $grouptag"
             activityText   = ' '
             activityImage    = 'https://i.imgur.com/NtPeAoY.png' # this value would be a path to a nice image you would like to display in notifications
           }
         )
       }
       Invoke-RestMethod -uri $teamsURI -Method Post -body $body -ContentType 'application/json'
    }
    }
    catch {
        
        $errMsg = $_.Exception.Message
        write-host $errMsg
        if($alerts -eq $true){                
     # Force TLS 1.2 protocol. Invoke-RestMethod uses 1.0 by default. Required for Teams notification to work
     Write-Verbose -Message ('{0} - Forcing TLS 1.2 protocol for invoking REST method.' -f $MyInvocation.MyCommand.Name)
     [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
     
     $body = ConvertTo-Json -Depth 4 @{
         title    = "Hash Upload Fail"
         text   = "$errMsg "
         sections = @(
           @{
             activityTitle    = 'Hash upload failure'
             activitySubtitle = "Review error message"
             activityText   = ' '
             activityImage    = 'https://i.imgur.com/N39eDrY.png' # this value would be a path to a nice image you would like to display in notifications
           }
         )
       }
       Invoke-RestMethod -uri $teamsURI -Method Post -body $body -ContentType 'application/json'
    }
}