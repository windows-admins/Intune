$link = "https://download.microsoft.com/download/3/c/d/3cd6f5b3-3fbe-43c0-88e0-8256d02db5b7/MMASetup-AMD64.exe"
$file = "MMASetup-AMD64.exe"
$tmp = "$env:TEMP\$file"
$client = New-Object System.Net.WebClient
$client.DownloadFile($link, $tmp)
Start-Process "$env:TEMP\$file" -ArgumentList "/Q /T:$env:Temp/MOM /C" -Wait -NoNewWindow
Start-Process "$env:Temp/MOM/setup.exe" -ArgumentList "/qn NOAPM=0 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_AZURE_CLOUD_TYPE=0 OPINSIGHTS_WORKSPACE_ID='' OPINSIGHTS_WORKSPACE_KEY='' AcceptEndUserLicenseAgreement=1" -NoNewWindow -Wait
