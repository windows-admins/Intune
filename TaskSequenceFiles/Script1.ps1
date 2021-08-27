$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
copy-item $executingScriptDirectory\Scripts $env:ProgramFiles -force -Recurse
copy-item $executingScriptDirectory\PackageManagement $env:ProgramFiles -force -Recurse
copy-item $executingScriptDirectory\WindowsPowershell $env:ProgramFiles -force -Recurse