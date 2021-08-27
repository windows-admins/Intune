try {
    $ErrorActionPreference = "Stop"
    Write-Output "Configuring Block persistence through WMI event subscription in Block mode"
    $AsrPersistenceThroughWmiRuleID = "e6db77e5-3df2-4cf1-b95a-636979351e5b"
    Add-MpPreference -AttackSurfaceReductionRules_Ids "$AsrPersistenceThroughWmiRuleID" -AttackSurfaceReductionRules_Actions Enabled -ErrorAction Stop
    exit 0
}
catch {
    $errMsg = $_.Exception.Message
    Write-Host $errMsg
    exit 1
}