#Warning on potentially could scan synced sharepoint libraries.

#Note this is using CIM instance - this will NOT work for old Servers and is not intended to be used on them.

$drives = (Get-CimInstance -Query "Select DeviceID from win32_logicaldisk where drivetype = 3").DeviceID

#Set the search string we are hunting for.
$searchString = "*.jar"

#Add type for reading the JarFiles 
Add-Type -AssemblyName "system.io.compression.filesystem"
#Create an object to store found risks

$foundRisks = New-Object -TypeName 'System.Collections.Generic.List[psobject]'
Foreach ($drive in $drives) {
    #Assemble the risky files for the drive.
    $riskyFiles = (&cmd /c robocopy /l $(($drive) + '\') null "$searchString" /ns /njh /njs /np /nc /ndl /xjd /mt /s).trim() | Where-Object { $_ -ne "" }
    #Evaluate each set of risky files to see if there is anything to Evaluate.
    Foreach ($file in $riskyFiles) {
                $data = $null
                $detections = $null
                try{
                    #Warning this could could potentially create a lock on a Jar file - we do dispose of the connection and read at the end but based on size it could take a moment.
                    $data = [io.Compression.Zipfile]::openRead($file)
                    $detections = $data.Entries | Where-Object {$_.fullname -like "*jndiLookup.class"}
                    $data.Dispose()
                }
                catch{
                    $hash = [ordered]@{
                        fileName = $file
                        class = "UnableToRead"
                        fileHash = $((Get-FileHash -Path $file -Algorithm SHA256).Hash)
                    }
                    $foundRisks.add((New-Object -TypeName psobject -Property $hash))
                }
                if($detections){ 
                    foreach($detection in $detections ){
                        $hash = [ordered]@{
                            fileName = $file
                            class = $detection.FullName
                            fileHash = $((Get-FileHash -Path $file -Algorithm SHA256).Hash)
                        }
                        $foundRisks.add((New-Object -TypeName psobject -Property $hash))
                    }
                }
            }
            
        }
If ($($foundRisks | Measure-Object).count -ge 1) { 
    foreach($risk in $foundRisks){
        #Assemble a Single Large Write Host Command for PR
        $jumboTune = "$jumboTune Found: $($risk.FileName) with Hash:$($risk.fileHash) and Class: $($risk.class)`n"
    }
    Write-Host $jumboTune
    exit 1
}
Else { 
    Write-Host "No Vulnerabilities found"
    exit 0
}