# Localized	12/07/2019 01:04 AM (GMT)	303:6.40.20520 	MSFT_PackageManagement.strings.psd1
#########################################################################################
#
# Copyright (c) Microsoft Corporation.
#
#########################################################################################
ConvertFrom-StringData @'
###PSLOC
StartGetPackage=Begin invoking Get-package {0} using PSModulePath {1}.
PackageFound=Package '{0}' found.
PackageNotFound=Package '{0}' not found.
MultiplePackagesFound=More than one package found for package '{0}'.
StartTestPackage=Test-TargetResource calling Get-TargetResource using {0}.
InDesiredState=Resource {0} is in the desired state. Required Ensure is {1} and actual Ensure is {2}
NotInDesiredState=Resource {0} is not in the desired state. Required Ensure is {1} and actual Ensure is {2}
StartSetPackage=Set-TargetResource calling Test-TargetResource using {0}.
InstallPackageInSet=Calling Install-Package using {0}.
###PSLOC

'@

