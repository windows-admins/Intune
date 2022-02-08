$link = "https://download.microsoft.com/download/3/c/d/3cd6f5b3-3fbe-43c0-88e0-8256d02db5b7/MMASetup-AMD64.exe"
$file = "MMASetup-AMD64.exe"
$tmp = "$env:TEMP$file"
$client = New-Object System.Net.WebClient
$client.DownloadFile($link, $tmp)
Start-Process "$env:TEMP$file" -ArgumentList "/Q /T:$env:Temp/MOM /C" -Wait -NoNewWindow
Start-Process "$env:Temp/MOM/setup.exe" -ArgumentList "/qn NOAPM=0 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_AZURE_CLOUD_TYPE=0 OPINSIGHTS_WORKSPACE_ID='62bd4926-2ef3-457f-b855-767651a26581' OPINSIGHTS_WORKSPACE_KEY='vU17Sy2aOEgleY8sva9/fzjVnFKLVCJvX7bDwmTLhIsS0xf4Hdqx2M/53mMdeW+oJGmlTli/PiHP9xCKG/Tcig==' AcceptEndUserLicenseAgreement=1" -NoNewWindow -Wait
