try{
    $ErrorActionPreference = "Stop"
    $AsrPersistenceThroughWmiRuleID = "e6db77e5-3df2-4cf1-b95a-636979351e5b"
    $RulesIds = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Ids
    $RulesActions = Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Actions
    $ASRRuleResults = [System.Collections.ArrayList]::new()
    $RulesIdsArray = @()
    $RulesIdsArray += $RulesIds
    
    $counter = 0
    ForEach ($j in $RulesIds){
        ## Convert GUID into Rule Name
        If ($RulesIdsArray[$counter] -eq "e6db77e5-3df2-4cf1-b95a-636979351e5b"){$RuleName = "Block persistence through WMI event subscription"}
        ## Check the Action type
        If ($RulesActions[$counter] -eq 0){$RuleAction = "Disabled"}
        ElseIf ($RulesActions[$counter] -eq 1){$RuleAction = "Block"}
        ElseIf ($RulesActions[$counter] -eq 2){$RuleAction = "Audit"}
        ElseIf ($RulesActions[$counter] -eq 5){$RuleAction = "NotConfigured"}
        ElseIf ($RulesActions[$counter] -eq 6){$RuleAction = "Warn"}
    
         [void]$ASRRuleResults.Add($([PSCustomObject]@{
            Rule = $RulesIdsArray[$counter]
            RuleName = $RuleName
            Action = $RuleAction
            }))
        $counter++
    }
    
    $AsrPersistenceThroughWmiState = @($ASRRuleResults | Where-Object {$_.Rule -eq "$AsrPersistenceThroughWmiRuleID"}).Action
    If ($AsrPersistenceThroughWmiState -like "Block" -or $AsrPersistenceThroughWmiState -like "Warn")
    {
        Write-Host "Policy already applied"
        exit 0
    }
    Else
    {
        Write-Host "Policy needs applied"
        exit 1  
    }
}
catch{
    $errMsg = $_.Exception.Message
    write-host $errMsg
    exit 1
}

