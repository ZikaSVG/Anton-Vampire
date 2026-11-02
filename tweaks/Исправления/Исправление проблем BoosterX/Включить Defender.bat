@echo off
:: https://privacy.sexy — v0.13.7 — Sat, 11 Jan 2025 15:04:51 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: Disable "Malicious Software Reporting Tool" diagnostic data (revert)
echo --- Disable "Malicious Software Reporting Tool" diagnostic data (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\MRT!DontReportInfectionInformation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\MRT' /v 'DontReportInfectionInformation' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus Watson event reporting (revert)
echo --- Disable Defender Antivirus Watson event reporting (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting!DisableGenericRePorts"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting' /v 'DisableGenericRePorts' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting!DisableGenericRePorts"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting' /v 'DisableGenericRePorts' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable Defender Antivirus telemetry (revert)-------
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus telemetry (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Features!DisableCoreService1DSTelemetry"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Features' /v 'DisableCoreService1DSTelemetry' /f 2>$null"
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\CoreService!DisableCoreService1DSTelemetry"
:: ----------------------------------------------------------
:: Disable Defender Antivirus remote experimentation and configurations (revert)
echo --- Disable Defender Antivirus remote experimentation and configurations (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Features!DisableCoreServiceECSIntegration"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Features' /v 'DisableCoreServiceECSIntegration' /f 2>$null"
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\CoreService!DisableCoreServiceECSIntegration"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable Defender Antivirus Azure data collection (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus Azure data collection (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpAzSubmit.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Defender Antivirus "Block at First Sight" feature (revert)
echo --- Disable Defender Antivirus "Block at First Sight" feature (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet!DisableBlockAtFirstSeen"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\SpyNet' /v 'DisableBlockAtFirstSeen' /f 2>$null"
:: Delete the registry value "HKLM\Software\Microsoft\Windows Defender\SpyNet!DisableBlockAtFirstSeen"
:: ----------------------------------------------------------
:: Disable Defender Antivirus "Extended Cloud Check" feature (revert)
echo --- Disable Defender Antivirus "Extended Cloud Check" feature (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine!MpBafsExtendedTimeout"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine' /v 'MpBafsExtendedTimeout' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\MpEngine!MpBafsExtendedTimeout"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows Defender\MpEngine' /v 'MpBafsExtendedTimeout' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus aggressive cloud protection (revert)
echo --- Disable Defender Antivirus aggressive cloud protection (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine!MpCloudBlockLevel"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine' /v 'MpCloudBlockLevel' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\MpEngine!MpCloudBlockLevel"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows Defender\MpEngine' /v 'MpCloudBlockLevel' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus cloud-based notifications (revert)
echo --- Disable Defender Antivirus cloud-based notifications (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!SignatureDisableNotification"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'SignatureDisableNotification' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Microsoft Antimalware\Signature Updates!SignatureDisableNotification"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Microsoft Antimalware\Signature Updates' /v 'SignatureDisableNotification' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus cloud protection reporting (revert)
echo --- Disable Defender Antivirus cloud protection reporting (revert)
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet!SpyNetReporting"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet!LocalSettingOverrideSpynetReporting"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' /v 'LocalSettingOverrideSpynetReporting' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet!SpynetReporting"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' /v 'SpynetReporting' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus automatic file submission to Microsoft (revert)
echo --- Disable Defender Antivirus automatic file submission to Microsoft (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet!SubmitSamplesConsent"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' /v 'SubmitSamplesConsent' /f 2>$null"
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\Spynet!SubmitSamplesConsent"
:: ----------------------------------------------------------
:: Disable Defender Antivirus real-time security intelligence updates (revert)
echo --- Disable Defender Antivirus real-time security intelligence updates (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!RealtimeSignatureDelivery"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'RealtimeSignatureDelivery' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Defender Antivirus minifilter driver (revert)---
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus minifilter driver (revert)
:: Restore the registry value "Altitude" in key "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter\Instances\WdFilter Instance" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$data = '328010'; $rawType = 'REG_SZ'; $rawPath = 'HKLM\SYSTEM\CurrentControlSet\Services\WdFilter\Instances\WdFilter Instance'; $value = 'Altitude'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore the service `WdFilter` using TrustedInstaller privileges
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\WdFilter.sys" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable Defender Antivirus boot driver (revert)------
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus boot driver (revert)
:: Restore the service `WdBoot` using TrustedInstaller privileges
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\WdBoot.sys" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\ELAMBKUP\WdBoot.sys" with additional permissions 
:: Restore the registry value "BackupPath" in key "HKLM\SYSTEM\CurrentControlSet\Control\EarlyLaunch" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$data = '%SYSTEMROOT%\ELAMBKUP'; $rawType = 'REG_SZ'; $rawPath = 'HKLM\SYSTEM\CurrentControlSet\Control\EarlyLaunch'; $value = 'BackupPath'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\Config\elam"  
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable security event monitoring (revert)--------
:: ----------------------------------------------------------
echo --- Disable security event monitoring (revert)
:: Restore service(s) to default state: `MsSecFlt`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'MsSecFlt'; $defaultStartupMode = 'Manual'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\MsSecFlt.sys" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\System32\mssecuser.dll" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable Secure Boot driver (revert)------------
:: ----------------------------------------------------------
echo --- Disable Secure Boot driver (revert)
:: Restore service(s) to default state: `MsSecCore`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'MsSecCore'; $defaultStartupMode = 'Boot'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\msseccore.sys" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Disable Tamper Protection (revert)------------
:: ----------------------------------------------------------
echo --- Disable Tamper Protection (revert)
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\Features!TamperProtection"
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\Features!TamperProtectionSource"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Disable virtualization-based security (VBS) (revert)---
:: ----------------------------------------------------------
echo --- Disable virtualization-based security (VBS) (revert)
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard!EnableVirtualizationBasedSecurity"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard' /v 'EnableVirtualizationBasedSecurity' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard!EnableVirtualizationBasedSecurity"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard' /v 'EnableVirtualizationBasedSecurity' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard!RequirePlatformSecurityFeatures"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard' /v 'RequirePlatformSecurityFeatures' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard!RequirePlatformSecurityFeatures"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard' /v 'RequirePlatformSecurityFeatures' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard!Locked"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard' /v 'Locked' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard!NoLock"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard' /v 'NoLock' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard!Unlocked"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard' /v 'Unlocked' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity!Locked"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' /v 'Locked' /f 2>$null"
:: Set the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard!RequireMicrosoftSignedBootChain"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard' /v 'RequireMicrosoftSignedBootChain' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' /v 'Enabled' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard!HypervisorEnforcedCodeIntegrity"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard' /v 'HypervisorEnforcedCodeIntegrity' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard!Mandatory"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard' /v 'Mandatory' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity!HVCIMATRequired"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' /v 'HVCIMATRequired' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard!HVCIMATRequired"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard' /v 'HVCIMATRequired' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable System Guard startup verification (revert)----
:: ----------------------------------------------------------
echo --- Disable System Guard startup verification (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard!ConfigureSystemGuardLaunch"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard' /v 'ConfigureSystemGuardLaunch' /f 2>$null"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard' /v 'Enabled' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable System Guard sandbox monitoring (revert)-----
:: ----------------------------------------------------------
echo --- Disable System Guard sandbox monitoring (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SgrmLpac.exe" with additional permissions 
:: This operation will not run on Windows versions later than Windows11-21H2.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\Sgrm\SgrmLpac.exe"  
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Remove configuration preventing "SgrmLpac.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SgrmLpac.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SgrmLpac.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "SgrmLpac.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable System Guard kernel monitoring (revert)------
:: ----------------------------------------------------------
echo --- Disable System Guard kernel monitoring (revert)
:: Restore service(s) to default state: `SgrmAgent`
:: This operation will not run on Windows versions later than Windows11-21H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $serviceName = 'SgrmAgent'; $defaultStartupMode = 'Boot'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore service(s) to default state: `SgrmAgent`
:: This operation will not run on Windows versions earlier than Windows11-22H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $serviceName = 'SgrmAgent'; $defaultStartupMode = 'Disabled'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\SgrmAgent.sys" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable System Guard communication hub (revert)------
:: ----------------------------------------------------------
echo --- Disable System Guard communication hub (revert)
:: Restore the service `SgrmBroker` 
:: This operation will not run on Windows versions later than Windows11-21H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-21H2'; $buildNumber = switch ($versionName) { 'Windows11-21H2' { '10.0.22000' }; 'Windows10-MostRecent' { '10.0.19045' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1903' { '10.0.18362' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for maximum Windows '$versionName'"^""; }; }; $maxVersion=[System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -gt $maxVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is above maximum $maxVersion ($versionName)"^""; Exit 0; }; $serviceQuery = 'SgrmBroker'; $defaultStartupMode = 'Automatic'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if (!$service) { Write-Warning "^""Service query `"^""$serviceQuery`"^"" did not yield and results. Revert cannot proceed."^""; Exit 1; }; $serviceName = $service.Name; Write-Host "^""Restoring registry settings for service `"^""$serviceName`"^"" to default startup mode `"^""$defaultStartupMode`"^""."^""; <# -- 2. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if (-Not (Test-Path $registryKey)) { Write-Warning "^""`"^""$registryKey`"^"" is not found in registry. Revert cannot proceed."^""; Exit 1; }; <# -- 3. Enable if not already enabled #>; $defaultStartupRegValue = switch ($defaultStartupMode) { 'Boot'      { 0 }; 'System'    { 1 }; 'Automatic' { 2 }; 'Manual'    { 3 }; 'Disabled'  { 4 }; default { Write-Error "^""Error: Unknown startup mode specified: `"^""$defaultStartupMode`"^"". Revert cannot proceed."^""; return; }; }; if ($(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq $defaultStartupRegValue) { Write-Host "^""`"^""$serviceName`"^"" is has already default startup mode: `"^""$defaultStartupMode`"^""."^""; } else { try { Set-ItemProperty $registryKey -Name Start -Value $defaultStartupRegValue -Force; Write-Host "^""Successfully restored `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, trying to start it."^""; try { Start-Service -Name $serviceName -ErrorAction Stop; Write-Host 'Service started successfully.'; } catch { Write-Warning "^""Failed to restart service. It will be started after reboot. Error: $($_.Exception.Message)"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore the service `SgrmBroker` 
:: This operation will not run on Windows versions earlier than Windows11-22H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $serviceQuery = 'SgrmBroker'; $defaultStartupMode = 'Disabled'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if (!$service) { Write-Warning "^""Service query `"^""$serviceQuery`"^"" did not yield and results. Revert cannot proceed."^""; Exit 1; }; $serviceName = $service.Name; Write-Host "^""Restoring registry settings for service `"^""$serviceName`"^"" to default startup mode `"^""$defaultStartupMode`"^""."^""; <# -- 2. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if (-Not (Test-Path $registryKey)) { Write-Warning "^""`"^""$registryKey`"^"" is not found in registry. Revert cannot proceed."^""; Exit 1; }; <# -- 3. Enable if not already enabled #>; $defaultStartupRegValue = switch ($defaultStartupMode) { 'Boot'      { 0 }; 'System'    { 1 }; 'Automatic' { 2 }; 'Manual'    { 3 }; 'Disabled'  { 4 }; default { Write-Error "^""Error: Unknown startup mode specified: `"^""$defaultStartupMode`"^"". Revert cannot proceed."^""; return; }; }; if ($(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq $defaultStartupRegValue) { Write-Host "^""`"^""$serviceName`"^"" is has already default startup mode: `"^""$defaultStartupMode`"^""."^""; } else { try { Set-ItemProperty $registryKey -Name Start -Value $defaultStartupRegValue -Force; Write-Host "^""Successfully restored `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, trying to start it."^""; try { Start-Service -Name $serviceName -ErrorAction Stop; Write-Host 'Service started successfully.'; } catch { Write-Warning "^""Failed to restart service. It will be started after reboot. Error: $($_.Exception.Message)"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SgrmBroker.exe" with additional permissions 
:: This operation will not run on Windows versions later than Windows11-21H2.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\Sgrm\SgrmBroker.exe"  
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Remove configuration preventing "SgrmBroker.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SgrmBroker.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SgrmBroker.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "SgrmBroker.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable System Guard rule definitions (revert)------
:: ----------------------------------------------------------
echo --- Disable System Guard rule definitions (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\Sgrm\SgrmAssertions.bin" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\System32\Sgrm\SgrmAssertions.cat" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable System Guard rule scanner (revert)--------
:: ----------------------------------------------------------
echo --- Disable System Guard rule scanner (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SgrmEnclave.dll" with additional permissions 
:: This operation will not run on Windows versions later than Windows11-21H2.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\Sgrm\SgrmEnclave.dll"  
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SgrmEnclave_secure.dll" with additional permissions 
:: This operation will not run on Windows versions later than Windows11-21H2.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\Sgrm\SgrmEnclave_secure.dll"  
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable outdated Defender Antivirus (revert)-------
:: ----------------------------------------------------------
echo --- Disable outdated Defender Antivirus (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender!DisableAntiSpyware"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender' /v 'DisableAntiSpyware' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Potentially Unwanted Application (PUA) protection (revert)
echo --- Disable Potentially Unwanted Application (PUA) protection (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine!MpEnablePus"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine' /v 'MpEnablePus' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender!PUAProtection"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender' /v 'PUAProtection' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable file hash computation feature (revert)------
:: ----------------------------------------------------------
echo --- Disable file hash computation feature (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine!EnableFileHashComputation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\MpEngine' /v 'EnableFileHashComputation' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Defender auto-exclusions (revert)---------
:: ----------------------------------------------------------
echo --- Disable Defender auto-exclusions (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions!DisableAutoExclusions"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions' /v 'DisableAutoExclusions' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus license verification (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus license verification (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MsMpLics.dll"  as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\Offline\MsMpLics.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable protocol recognition (revert)-----------
:: ----------------------------------------------------------
echo --- Disable protocol recognition (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\NIS!DisableProtocolRecognition"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\NIS' /v 'DisableProtocolRecognition' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable definition retirement (revert)----------
:: ----------------------------------------------------------
echo --- Disable definition retirement (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS!DisableSignatureRetirement"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS' /v 'DisableSignatureRetirement' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Minimize rate of detection events (revert)--------
:: ----------------------------------------------------------
echo --- Minimize rate of detection events (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS!ThrottleDetectionEventsRate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS' /v 'ThrottleDetectionEventsRate' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable real-time monitoring (revert)-----------
:: ----------------------------------------------------------
echo --- Disable real-time monitoring (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableRealtimeMonitoring"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableRealtimeMonitoring' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable intrusion prevention system (IPS) (revert)----
:: ----------------------------------------------------------
echo --- Disable intrusion prevention system (IPS) (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableIntrusionPreventionSystem"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableIntrusionPreventionSystem' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Information Protection Control (IPC) (revert)---
:: ----------------------------------------------------------
echo --- Disable Information Protection Control (IPC) (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableInformationProtectionControl"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableInformationProtectionControl' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable real-time protection process scanning (revert)--
:: ----------------------------------------------------------
echo --- Disable real-time protection process scanning (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableScanOnRealtimeEnable"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableScanOnRealtimeEnable' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus real-time protection module (revert)
echo --- Disable Defender Antivirus real-time protection module (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpRtp.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable behavior monitoring (revert)-----------
:: ----------------------------------------------------------
echo --- Disable behavior monitoring (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableBehaviorMonitoring"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableBehaviorMonitoring' /f 2>$null"
:: ----------------------------------------------------------
:: Disable sending raw write notifications to behavior monitoring (revert)
echo --- Disable sending raw write notifications to behavior monitoring (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableRawWriteNotification"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableRawWriteNotification' /f 2>$null"
:: ----------------------------------------------------------
:: Disable scanning of all downloaded files and attachments (revert)
echo --- Disable scanning of all downloaded files and attachments (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableIOAVProtection"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableIOAVProtection' /f 2>$null"
:: ----------------------------------------------------------
:: Disable scanning files larger than 1 KB (minimum possible) (revert)
echo --- Disable scanning files larger than 1 KB (minimum possible) (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!IOAVMaxSize"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'IOAVMaxSize' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable file and program activity monitoring (revert)---
:: ----------------------------------------------------------
echo --- Disable file and program activity monitoring (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!DisableOnAccessProtection"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'DisableOnAccessProtection' /f 2>$null"
:: ----------------------------------------------------------
:: Disable bidirectional scan for incoming and outgoing file and program activities (revert)
echo --- Disable bidirectional scan for incoming and outgoing file and program activities (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection!RealTimeScanDirection"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection' /v 'RealTimeScanDirection' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable routine remediation (revert)-----------
:: ----------------------------------------------------------
echo --- Disable routine remediation (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender!DisableRoutinelyTakingAction"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender' /v 'DisableRoutinelyTakingAction' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Disable running scheduled auto-remediation (revert)----
:: ----------------------------------------------------------
echo --- Disable running scheduled auto-remediation (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Remediation!Scan_ScheduleDay"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Remediation' /v 'Scan_ScheduleDay' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable remediation actions (revert)-----------
:: ----------------------------------------------------------
echo --- Disable remediation actions (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Threats!Threats_ThreatSeverityDefaultAction"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Threats' /v 'Threats_ThreatSeverityDefaultAction' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction!5"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction' /v '5' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction!4"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction' /v '4' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction!3"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction' /v '3' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction!2"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction' /v '2' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction!1"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Threats\ThreatSeverityDefaultAction' /v '1' /f 2>$null"
:: ----------------------------------------------------------
:: Enable automatically purging items from quarantine folder (revert)
echo --- Enable automatically purging items from quarantine folder (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Quarantine!PurgeItemsAfterDelay"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Quarantine' /v 'PurgeItemsAfterDelay' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable signature verification before scanning (revert)--
:: ----------------------------------------------------------
echo --- Disable signature verification before scanning (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!CheckForSignaturesBeforeRunningScan"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'CheckForSignaturesBeforeRunningScan' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable creation of daily system restore points (revert)-
:: ----------------------------------------------------------
echo --- Disable creation of daily system restore points (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableRestorePoint"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableRestorePoint' /f 2>$null"
:: ----------------------------------------------------------
:: Minimize retention time for files in scan history (revert)
echo --- Minimize retention time for files in scan history (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!PurgeItemsAfterDelay"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'PurgeItemsAfterDelay' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Maximize days until mandatory catch-up scan (revert)---
:: ----------------------------------------------------------
echo --- Maximize days until mandatory catch-up scan (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!MissedScheduledScanCountBeforeCatchup"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'MissedScheduledScanCountBeforeCatchup' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable catch-up full scans (revert)-----------
:: ----------------------------------------------------------
echo --- Disable catch-up full scans (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableCatchupFullScan"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableCatchupFullScan' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable catch-up quick scans (revert)-----------
:: ----------------------------------------------------------
echo --- Disable catch-up quick scans (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableCatchupQuickScan"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableCatchupQuickScan' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable scan heuristics (revert)-------------
:: ----------------------------------------------------------
echo --- Disable scan heuristics (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableHeuristics"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableHeuristics' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable scanning when not idle (revert)----------
:: ----------------------------------------------------------
echo --- Disable scanning when not idle (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!ScanOnlyIfIdle"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'ScanOnlyIfIdle' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable scheduled anti-malware scanner (MRT) (revert)---
:: ----------------------------------------------------------
echo --- Disable scheduled anti-malware scanner (MRT) (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\MRT!DontOfferThroughWUAU"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\MRT' /v 'DontOfferThroughWUAU' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Minimize CPU usage during scans (revert)---------
:: ----------------------------------------------------------
echo --- Minimize CPU usage during scans (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!AvgCPULoadFactor"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'AvgCPULoadFactor' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Minimize CPU usage during idle scans (revert)-------
:: ----------------------------------------------------------
echo --- Minimize CPU usage during idle scans (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableCpuThrottleOnIdleScans"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableCpuThrottleOnIdleScans' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable e-mail scanning (revert)-------------
:: ----------------------------------------------------------
echo --- Disable e-mail scanning (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableEmailScanning"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableEmailScanning' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable script scanning (revert)-------------
:: ----------------------------------------------------------
echo --- Disable script scanning (revert)
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable reparse point scanning (revert)----------
:: ----------------------------------------------------------
echo --- Disable reparse point scanning (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableReparsePointScanning"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableReparsePointScanning' /f 2>$null"
:: ----------------------------------------------------------
:: Disable scanning mapped network drives during full scan (revert)
echo --- Disable scanning mapped network drives during full scan (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableScanningMappedNetworkDrivesForFullScan"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableScanningMappedNetworkDrivesForFullScan' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable network file scanning (revert)----------
:: ----------------------------------------------------------
echo --- Disable network file scanning (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableScanningNetworkFiles"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableScanningNetworkFiles' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable scanning packed executables (revert)-------
:: ----------------------------------------------------------
echo --- Disable scanning packed executables (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisablePackedExeScanning"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisablePackedExeScanning' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable scanning removable drives (revert)--------
:: ----------------------------------------------------------
echo --- Disable scanning removable drives (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableRemovableDriveScanning"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableRemovableDriveScanning' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable Defender archive file scanning (revert)------
:: ----------------------------------------------------------
echo --- Disable Defender archive file scanning (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!DisableArchiveScanning"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'DisableArchiveScanning' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Minimize scanning depth of archive files (revert)-----
:: ----------------------------------------------------------
echo --- Minimize scanning depth of archive files (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!ArchiveMaxDepth"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'ArchiveMaxDepth' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Minimize file size for scanning archive files (revert)--
:: ----------------------------------------------------------
echo --- Minimize file size for scanning archive files (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!ArchiveMaxSize"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'ArchiveMaxSize' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------------Disable scheduled scans (revert)-------------
:: ----------------------------------------------------------
echo --- Disable scheduled scans (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!ScheduleDay"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'ScheduleDay' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable randomizing scheduled task times (revert)-----
:: ----------------------------------------------------------
echo --- Disable randomizing scheduled task times (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender!RandomizeScheduleTaskTimes"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender' /v 'RandomizeScheduleTaskTimes' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable scheduled full-scans (revert)-----------
:: ----------------------------------------------------------
echo --- Disable scheduled full-scans (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!ScanParameters"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'ScanParameters' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Minimize daily quick scan frequency (revert)-------
:: ----------------------------------------------------------
echo --- Minimize daily quick scan frequency (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Scan!QuickScanInterval"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Scan' /v 'QuickScanInterval' /f 2>$null"
:: ----------------------------------------------------------
:: Disable scanning after security intelligence (signature) update (revert)
echo --- Disable scanning after security intelligence (signature) update (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!DisableScanOnUpdate"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'DisableScanOnUpdate' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable Defender Antivirus AMSI provider (revert)-----
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus AMSI provider (revert)
:: Restore registry key: HKLM\SOFTWARE\Microsoft\AMSI\Providers\{2781761E-28E0-4109-99FE-B9D127C57AFE} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Microsoft\AMSI\Providers\{2781761E-28E0-4109-99FE-B9D127C57AFE}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\SOFTWARE\WOW6432Node\Microsoft\AMSI\Providers\{2781761E-28E0-4109-99FE-B9D127C57AFE} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\WOW6432Node\Microsoft\AMSI\Providers\{2781761E-28E0-4109-99FE-B9D127C57AFE}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\SOFTWARE\Microsoft\Internet Explorer\Extension Validation\{2781761E-28E0-4109-99FE-B9D127C57AFE} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Microsoft\Internet Explorer\Extension Validation\{2781761E-28E0-4109-99FE-B9D127C57AFE}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\Software\Classes\CLSID\{2781761E-28E0-4109-99FE-B9D127C57AFE} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\CLSID\{2781761E-28E0-4109-99FE-B9D127C57AFE} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpOav.dll"  as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{2781761E-28E1-4109-99FE-B9D127C57AFE} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Microsoft\Internet Explorer\Extension Validation\{2781761E-28E1-4109-99FE-B9D127C57AFE} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Microsoft\Internet Explorer\Extension Validation\{2781761E-28E1-4109-99FE-B9D127C57AFE}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2781761E-28E1-4109-99FE-B9D127C57AFE} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{2781761E-28E1-4109-99FE-B9D127C57AFE}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Defender Antivirus UAC AMSI provider (revert)---
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus UAC AMSI provider (revert)
:: Restore registry key: HKLM\Software\Microsoft\AMSI\UacProviders\{2781761E-28E2-4109-99FE-B9D127C57AFE} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\Software\Microsoft\AMSI\UacProviders\{2781761E-28E2-4109-99FE-B9D127C57AFE}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\Software\Classes\CLSID\{2781761E-28E2-4109-99FE-B9D127C57AFE} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\Wow6432Node\CLSID\{2781761E-28E2-4109-99FE-B9D127C57AFE} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\Software\Classes\Wow6432Node\CLSID\{2781761E-28E2-4109-99FE-B9D127C57AFE}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\Software\Classes\AppID\{2781761E-28E2-4109-99FE-B9D127C57AFE} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\Wow6432Node\AppID\{2781761E-28E2-4109-99FE-B9D127C57AFE} as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Antimalware Scan Interface (AMSI) for current user (revert)
echo --- Disable Antimalware Scan Interface (AMSI) for current user (revert)
:: Delete the registry value "HKCU\Software\Microsoft\Windows Script\Settings!AmsiEnable"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\Software\Microsoft\Windows Script\Settings' /v 'AmsiEnable' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus command-line library (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus command-line library (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpClient.dll"  as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES(X86)%\Windows Defender\MpClient.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus command-line utility (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus command-line utility (revert)
:: Remove configuration preventing "MpCmdRun.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpCmdRun.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpCmdRun.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "MpCmdRun.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpCmdRun.exe"  as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES(X86)%\Windows Defender\MpCmdRun.exe"  as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-21H2.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable Defender Antivirus WMI management (revert)----
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus WMI management (revert)
:: Restore registry key: HKLM\Software\Classes\CLSID\{A7C452EF-8E9F-42EB-9F2B-245613CA0DC9} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\ProtectionManagement.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Microsoft Security Client Policy Configuration Tool (revert)
echo --- Disable Microsoft Security Client Policy Configuration Tool (revert)
:: Remove configuration preventing "ConfigSecurityPolicy.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ConfigSecurityPolicy.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ConfigSecurityPolicy.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "ConfigSecurityPolicy.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\ConfigSecurityPolicy.exe"  as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus remote configuration (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus remote configuration (revert)
:: Restore registry key: HKLM\Software\Classes\CLSID\{195B4D07-3DE2-4744-BBF2-D90121AE785B} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\DefenderCSP.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Disable Defender Antivirus remote commands (revert)----
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus remote commands (revert)
:: Restore registry key: HKLM\Software\Classes\CLSID\{361290c0-cb1b-49ae-9f3e-ba1cbe5dab35} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{8a696d12-576b-422e-9712-01b9dd84b446} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{DACA056E-216A-4FD1-84A6-C306A017ECEC} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpProvider.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: Minimize Defender updates to completed gradual release cycles (revert)
echo --- Minimize Defender updates to completed gradual release cycles (revert)
:: ----------------------------------------------------------
:: Minimize Defender engine updates to completed release cycles (revert)
echo --- Minimize Defender engine updates to completed release cycles (revert)
:: ----------------------------------------------------------
:: Minimize Defender platform updates to completed release cycles (revert)
echo --- Minimize Defender platform updates to completed release cycles (revert)
:: ----------------------------------------------------------
:: Minimize Defender definition updates to completed gradual release cycles (revert)
echo --- Minimize Defender definition updates to completed gradual release cycles (revert)
:: ----------------------------------------------------------
:: Disable forced security intelligence (signature) updates from Microsoft Update (revert)
echo --- Disable forced security intelligence (signature) updates from Microsoft Update (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!ForceUpdateFromMU"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'ForceUpdateFromMU' /f 2>$null"
:: ----------------------------------------------------------
:: Disable security intelligence (signature) updates when running on battery power (revert)
echo --- Disable security intelligence (signature) updates when running on battery power (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!DisableScheduledSignatureUpdateOnBattery"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'DisableScheduledSignatureUpdateOnBattery' /f 2>$null"
:: ----------------------------------------------------------
:: Disable startup check for latest virus and spyware security intelligence (signature) (revert)
echo --- Disable startup check for latest virus and spyware security intelligence (signature) (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!UpdateOnStartUp"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'UpdateOnStartUp' /f 2>$null"
:: ----------------------------------------------------------
:: Disable catch-up security intelligence (signature) updates (revert)
echo --- Disable catch-up security intelligence (signature) updates (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!SignatureUpdateCatchupInterval"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'SignatureUpdateCatchupInterval' /f 2>$null"
:: ----------------------------------------------------------
:: Minimize spyware security intelligence (signature) updates (revert)
echo --- Minimize spyware security intelligence (signature) updates (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!ASSignatureDue"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'ASSignatureDue' /f 2>$null"
:: ----------------------------------------------------------
:: Minimize virus security intelligence (signature) updates (revert)
echo --- Minimize virus security intelligence (signature) updates (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!AVSignatureDue"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'AVSignatureDue' /f 2>$null"
:: ----------------------------------------------------------
:: Disable security intelligence (signature) update on startup (revert)
echo --- Disable security intelligence (signature) update on startup (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!DisableUpdateOnStartupWithoutEngine"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'DisableUpdateOnStartupWithoutEngine' /f 2>$null"
:: ----------------------------------------------------------
:: Disable automatic checks for security intelligence (signature) updates (revert)
echo --- Disable automatic checks for security intelligence (signature) updates (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!ScheduleDay"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'ScheduleDay' /f 2>$null"
:: ----------------------------------------------------------
:: Minimize checks for security intelligence (signature) updates (revert)
echo --- Minimize checks for security intelligence (signature) updates (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!SignatureUpdateInterval"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'SignatureUpdateInterval' /f 2>$null"
:: ----------------------------------------------------------
:: Disable definition updates via WSUS and Microsoft Malware Protection Center (revert)
echo --- Disable definition updates via WSUS and Microsoft Malware Protection Center (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!CheckAlternateHttpLocation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'CheckAlternateHttpLocation' /f 2>$null"
:: ----------------------------------------------------------
:: Disable definition updates through both WSUS and Windows Update (revert)
echo --- Disable definition updates through both WSUS and Windows Update (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates!CheckAlternateDownloadLocation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates' /v 'CheckAlternateDownloadLocation' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable Windows Defender boot logging (revert)------
:: ----------------------------------------------------------
echo --- Disable Windows Defender boot logging (revert)
:: Set the registry value "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger!Start"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger' /v 'Start' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Set the registry value "HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger!Start"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger' /v 'Start' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: Disable Defender ETW provider (Windows Event Logs) (revert)
echo --- Disable Defender ETW provider (Windows Event Logs) (revert)
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/Operational' /v 'Enabled' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Windows Defender/WHC' /v 'Enabled' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: ----------------------------------------------------------
:: Minimize Windows software trace preprocessor (WPP Software Tracing) (revert)
echo --- Minimize Windows software trace preprocessor (WPP Software Tracing) (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting!WppTracingLevel"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting' /v 'WppTracingLevel' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Microsoft Defender Antivirus Network Inspection System Driver" service (revert)
echo --- Disable "Microsoft Defender Antivirus Network Inspection System Driver" service (revert)
:: Restore the service `WdNisDrv` using TrustedInstaller privileges
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\WdNisDrv.sys" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus device filter driver (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus device filter driver (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\WdDevFlt.sys" with additional permissions 
:: ----------------------------------------------------------
:: Disable Defender Antivirus network inspection service (revert)
echo --- Disable Defender Antivirus network inspection service (revert)
:: Restore the service `WdNisSvc` using TrustedInstaller privileges
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\NisSrv.exe"  as TrustedInstaller
:: Remove configuration preventing "NisSrv.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\NisSrv.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\NisSrv.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "NisSrv.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable Microsoft Defender Core Service (revert)-----
:: ----------------------------------------------------------
echo --- Disable Microsoft Defender Core Service (revert)
:: Remove configuration preventing "MpDefenderCoreService.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpDefenderCoreService.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpDefenderCoreService.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "MpDefenderCoreService.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: Suggest restarting computer for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'For the changes to fully take effect, please restart your computer.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Disable Defender Antivirus service (breaks `Set-MpPreference` cmdlet) (revert)
echo --- Disable Defender Antivirus service (breaks `Set-MpPreference` cmdlet) (revert)
:: Restore the service `WinDefend` using TrustedInstaller privileges
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MsMpEng.exe"  as TrustedInstaller
:: Remove configuration preventing "MsMpEng.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEng.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEng.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "MsMpEng.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus service in Safe Mode (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus service in Safe Mode (revert)
:: Restore registry key: HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\WinDefend 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\WinDefend'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\WinDefend 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\WinDefend'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: Disable Defender Antivirus service always-on state (revert)
echo --- Disable Defender Antivirus service always-on state (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender!ServiceKeepAlive"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender' /v 'ServiceKeepAlive' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware!ServiceKeepAlive"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware' /v 'ServiceKeepAlive' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus service high-priority startup (revert)
echo --- Disable Defender Antivirus service high-priority startup (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender!AllowFastServiceStartup"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender' /v 'AllowFastServiceStartup' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware!AllowFastServiceStartup"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Microsoft Antimalware' /v 'AllowFastServiceStartup' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Antivirus service automatic launch (revert)
echo --- Disable Defender Antivirus service automatic launch (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender!ServiceStartStates"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus service active state (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus service active state (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender!IsServiceRunning"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable Defender Antivirus data storage location (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus data storage location (revert)
:: Restore the registry value "ProductAppDataPath" in key "HKLM\SOFTWARE\Microsoft\Windows Defender" to its original value 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable Defender Antivirus service module (revert)----
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus service module (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpSvc.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Defender Antivirus antimalware engine (revert)--
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus antimalware engine (revert)
:: Restore files matching pattern: "%PROGRAMDATA%\Microsoft\Windows Defender\Definition Updates\Default\MpEngine.dll"  as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMDATA%\Microsoft\Windows Defender\Definition Updates\{*}\mpengine.dll"  as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMDATA%\Microsoft\Windows Defender\Definition Updates\StableEngineEtwLocation\mpengine_etw.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus communication module (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus communication module (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpCommu.dll"  as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Defender Antivirus service communication with apps (revert)
echo --- Disable Defender Antivirus service communication with apps (revert)
:: Restore registry key: HKLM\Software\Classes\CLSID\{A2D75874-6750-4931-94C1-C99D3BC9D0C7} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\AppID\{A79DB36D-6218-48e6-9EC9-DCBA9A39BF0F} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\TypeLib\{8C389764-F036-48F2-9AE2-88C260DCF43B} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MsMpCom.dll"  as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{AC30C2BA-0109-403D-9D8E-140BB470379C} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{E2D74550-8E41-460E-BB51-52E1F9522134} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{CDFED399-7999-4309-B064-1EDE04BC580D} as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Defender Antivirus cache maintenance task (revert)
echo --- Disable Defender Antivirus cache maintenance task (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable Defender Antivirus cleanup task (revert)-----
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus cleanup task (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Windows Defender\Windows Defender Cleanup`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus scheduled scan task (revert)--
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus scheduled scan task (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Defender Antivirus verification task (revert)---
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus verification task (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\Windows Defender\Windows Defender Verification`
:: ----------------------------------------------------------
:: Disable Defender Antivirus copy accelerator library (revert)
echo --- Disable Defender Antivirus copy accelerator library (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpDetoursCopyAccelerator.dll"  as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-21H2.
:: Restore files matching pattern: "%PROGRAMFILES(X86)%\Windows Defender\MpDetoursCopyAccelerator.dll"  as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-21H2.
:: ----------------------------------------------------------
:: Disable Defender Antivirus copy accelerator utility (revert)
echo --- Disable Defender Antivirus copy accelerator utility (revert)
:: Remove configuration preventing "MpCopyAccelerator.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpCopyAccelerator.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpCopyAccelerator.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "MpCopyAccelerator.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpCopyAccelerator.exe"  as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Defender Antivirus file activity tracking library (revert)
echo --- Disable Defender Antivirus file activity tracking library (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpDetours.dll"  as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-21H2.
:: Restore files matching pattern: "%PROGRAMFILES(X86)%\Windows Defender\MpDetours.dll"  as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-21H2.
:: ----------------------------------------------------------
:: Disable Defender Antivirus file risk estimation library (revert)
echo --- Disable Defender Antivirus file risk estimation library (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\winshfhc.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\winshfhc.dll" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable firewall via command-line utility (revert)----
:: ----------------------------------------------------------
echo --- Disable firewall via command-line utility (revert)
PowerShell -ExecutionPolicy Unrestricted -Command "if(!(Get-Command 'netsh' -ErrorAction Ignore)) { throw '"^""netsh"^"" does not exist, is system installed correctly?'; }; $message=netsh advfirewall set allprofiles state on 2>&1; if($?) { Write-Host "^""Successfully enabled firewall."^""; } else { if($message -like '*Firewall service*') { Write-Warning 'Cannot use CLI because MpsSvc or MpsDrv is not running. Try to enable them (revert) -> reboot -> re-run this?'; } else { throw "^""Cannot enable: $message"^""; }; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable Firewall via registry (revert)----------
:: ----------------------------------------------------------
echo --- Disable Firewall via registry (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile' /v 'EnableFirewall' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile' /v 'EnableFirewall' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' /v 'EnableFirewall' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile' /v 'EnableFirewall' /f 2>$null"
:: Set the registry value "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile' /v 'EnableFirewall' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Set the registry value "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile' /v 'EnableFirewall' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Set the registry value "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile' /v 'EnableFirewall' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Delete the registry value "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PrivateProfile!EnableFirewall"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PrivateProfile' /v 'EnableFirewall' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Firewall & network protection" section in "Windows Security" (revert)
echo --- Disable "Firewall ^& network protection" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Firewall and network protection!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Firewall and network protection' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Windows Defender Firewall Authorization Driver" service (breaks Microsoft Store, `netsh advfirewall`, winget, Windows Sandbox, Docker, WSL) (revert)
echo --- Disable "Windows Defender Firewall Authorization Driver" service (breaks Microsoft Store, `netsh advfirewall`, winget, Windows Sandbox, Docker, WSL) (revert)
:: Restore the service `mpsdrv` 
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceQuery = 'mpsdrv'; $defaultStartupMode = 'Manual'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if (!$service) { Write-Warning "^""Service query `"^""$serviceQuery`"^"" did not yield and results. Revert cannot proceed."^""; Exit 1; }; $serviceName = $service.Name; Write-Host "^""Restoring registry settings for service `"^""$serviceName`"^"" to default startup mode `"^""$defaultStartupMode`"^""."^""; <# -- 2. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if (-Not (Test-Path $registryKey)) { Write-Warning "^""`"^""$registryKey`"^"" is not found in registry. Revert cannot proceed."^""; Exit 1; }; <# -- 3. Enable if not already enabled #>; $defaultStartupRegValue = switch ($defaultStartupMode) { 'Boot'      { 0 }; 'System'    { 1 }; 'Automatic' { 2 }; 'Manual'    { 3 }; 'Disabled'  { 4 }; default { Write-Error "^""Error: Unknown startup mode specified: `"^""$defaultStartupMode`"^"". Revert cannot proceed."^""; return; }; }; if ($(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq $defaultStartupRegValue) { Write-Host "^""`"^""$serviceName`"^"" is has already default startup mode: `"^""$defaultStartupMode`"^""."^""; } else { try { Set-ItemProperty $registryKey -Name Start -Value $defaultStartupRegValue -Force; Write-Host "^""Successfully restored `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, trying to start it."^""; try { Start-Service -Name $serviceName -ErrorAction Stop; Write-Host 'Service started successfully.'; } catch { Write-Warning "^""Failed to restart service. It will be started after reboot. Error: $($_.Exception.Message)"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\mpsdrv.sys" with additional permissions 
:: Suggest restarting computer for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'For the changes to fully take effect, please restart your computer.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: Disable "Windows Defender Firewall" service (breaks Microsoft Store, `netsh advfirewall`, winget, Windows Sandbox, Docker, WSL) (revert)
echo --- Disable "Windows Defender Firewall" service (breaks Microsoft Store, `netsh advfirewall`, winget, Windows Sandbox, Docker, WSL) (revert)
:: Restore the service `MpsSvc` 
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceQuery = 'MpsSvc'; $defaultStartupMode = 'Automatic'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if (!$service) { Write-Warning "^""Service query `"^""$serviceQuery`"^"" did not yield and results. Revert cannot proceed."^""; Exit 1; }; $serviceName = $service.Name; Write-Host "^""Restoring registry settings for service `"^""$serviceName`"^"" to default startup mode `"^""$defaultStartupMode`"^""."^""; <# -- 2. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if (-Not (Test-Path $registryKey)) { Write-Warning "^""`"^""$registryKey`"^"" is not found in registry. Revert cannot proceed."^""; Exit 1; }; <# -- 3. Enable if not already enabled #>; $defaultStartupRegValue = switch ($defaultStartupMode) { 'Boot'      { 0 }; 'System'    { 1 }; 'Automatic' { 2 }; 'Manual'    { 3 }; 'Disabled'  { 4 }; default { Write-Error "^""Error: Unknown startup mode specified: `"^""$defaultStartupMode`"^"". Revert cannot proceed."^""; return; }; }; if ($(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq $defaultStartupRegValue) { Write-Host "^""`"^""$serviceName`"^"" is has already default startup mode: `"^""$defaultStartupMode`"^""."^""; } else { try { Set-ItemProperty $registryKey -Name Start -Value $defaultStartupRegValue -Force; Write-Host "^""Successfully restored `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, trying to start it."^""; try { Start-Service -Name $serviceName -ErrorAction Stop; Write-Host 'Service started successfully.'; } catch { Write-Warning "^""Failed to restart service. It will be started after reboot. Error: $($_.Exception.Message)"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\mpssvc.dll" with additional permissions 
:: Suggest restarting computer for changes to take effect
PowerShell -ExecutionPolicy Unrestricted -Command "$message = 'For the changes to fully take effect, please restart your computer.'; $warn =  $false; if ($warn) { Write-Warning "^""$message"^""; } else { Write-Host "^""Note: "^"" -ForegroundColor Blue -NoNewLine; Write-Output "^""$message"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Microsoft Security WFP callout driver (revert)--
:: ----------------------------------------------------------
echo --- Disable Microsoft Security WFP callout driver (revert)
:: Restore service(s) to default state: `MsSecWfp`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'MsSecWfp'; $defaultStartupMode = 'Manual'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\drivers\mssecwfp.sys" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\System32\mssecwfpu.dll" with additional permissions 
:: ----------------------------------------------------------
:: Disable "Windows Defender Advanced Threat Protection Service" service (revert)
echo --- Disable "Windows Defender Advanced Threat Protection Service" service (revert)
:: Restore the service `Sense` 
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceQuery = 'Sense'; $defaultStartupMode = 'Manual'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if (!$service) { Write-Warning "^""Service query `"^""$serviceQuery`"^"" did not yield and results. Revert cannot proceed."^""; Exit 1; }; $serviceName = $service.Name; Write-Host "^""Restoring registry settings for service `"^""$serviceName`"^"" to default startup mode `"^""$defaultStartupMode`"^""."^""; <# -- 2. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if (-Not (Test-Path $registryKey)) { Write-Warning "^""`"^""$registryKey`"^"" is not found in registry. Revert cannot proceed."^""; Exit 1; }; <# -- 3. Enable if not already enabled #>; $defaultStartupRegValue = switch ($defaultStartupMode) { 'Boot'      { 0 }; 'System'    { 1 }; 'Automatic' { 2 }; 'Manual'    { 3 }; 'Disabled'  { 4 }; default { Write-Error "^""Error: Unknown startup mode specified: `"^""$defaultStartupMode`"^"". Revert cannot proceed."^""; return; }; }; if ($(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq $defaultStartupRegValue) { Write-Host "^""`"^""$serviceName`"^"" is has already default startup mode: `"^""$defaultStartupMode`"^""."^""; } else { try { Set-ItemProperty $registryKey -Name Start -Value $defaultStartupRegValue -Force; Write-Host "^""Successfully restored `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, trying to start it."^""; try { Start-Service -Name $serviceName -ErrorAction Stop; Write-Host 'Service started successfully.'; } catch { Write-Warning "^""Failed to restart service. It will be started after reboot. Error: $($_.Exception.Message)"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender Advanced Threat Protection\MsSense.exe" with additional permissions 
:: ----------------------------------------------------------
:: Disable Microsoft Data Loss Prevention (DLP) service (revert)
echo --- Disable Microsoft Data Loss Prevention (DLP) service (revert)
:: Restore service(s) to default state: `MDDlpSvc`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'MDDlpSvc'; $defaultStartupMode = 'Automatic'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpDlpService.exe"  as TrustedInstaller
:: Remove configuration preventing "MpDlpService.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpDlpService.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpDlpService.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "MpDlpService.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------
:: Disable Defender for Endpoint remote configuration (revert)
echo --- Disable Defender for Endpoint remote configuration (revert)
:: Restore registry key: HKLM\Software\Classes\CLSID\{FEEE9C23-C4E2-4A34-8C73-FE8F9786C8B4} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender Advanced Threat Protection\WATPCSP.dll" with additional permissions 
:: ----------------------------------------------------------
:: Disable Defender Antivirus DLP command-line utility (revert)
echo --- Disable Defender Antivirus DLP command-line utility (revert)
:: Remove configuration preventing "MpDlpCmd.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpDlpCmd.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpDlpCmd.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "MpDlpCmd.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpDlpCmd.exe"  as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-21H2.
:: ----------------------------------------------------------
:: Disable Defender Antivirus Endpoint Data Loss Prevention (DLP) module (revert)
echo --- Disable Defender Antivirus Endpoint Data Loss Prevention (DLP) module (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\endpointdlp.dll"  as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-21H2.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable outdated SmartScreen settings interface (revert)-
:: ----------------------------------------------------------
echo --- Disable outdated SmartScreen settings interface (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SmartScreenSettings.exe" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\SmartScreenSettings.exe" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable SmartScreen checks for apps and files (revert)--
:: ----------------------------------------------------------
echo --- Disable SmartScreen checks for apps and files (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer!SmartScreenEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' /v 'SmartScreenEnabled' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer!SmartScreenEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer' /v 'SmartScreenEnabled' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\System!EnableSmartScreen"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'EnableSmartScreen' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Enable SmartScreen warning dismissal for apps (revert)--
:: ----------------------------------------------------------
echo --- Enable SmartScreen warning dismissal for apps (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\System!ShellSmartScreenLevel"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'ShellSmartScreenLevel' /f 2>$null"
:: ----------------------------------------------------------
:: Disable SmartScreen "App Install Control" feature (revert)
echo --- Disable SmartScreen "App Install Control" feature (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen!ConfigureAppInstall"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen' /v 'ConfigureAppInstall' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen!ConfigureAppInstallControlEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen' /v 'ConfigureAppInstallControlEnabled' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer!AicEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' /v 'AicEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: Disable SmartScreen web content checking for Store apps (revert)
echo --- Disable SmartScreen web content checking for Store apps (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost!EnableWebContentEvaluation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' /v 'EnableWebContentEvaluation' /f 2>$null"
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$revertData = '1'; reg add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' /v 'Enabled' /t 'REG_DWORD' /d "^""$revertData"^"" /f"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppHost!EnableWebContentEvaluation"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppHost' /v 'EnableWebContentEvaluation' /f 2>$null"
:: ----------------------------------------------------------
:: Enable SmartScreen warning dismissal for Store apps (revert)
echo --- Enable SmartScreen warning dismissal for Store apps (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost!PreventOverride"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' /v 'PreventOverride' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost!PreventOverride"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' /v 'PreventOverride' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------------Disable Edge SmartScreen (revert)-------------
:: ----------------------------------------------------------
echo --- Disable Edge SmartScreen (revert)
:: Restore "SmartScreenEnabled" Edge policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Edge!SmartScreenEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'SmartScreenEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Edge SmartScreen for potentially unwanted apps (revert)
echo --- Disable Edge SmartScreen for potentially unwanted apps (revert)
:: Restore "SmartScreenPuaEnabled" Edge policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Edge!SmartScreenPuaEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'SmartScreenPuaEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Enable Edge SmartScreen warning dismissal (revert)----
:: ----------------------------------------------------------
echo --- Enable Edge SmartScreen warning dismissal (revert)
:: Restore "PreventSmartScreenPromptOverride" Edge policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Edge!PreventSmartScreenPromptOverride"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'PreventSmartScreenPromptOverride' /f 2>$null"
:: ----------------------------------------------------------
:: Enable Edge SmartScreen warning dismissal for files (revert)
echo --- Enable Edge SmartScreen warning dismissal for files (revert)
:: Restore "PreventSmartScreenPromptOverrideForFiles" Edge policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Edge!PreventSmartScreenPromptOverrideForFiles"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'PreventSmartScreenPromptOverrideForFiles' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable Edge SmartScreen DNS requests (revert)------
:: ----------------------------------------------------------
echo --- Disable Edge SmartScreen DNS requests (revert)
:: Restore "SmartScreenDnsRequestsEnabled" Edge policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Edge!SmartScreenDnsRequestsEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'SmartScreenDnsRequestsEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Edge SmartScreen checks on downloads from trusted sources (revert)
echo --- Disable Edge SmartScreen checks on downloads from trusted sources (revert)
:: Restore "SmartScreenForTrustedDownloadsEnabled" Edge policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Edge!SmartScreenForTrustedDownloadsEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'SmartScreenForTrustedDownloadsEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable outdated Edge SmartScreen library update (revert)-
:: ----------------------------------------------------------
echo --- Disable outdated Edge SmartScreen library update (revert)
:: Restore "NewSmartScreenLibraryEnabled" Edge policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Edge!NewSmartScreenLibraryEnabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'NewSmartScreenLibraryEnabled' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Edge (Legacy) SmartScreen (revert)--------
:: ----------------------------------------------------------
echo --- Disable Edge (Legacy) SmartScreen (revert)
:: Restore "EnabledV9" Edge (Legacy) policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter!EnabledV9"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' /v 'EnabledV9' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter!EnabledV9"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter' /v 'EnabledV9' /f 2>$null"
:: ----------------------------------------------------------
:: Enable Edge (Legacy) SmartScreen warning dismissal (revert)
echo --- Enable Edge (Legacy) SmartScreen warning dismissal (revert)
:: Restore "PreventOverride" Edge (Legacy) policy
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter!PreventOverride"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' /v 'PreventOverride' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter!PreventOverride"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter' /v 'PreventOverride' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable outdated Internet Explorer SmartScreen (revert)--
:: ----------------------------------------------------------
echo --- Disable outdated Internet Explorer SmartScreen (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0!2301"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0' /v '2301' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1!2301"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1' /v '2301' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2!2301"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2' /v '2301' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3!2301"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '2301' /f 2>$null"
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4!2301"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4' /v '2301' /f 2>$null"
:: ----------------------------------------------------------
:: Disable outdated Internet Explorer SmartScreen Filter component (revert)
echo --- Disable outdated Internet Explorer SmartScreen Filter component (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\ieapfltr.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\ieapfltr.dll" with additional permissions 
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{E48B2549-D510-4A76-8A5F-FC126A6215F0} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{E48B2549-D510-4A76-8A5F-FC126A6215F0} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{3BC4EE9F-1FC1-44DB-81FA-AD94DEC7AF30} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{3BC4EE9F-1FC1-44DB-81FA-AD94DEC7AF30} as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----------Disable SmartScreen process (revert)-----------
:: ----------------------------------------------------------
echo --- Disable SmartScreen process (revert)
:: Remove configuration preventing "smartscreen.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "smartscreen.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\smartscreen.exe" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----------Disable SmartScreen libraries (revert)----------
:: ----------------------------------------------------------
echo --- Disable SmartScreen libraries (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\smartscreen.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\System32\smartscreenps.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\smartscreen.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\smartscreenps.dll" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable SmartScreen integrations (revert)---------
:: ----------------------------------------------------------
echo --- Disable SmartScreen integrations (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{741baa78-e96f-466c-9ffa-81af5ce4cd59} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{741baa78-e96f-466c-9ffa-81af5ce4cd59} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{a3104ea9-a816-4fdc-860c-75408a04b686} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{a3104ea9-a816-4fdc-860c-75408a04b686} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{16ae6386-0aa2-45fc-aab2-f2ee3a0f3188} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{16ae6386-0aa2-45fc-aab2-f2ee3a0f3188} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{680d04e6-9661-4ac5-b962-58b112ffa5e6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{680d04e6-9661-4ac5-b962-58b112ffa5e6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{9ad9b845-b683-493e-8d39-45a56d54617d} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{9ad9b845-b683-493e-8d39-45a56d54617d} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{e9444d66-3ff9-5410-8984-f9063f825683} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{e9444d66-3ff9-5410-8984-f9063f825683} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{69c26f3c-53aa-56cc-818f-4be79004cd02} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{69c26f3c-53aa-56cc-818f-4be79004cd02} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{60f00258-24f8-5460-bb2d-853a614a50ec} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{60f00258-24f8-5460-bb2d-853a614a50ec} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{c729ad47-6f3a-46f4-af74-3b5c3311e6ed} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{c729ad47-6f3a-46f4-af74-3b5c3311e6ed} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{7fdde05c-d2db-495b-b06d-4a8d84f3ab99} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{7fdde05c-d2db-495b-b06d-4a8d84f3ab99} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{b2b6814f-02c2-5b0c-9e14-159eb77f4462} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{b2b6814f-02c2-5b0c-9e14-159eb77f4462} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{aad9a740-4131-5fe0-9888-c925750b8a99} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{aad9a740-4131-5fe0-9888-c925750b8a99} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{1d5bc3a2-a3ff-4517-bb16-25bf18ef7378} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{1d5bc3a2-a3ff-4517-bb16-25bf18ef7378} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{f84b2c99-2f3d-5877-bf78-4f40f6bd25c0} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{f84b2c99-2f3d-5877-bf78-4f40f6bd25c0} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{d164f201-3f19-588a-a21e-06c60651d335} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{d164f201-3f19-588a-a21e-06c60651d335} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{a774d785-2808-4471-a254-ab93932b61ea} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{a774d785-2808-4471-a254-ab93932b61ea} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{29A3AB33-0FD7-44F5-9BFF-C0B6C081FBFB} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{29A3AB33-0FD7-44F5-9BFF-C0B6C081FBFB} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{3474d734-3408-4471-a344-a3439343634a} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{3474d734-3408-4471-a344-a3439343634a} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{48748dc6-576c-47c0-8169-b99cc31a68fe} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{48748dc6-576c-47c0-8169-b99cc31a68fe} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{0b3418c4-edbd-5275-a27d-c814665bd20b} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{0b3418c4-edbd-5275-a27d-c814665bd20b} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{e406ebb7-b140-562f-bcbc-40f0ef479d38} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{e406ebb7-b140-562f-bcbc-40f0ef479d38} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{67e7f99b-1b65-4343-825d-eb17c9681805} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{67e7f99b-1b65-4343-825d-eb17c9681805} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{56ed2384-8491-4fbc-8f1d-141faf905d85} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{56ed2384-8491-4fbc-8f1d-141faf905d85} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{c4c9b336-6104-586e-b35c-9f9029afb178} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{c4c9b336-6104-586e-b35c-9f9029afb178} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{235e004e-c711-5d74-8895-25412ca30088} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{235e004e-c711-5d74-8895-25412ca30088} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{ad6db2cf-0c8d-438b-b25d-9a9a82903b2b} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{ad6db2cf-0c8d-438b-b25d-9a9a82903b2b} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{d9dc3975-1062-470a-994c-409151ff8f54} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{d9dc3975-1062-470a-994c-409151ff8f54} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{343baa78-e34f-466c-9ffa-81af5ce4cd34} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{343baa78-e34f-466c-9ffa-81af5ce4cd34} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{377f919e-1b1a-5ca1-9ac0-70f57dcf5f61} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{377f919e-1b1a-5ca1-9ac0-70f57dcf5f61} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{1b988c32-1bc7-52fa-83ba-0b97e79c878b} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{1b988c32-1bc7-52fa-83ba-0b97e79c878b} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\AppId\{a463fcb9-6b1c-4e0d-a80b-a2ca7999e25d} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\AppId\{a463fcb9-6b1c-4e0d-a80b-a2ca7999e25d} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{a463fcb9-6b1c-4e0d-a80b-a2ca7999e25d} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{a463fcb9-6b1c-4e0d-a80b-a2ca7999e25d} as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Internal.Security.SmartScreen.EventLogger as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Internal.Security.SmartScreen.UriReputationService as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Internal.Security.SmartScreen.AppReputationService as TrustedInstaller
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection Web background services (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection Web background services (revert)
:: Restore service(s) to default state: `webthreatdefsvc`
:: This operation will not run on Windows versions earlier than Windows11-22H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $serviceName = 'webthreatdefsvc'; $defaultStartupMode = 'Manual'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\webthreatdefsvc.dll" with additional permissions 
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Restore per-user "webthreatdefusersvc" service to its default configuration for all users
:: Restore the service `webthreatdefusersvc` 
:: This operation will not run on Windows versions earlier than Windows11-22H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $serviceQuery = 'webthreatdefusersvc'; $defaultStartupMode = 'Automatic'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if (!$service) { Write-Warning "^""Service query `"^""$serviceQuery`"^"" did not yield and results. Revert cannot proceed."^""; Exit 1; }; $serviceName = $service.Name; Write-Host "^""Restoring registry settings for service `"^""$serviceName`"^"" to default startup mode `"^""$defaultStartupMode`"^""."^""; <# -- 2. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if (-Not (Test-Path $registryKey)) { Write-Warning "^""`"^""$registryKey`"^"" is not found in registry. Revert cannot proceed."^""; Exit 1; }; <# -- 3. Enable if not already enabled #>; $defaultStartupRegValue = switch ($defaultStartupMode) { 'Boot'      { 0 }; 'System'    { 1 }; 'Automatic' { 2 }; 'Manual'    { 3 }; 'Disabled'  { 4 }; default { Write-Error "^""Error: Unknown startup mode specified: `"^""$defaultStartupMode`"^"". Revert cannot proceed."^""; return; }; }; if ($(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq $defaultStartupRegValue) { Write-Host "^""`"^""$serviceName`"^"" is has already default startup mode: `"^""$defaultStartupMode`"^""."^""; } else { try { Set-ItemProperty $registryKey -Name Start -Value $defaultStartupRegValue -Force; Write-Host "^""Successfully restored `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, trying to start it."^""; try { Start-Service -Name $serviceName -ErrorAction Stop; Write-Host 'Service started successfully.'; } catch { Write-Warning "^""Failed to restart service. It will be started after reboot. Error: $($_.Exception.Message)"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore per-user "webthreatdefusersvc" service to its default configuration for individual user accounts
:: Restore the service `webthreatdefusersvc_*` 
:: This operation will not run on Windows versions earlier than Windows11-22H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; $serviceQuery = 'webthreatdefusersvc_*'; $defaultStartupMode = 'Automatic'; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceQuery -ErrorAction SilentlyContinue; if (!$service) { Write-Warning "^""Service query `"^""$serviceQuery`"^"" did not yield and results. Revert cannot proceed."^""; Exit 1; }; $serviceName = $service.Name; Write-Host "^""Restoring registry settings for service `"^""$serviceName`"^"" to default startup mode `"^""$defaultStartupMode`"^""."^""; <# -- 2. Skip if service info is not found in registry #>; $registryKey = "^""HKLM:\SYSTEM\CurrentControlSet\Services\$serviceName"^""; if (-Not (Test-Path $registryKey)) { Write-Warning "^""`"^""$registryKey`"^"" is not found in registry. Revert cannot proceed."^""; Exit 1; }; <# -- 3. Enable if not already enabled #>; $defaultStartupRegValue = switch ($defaultStartupMode) { 'Boot'      { 0 }; 'System'    { 1 }; 'Automatic' { 2 }; 'Manual'    { 3 }; 'Disabled'  { 4 }; default { Write-Error "^""Error: Unknown startup mode specified: `"^""$defaultStartupMode`"^"". Revert cannot proceed."^""; return; }; }; if ($(Get-ItemProperty -Path "^""$registryKey"^"").Start -eq $defaultStartupRegValue) { Write-Host "^""`"^""$serviceName`"^"" is has already default startup mode: `"^""$defaultStartupMode`"^""."^""; } else { try { Set-ItemProperty $registryKey -Name Start -Value $defaultStartupRegValue -Force; Write-Host "^""Successfully restored `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, trying to start it."^""; try { Start-Service -Name $serviceName -ErrorAction Stop; Write-Host 'Service started successfully.'; } catch { Write-Warning "^""Failed to restart service. It will be started after reboot. Error: $($_.Exception.Message)"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore files matching pattern: "%SYSTEMROOT%\System32\webthreatdefusersvc.dll" with additional permissions 
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Restore registry key: HKLM\SOFTWARE\Microsoft\WindowsRuntime\Server\WebThreatDefSvc as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Restore registry key: HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost\WebThreatDefense 
:: This operation will not run on Windows versions earlier than Windows11-22H2.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-22H2'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost\WebThreatDefense'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\Software\Classes\Interface\{ac889b17-df54-4854-a439-d7b68d1e16e8} as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Restore registry key: HKLM\Software\Classes\CLSID\{E2F1C91D-C762-4B5A-A8C1-4734E48C5FF4} as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.OneCore.WebThreatDefense.Service.UserSessionServiceManager as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.OneCore.WebThreatDefense.Configuration.WTDUserSettings as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection automatic data collection (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection automatic data collection (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components!CaptureThreatWindow"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-FirstRelease'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components' /v 'CaptureThreatWindow' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components!CaptureThreatWindow"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection "potentially malicious" notifications (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection "potentially malicious" notifications (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components!NotifyMalicious"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-FirstRelease'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components' /v 'NotifyMalicious' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components!NotifyMalicious"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection "password reuse" notifications (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection "password reuse" notifications (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components!NotifyPasswordReuse"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-FirstRelease'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components' /v 'NotifyPasswordReuse' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components!NotifyPasswordReuse"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection "unsafe apps" notifications (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection "unsafe apps" notifications (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components!NotifyUnsafeApp"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-FirstRelease'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components' /v 'NotifyUnsafeApp' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components!NotifyUnsafeApp"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection audit mode (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection audit mode (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components!ServiceEnabled"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-FirstRelease'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components' /v 'ServiceEnabled' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components!ServiceEnabled"
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection warnings and prompts (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection warnings and prompts (revert)
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\FeatureFlags!BlockUxDisabled"
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: ----------------------------------------------------------
:: Disable SmartScreen Enhanced Phishing Protection telemetry (revert)
echo --- Disable SmartScreen Enhanced Phishing Protection telemetry (revert)
:: Set the registry value "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\FeatureFlags!TelemetryCallsEnabled"
:: This operation will not run on Windows versions earlier than Windows11-22H2.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Remove "Windows Security" system tray icon (revert)----
:: ----------------------------------------------------------
echo --- Remove "Windows Security" system tray icon (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray!HideSystray"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray' /v 'HideSystray' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Remove "Scan with Defender" from context menu (revert)--
:: ----------------------------------------------------------
echo --- Remove "Scan with Defender" from context menu (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore the registry value "(Default)" in key "HKLM\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\EPP" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$data = '{09A47860-11B0-4DA5-AFA5-26D86198A780}'; $rawType = 'REG_SZ'; $rawPath = 'HKLM\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\EPP'; $value = '(Default)'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: Restore the registry value "(Default)" in key "HKLM\SOFTWARE\Classes\Drive\shellex\ContextMenuHandlers\EPP" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$data = '{09A47860-11B0-4DA5-AFA5-26D86198A780}'; $rawType = 'REG_SZ'; $rawPath = 'HKLM\SOFTWARE\Classes\Drive\shellex\ContextMenuHandlers\EPP'; $value = '(Default)'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Remove "Windows Security" icon from taskbar (revert)---
:: ----------------------------------------------------------
echo --- Remove "Windows Security" icon from taskbar (revert)
:: Restore the registry value "SecurityHealth" in key "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" to its original value 
PowerShell -ExecutionPolicy Unrestricted -Command "$data = '%SYSTEMROOT%\System32\SecurityHealthSystray.exe'; $rawType = 'REG_EXPAND_SZ'; $rawPath = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'; $value = 'SecurityHealth'; $hive = $rawPath.Split('\')[0]; $path = "^""$($hive):$($rawPath.Substring($hive.Length))"^""; Write-Host "^""Restoring value '$value' at '$path' with type '$rawType' and value '$data'."^""; if (-Not $rawType) { throw "^""Internal privacy$([char]0x002E)sexy error: Data type is not provided for data '$data'."^""; }; if (-Not (Test-Path -LiteralPath $path)) { try { New-Item -Path $path -Force -ErrorAction Stop | Out-Null; Write-Host 'Successfully created registry key.'; } catch { throw "^""Failed to create registry key: $($_.Exception.Message)"^""; }; }; $currentData = Get-ItemProperty -LiteralPath $path -Name $value -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $value; if ($currentData -eq $data) { Write-Host 'Skipping, no changes required, the registry data is already as expected.'; Exit 0; }; try { $type = switch ($rawType) { 'REG_SZ' { 'String' }; 'REG_DWORD' { 'DWord' }; 'REG_QWORD' { 'QWord' }; 'REG_EXPAND_SZ' { 'ExpandString' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: Failed to find data type for: '$rawType'."^""; }; }; Set-ItemProperty -LiteralPath $path -Name $value -Value $data -Type $type -Force -ErrorAction Stop; Write-Host 'Successfully restored the registry value.'; } catch { throw "^""Failed to restore the value: $($_.Exception.Message)"^""; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable Defender Antivirus interface (revert)-------
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus interface (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: Disable outdated non-administrator access to Defender threat history (revert)
echo --- Disable outdated non-administrator access to Defender threat history (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender\UX Configuration!DisablePrivacyMode"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Firewall Control Panel applet (revert)--
:: ----------------------------------------------------------
echo --- Disable Defender Firewall Control Panel applet (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\FirewallControlPanel.dll" with additional permissions 
:: Restore registry key: HKLM\Software\Classes\CLSID\{A4B07E49-6567-4FB8-8D39-01920E3B2357} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\CLSID\{A4B07E49-6567-4FB8-8D39-01920E3B2357} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{1CD0938D-1AC1-49DE-AA04-F2C92D4A02D1} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\AppID\{A4B07E49-6567-4FB8-8D39-01920E3B2357} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\AppId\{A4B07E49-6567-4FB8-8D39-01920E3B2357} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{752438CB-E941-433F-BCB4-8B7D2329F0C8} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\CLSID\{752438CB-E941-433F-BCB4-8B7D2329F0C8} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\AppID\{6571503D-D0FB-4D98-BBC3-1FBB2B3F344E} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\AppId\{6571503D-D0FB-4D98-BBC3-1FBB2B3F344E} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\TypeLib\{B9C76E7B-D029-44EB-896F-F02FC6E9ABD5} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\TypeLib\{B9C76E7B-D029-44EB-896F-F02FC6E9ABD5} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{DDECE4B2-979F-4CDB-9F58-B036FE5A510C} as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Defender Firewall "Windows Defender Firewall with Advanced Security" (revert)
echo --- Disable Defender Firewall "Windows Defender Firewall with Advanced Security" (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\AuthFWGP.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\AuthFWGP.dll" with additional permissions 
:: Restore registry key: HKLM\Software\Classes\CLSID\{023A36FC-E9D5-419E-824A-CDC66A116E84} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\CLSID\{023A36FC-E9D5-419E-824A-CDC66A116E84} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{0E752416-F29E-4195-A9DD-7F0D4D5A9D71} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\CLSID\{0E752416-F29E-4195-A9DD-7F0D4D5A9D71} as TrustedInstaller
:: ----------------------------------------------------------
:: Remove "Windows Security" app (`SecHealthUI`) (breaks Windows Security user interface) (revert)
echo --- Remove "Windows Security" app (`SecHealthUI`) (breaks Windows Security user interface) (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\*" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\$(("Microsoft.Windows.SecHealthUI" -Split '\.')[-1])\*" with additional permissions 
:: Restore files matching pattern: "%SYSTEMDRIVE%\Program Files\WindowsApps\Microsoft.Windows.SecHealthUI_*_cw5n1h2txyewy\*" with additional permissions 
:: Remove ability to remove system app 'Microsoft.Windows.SecHealthUI' to match operating system defaults
:: Restore "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$CURRENT_USER_SID\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy" registry key by deleting it
:: Reinstall 'Microsoft.Windows.SecHealthUI' if it was previously uninstalled
:: Remove 'Microsoft.Windows.SecHealthUI' from deprovisioned list to allow reinstall during updates.
:: Restore "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy" registry key by deleting it
:: Recreate the registry key "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$CURRENT_USER_SID\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy"
:: Restore files matching pattern: "%LOCALAPPDATA%\Packages\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\*"  
:: Restore files matching pattern: "%PROGRAMDATA%\Microsoft\Windows\AppRepository\Packages\Microsoft.Windows.SecHealthUI_*_cw5n1h2txyewy\*" with additional permissions 
:: Remove ability to remove system app 'Microsoft.SecHealthUI' to match operating system defaults
:: Restore "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$CURRENT_USER_SID\Microsoft.SecHealthUI_8wekyb3d8bbwe" registry key by deleting it
:: Reinstall 'Microsoft.SecHealthUI' if it was previously uninstalled
:: Remove 'Microsoft.SecHealthUI' from deprovisioned list to allow reinstall during updates.
:: Restore "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\Microsoft.SecHealthUI_8wekyb3d8bbwe" registry key by deleting it
:: Recreate the registry key "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$CURRENT_USER_SID\Microsoft.SecHealthUI_8wekyb3d8bbwe"
:: ----------------------------------------------------------
:: Disable outdated "Windows Defender Security Center" interface (revert)
echo --- Disable outdated "Windows Defender Security Center" interface (revert)
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\MpUXSrv.exe"  as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\AppID\{FDA74D11-C4A6-4577-9F73-D7CA8586E10D} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{FDA74D11-C4A6-4577-9F73-D7CA8586E10D} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMDATA%\Microsoft\Windows Defender\Platform\*\MPUXAGENT.DLL"  as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{4DB116D1-9B24-4DFC-946B-BFE03E852002} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{2DCD7FDB-8809-48E4-8E4F-3157C57CF987} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\AppUserModelId\Windows.Defender.MpUxDlp 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Classes\AppUserModelId\Windows.Defender.MpUxDlp'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\SOFTWARE\Classes\AppID\{1111a26d-ef95-4a45-9f55-21e52adf9887} as TrustedInstaller
:: Restore files matching pattern: "%PROGRAMFILES%\Windows Defender\mpuxhostproxy.dll"  as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{13F6A0B6-57AF-4BA7-ACAA-614BC89CA9D8} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{94F35585-C5D7-4D95-BA71-A745AE76E2E2} as TrustedInstaller
:: ----------------------------------------------------------
:: Disable "Windows Security" status reporting integrations (revert)
echo --- Disable "Windows Security" status reporting integrations (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\wscisvif.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\System32\wscisvif.dll" with additional permissions 
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{F2102C37-90C3-450C-B3F6-92BE1693BDF2} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{F2102C37-90C3-450C-B3F6-92BE1693BDF2} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{D5F7E36B-5B38-445D-A50F-439B8FCBB87A} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{D5F7E36B-5B38-445D-A50F-439B8FCBB87A} as TrustedInstaller
:: Restore files matching pattern: "%SYSTEMROOT%\System32\wscapi.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\wscapi.dll" with additional permissions 
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{2981a36e-f22d-11e5-9ce9-5e5517507c66} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{2981a36e-f22d-11e5-9ce9-5e5517507c66} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{17072F7B-9ABE-4A74-A261-1EB76B55107A} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{17072F7B-9ABE-4A74-A261-1EB76B55107A} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\TypeLib\{B52A4496-7753-4F74-BE64-C2072E308122} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\TypeLib\{B52A4496-7753-4F74-BE64-C2072E308122} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\wscAPI.WSCProductList as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\wscAPI.WSCProductList.1 as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\wscAPI.WSCDefaultProduct as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{7E66DBEF-2474-4E82-919B-9A855F4C2FE8} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{7E66DBEF-2474-4E82-919B-9A855F4C2FE8} as TrustedInstaller
:: Restore files matching pattern: "%SYSTEMROOT%\System32\wscproxystub.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\wscproxystub.dll" with additional permissions 
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{8C38232E-3A45-4A27-92B0-1A16A975F669} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{8C38232E-3A45-4A27-92B0-1A16A975F669} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{8C38232E-3A45-4A27-92B0-1A16A975F669} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{8C38232E-3A45-4A27-92B0-1A16A975F669} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{F896CA54-FE09-4403-86D4-23CB488D81D8} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{F896CA54-FE09-4403-86D4-23CB488D81D8} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{55536524-D1D1-4726-8C7C-04996A1904E7} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{55536524-D1D1-4726-8C7C-04996A1904E7} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{722A338C-6E8E-4E72-AC27-1417FB0C81C2} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{722A338C-6E8E-4E72-AC27-1417FB0C81C2} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{0476d69c-f21a-11e5-9ce9-5e5517507c66} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{0476d69c-f21a-11e5-9ce9-5e5517507c66} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{A61406C1-997B-4a4b-B622-AA7DACA6D575} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{A61406C1-997B-4a4b-B622-AA7DACA6D575} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{3901A765-AB91-4ba9-A553-5B8538DEB840} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{3901A765-AB91-4ba9-A553-5B8538DEB840} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{206D9C96-ACDF-484B-833E-DEB914565E44} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{206D9C96-ACDF-484B-833E-DEB914565E44} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{CF007CA2-F5E3-11E5-9CE9-5E5517507C66} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{CF007CA2-F5E3-11E5-9CE9-5E5517507C66} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{4DCBAFAC-29BA-46B1-80FC-B8BDE3C0AE4D} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{4DCBAFAC-29BA-46B1-80FC-B8BDE3C0AE4D} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{9B8F6C6E-8A4A-4891-AF63-1A2F50924040} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{9B8F6C6E-8A4A-4891-AF63-1A2F50924040} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{62F698CB-094A-4C68-9419-8E8C49420E59} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{62F698CB-094A-4C68-9419-8E8C49420E59} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{024E9756-BA6C-4ad1-8321-87BAE78FD0E3} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{024E9756-BA6C-4ad1-8321-87BAE78FD0E3} as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---------Disable Defender Shell Service (revert)----------
:: ----------------------------------------------------------
echo --- Disable Defender Shell Service (revert)
:: Restore registry key: HKLM\Software\Classes\CLSID\{E3C9166D-1D39-4D4E-A45D-BC7BE9B00578} as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: Restore registry key: HKLM\Software\Classes\CLSID\{6D40A6F9-3D32-4FCB-8A86-BE992E03DC76} as TrustedInstaller
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthSSO.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealth\*\SecurityHealthSSO.dll" with additional permissions 
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthSsoUdk.dll" with additional permissions 
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Disable "Windows Security Service" service (revert)----
:: ----------------------------------------------------------
echo --- Disable "Windows Security Service" service (revert)
:: Restore the service `SecurityHealthService` using TrustedInstaller privileges
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthService.exe" with additional permissions 
:: Remove configuration preventing "SecurityHealthService.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthService.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthService.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "SecurityHealthService.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable "Windows Security Service" interactions (revert)-
:: ----------------------------------------------------------
echo --- Disable "Windows Security Service" interactions (revert)
:: Restore registry key: HKLM\Software\Classes\AppID\{2EB6D15C-5239-41CF-82FB-353D20B816CF} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{F6976CF5-68A8-436C-975A-40BE53616D59} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{CC66E708-C687-42EA-806E-83D41C9D1A5F} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{8C9C0DB7-2CBA-40F1-AFE0-C55740DD91A0} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{F99A566C-42AE-4DE2-AD4D-D297A04C5433} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{470B9B9B-0E95-4963-B265-5D58E5808C3D} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{2D15188C-D298-4E10-83B2-64666CCBEBBD} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{816A45F9-7406-42BB-B4FA-A655D96F2A8A} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{2557a77e-882d-4633-960e-0c718670c1c7} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{1B48339C-D15E-45F3-AD55-A851CB66BE6B} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{A2A6D7C6-ECBD-439E-9244-9E784608439F} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{434AEC1C-8583-45EC-B88F-750D6F380BC3} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{D6B0D1EB-456E-48FF-A3E3-F393C74B85DB} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{EDAE4045-CAE6-4706-8973-FA69715B8C10} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{5CF41123-E9E6-4AC0-85A7-C4001F513C6A} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{BD8A8E7D-E42F-434A-8215-C7ECB6C32786} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{47782907-6A6D-44BC-8872-4E45E994E6F9} as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Windows Security Health Agent (WSHA) (revert)---
:: ----------------------------------------------------------
echo --- Disable Windows Security Health Agent (WSHA) (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthAgent.dll" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ------Disable Windows Security Health Core (revert)-------
:: ----------------------------------------------------------
echo --- Disable Windows Security Health Core (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthCore.dll" with additional permissions 
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Disable Windows Security Health UDK (revert)-------
:: ----------------------------------------------------------
echo --- Disable Windows Security Health UDK (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthUdk.dll" with additional permissions 
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable "Windows Security Health Host" process (revert)--
:: ----------------------------------------------------------
echo --- Disable "Windows Security Health Host" process (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthHost.exe" with additional permissions 
:: Remove configuration preventing "SecurityHealthHost.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthHost.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthHost.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "SecurityHealthHost.exe" from running via File Explorer
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Windows Security Health data sharing (revert)---
:: ----------------------------------------------------------
echo --- Disable Windows Security Health data sharing (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityHealthProxyStub.dll" with additional permissions 
:: Restore registry key: HKLM\Software\Classes\CLSID\{6CED0DAA-4CDE-49C9-BA3A-AE163DC3D7AF} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{AA00FB1F-4EC7-4b09-BDC1-E5D88D291440} 
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-FirstRelease'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\Software\Classes\CLSID\{AA00FB1F-4EC7-4b09-BDC1-E5D88D291440}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{AA00FB1F-4EC7-4b09-BDC1-E5D88D291440} 
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
PowerShell -ExecutionPolicy Unrestricted -Command "$versionName = 'Windows11-FirstRelease'; $buildNumber = switch ($versionName) { 'Windows11-FirstRelease' { '10.0.22000' }; 'Windows11-22H2' { '10.0.22621' }; 'Windows11-21H2' { '10.0.22000' }; 'Windows10-22H2' { '10.0.19045' }; 'Windows10-21H2' { '10.0.19044' }; 'Windows10-20H2' { '10.0.19042' }; 'Windows10-1909' { '10.0.18363' }; 'Windows10-1607' { '10.0.14393' }; default { throw "^""Internal privacy$([char]0x002E)sexy error: No build for minimum Windows '$versionName'"^""; }; }; $minVersion = [System.Version]::Parse($buildNumber); $ver = [Environment]::OSVersion.Version; $verNoPatch = [System.Version]::new($ver.Major, $ver.Minor, $ver.Build); if ($verNoPatch -lt $minVersion) { Write-Output "^""Skipping: Windows ($verNoPatch) is below minimum $minVersion ($versionName)"^""; Exit 0; }; function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{AA00FB1F-4EC7-4b09-BDC1-E5D88D291440}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\Software\Classes\CLSID\{36383E77-35C2-4B45-8277-329E4BEDF47F} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{10964DDD-6A53-4C60-917F-7B5723014344} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{2EF44DE8-80C9-42D9-8541-F40EF0862FA3} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{3213CD15-4DF2-415F-83F2-9FC58F3AEB3A} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{3522D7AF-4617-4237-AAD8-5860231FC9BA} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{45F2C32F-ED16-4C94-8493-D72EF93A051B} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{3886CA90-AB09-49D1-A047-7A62D096D275} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{3CD3CA1E-2232-4BBF-A733-18B700409DA0} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{5ffab5c8-9a36-4b65-9fc6-fb69f451f99c} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{82345212-6ACA-4B38-8CD7-BF9DE8ED07BD} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{849F5497-5C61-4023-8E10-A28F1A8C6A70} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{88866959-07B0-4ED8-8EF5-54BC7443D28C} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{8E67B5C5-BAD3-4263-9F80-F769D50884F7} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{C8DFF91D-B243-4797-BAE6-C461B65EDED3} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{DBF393FC-230C-46CC-8A85-E9C599A81EFB} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{E041C90B-68BA-42C9-991E-477B73A75C90} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{E476E4C0-409C-43CD-BBC0-5905B4138494} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\CLSID\{08728914-3F57-4D52-9E31-49DAECA5A80A} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\AppID\{37096FBE-2F09-4FF6-8507-C6E4E1179893} as TrustedInstaller
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\AppId\{37096FBE-2F09-4FF6-8507-C6E4E1179893} as TrustedInstaller
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: Restore registry key: HKLM\Software\Classes\AppID\{7E55A26D-EF95-4A45-9F55-21E52ADF9887} as TrustedInstaller
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\AppId\{7E55A26D-EF95-4A45-9F55-21E52ADF9887} as TrustedInstaller
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: Restore registry key: HKLM\Software\Classes\AppID\{4fe95d37-3459-4ecc-ac3e-f7abbe4e8aed} as TrustedInstaller
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\AppId\{4fe95d37-3459-4ecc-ac3e-f7abbe4e8aed} as TrustedInstaller
:: This operation will not run on Windows versions later than Windows10-MostRecent.
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Windows Security service (revert)---------
:: ----------------------------------------------------------
echo --- Disable Windows Security service (revert)
:: Restore the service `wscsvc` using TrustedInstaller privileges
:: Restore files matching pattern: "%SYSTEMROOT%\System32\wscsvc.dll" with additional permissions 
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Windows Security service integrations (revert)--
:: ----------------------------------------------------------
echo --- Disable Windows Security service integrations (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\SecurityCenterBrokerPS.dll"  
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{B529B7F5-76AA-431F-AD7F-1272FEEDFF07} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{B529B7F5-76AA-431F-AD7F-1272FEEDFF07} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{2A23AE77-9BFC-4B7B-8520-2D7B3E4A40B6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{2A23AE77-9BFC-4B7B-8520-2D7B3E4A40B6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{17966E44-DA6F-4AA9-B30E-5D4CCA5F5933} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{17966E44-DA6F-4AA9-B30E-5D4CCA5F5933} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{CBBC9C52-0741-4E3C-8E87-711722F8740D} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{CBBC9C52-0741-4E3C-8E87-711722F8740D} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{642D1BFD-FD78-488D-8E3B-AEB1195FE4DE} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{642D1BFD-FD78-488D-8E3B-AEB1195FE4DE} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{0A4B1BED-FD27-4932-9094-F0738284DEB4} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{0A4B1BED-FD27-4932-9094-F0738284DEB4} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{E8CE0994-D686-46F8-A719-9EB1436EC690} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{E8CE0994-D686-46F8-A719-9EB1436EC690} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{96AC500C-AED4-561D-BDE8-953520343A2D} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{96AC500C-AED4-561D-BDE8-953520343A2D} as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.SecurityCenter.WscBrokerManager as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.SecurityCenter.WscCloudBackupProvider as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.SecurityCenter.WscDataProtection as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.SecurityCenter.SecurityAppBroker as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\ActivatableClassId\Windows.UI.Shell.SecurityAppManager as TrustedInstaller
:: Restore registry key: HKLM\Software\Microsoft\WindowsRuntime\Server\wscsvc as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{d5c88c8b-eca2-4921-a2e4-b1a390bad510} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{d5c88c8b-eca2-4921-a2e4-b1a390bad510} as TrustedInstaller
:: ----------------------------------------------------------
:: Disable "Virus and threat protection" section in "Windows Security" (revert)
echo --- Disable "Virus and threat protection" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Ransomware data recovery" section in "Windows Security" (revert)
echo --- Disable "Ransomware data recovery" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection!HideRansomwareRecovery"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection' /v 'HideRansomwareRecovery' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Family options" section in "Windows Security" (revert)
echo --- Disable "Family options" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Device performance and health" section in "Windows Security" (revert)
echo --- Disable "Device performance and health" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device performance and health!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device performance and health' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Account protection" section in "Windows Security" (revert)
echo --- Disable "Account protection" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Account protection!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Account protection' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "App and browser control" section in "Windows Security" (revert)
echo --- Disable "App and browser control" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Device security" section in "Windows Security" (revert)
echo --- Disable "Device security" section in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security!UILockdown"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security' /v 'UILockdown' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable "Clear TPM" button in "Windows Security" (revert)-
:: ----------------------------------------------------------
echo --- Disable "Clear TPM" button in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security!DisableClearTpmButton"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security' /v 'DisableClearTpmButton' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Secure boot" button in "Windows Security" (revert)
echo --- Disable "Secure boot" button in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security!HideSecureBoot"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security' /v 'HideSecureBoot' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "Security processor (TPM) troubleshooter" page in "Windows Security" (revert)
echo --- Disable "Security processor (TPM) troubleshooter" page in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security!HideTPMTroubleshooting"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security' /v 'HideTPMTroubleshooting' /f 2>$null"
:: ----------------------------------------------------------
:: Disable "TPM Firmware Update" recommendation in "Windows Security" (revert)
echo --- Disable "TPM Firmware Update" recommendation in "Windows Security" (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security!DisableTpmFirmwareUpdateWarning"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security' /v 'DisableTpmFirmwareUpdateWarning' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Security and Maintenance push notifications (revert)
echo --- Disable Security and Maintenance push notifications (revert)
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance' /v 'Enabled' /f 2>$null"
:: Restore registry key: HKLM\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\Windows.SystemToast.SecurityAndMaintenance as TrustedInstaller
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Backup\Windows.SystemToast.SecurityAndMaintenance 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Backup\Windows.SystemToast.SecurityAndMaintenance'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: Disable Security and Maintenance taskbar notifications (revert)
echo --- Disable Security and Maintenance taskbar notifications (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\AppUserModelId\Windows.ActionCenter.UrgentNotification as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\AppUserModelId\Windows.SystemToast.SecurityAndMaintenance as TrustedInstaller
:: ----------------------------------------------------------
:: Disable Security and Maintenance notification integrations (revert)
echo --- Disable Security and Maintenance notification integrations (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{A973E7B2-131B-428E-8B2B-EAE73D731E98} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{A973E7B2-131B-428E-8B2B-EAE73D731E98} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{a3b3c46c-05d8-429b-bf66-87068b4ce563} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{a3b3c46c-05d8-429b-bf66-87068b4ce563} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{01afc156-f2eb-4c1c-a722-8550417d396f} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{01afc156-f2eb-4c1c-a722-8550417d396f} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{01afc156-f2eb-4c1c-a722-8550417d396f} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{01afc156-f2eb-4c1c-a722-8550417d396f} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{824f0d64-069c-4383-9107-f18fc40c3ca6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{824f0d64-069c-4383-9107-f18fc40c3ca6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{418ee892-56f0-4c3b-9238-696ba0cef799} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{418ee892-56f0-4c3b-9238-696ba0cef799} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{7cbc33db-7a53-45c3-a0cc-610292bd7b9e} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{7cbc33db-7a53-45c3-a0cc-610292bd7b9e} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{FAE9CE59-7621-4208-8BC3-2ACECD58FED2} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{FAE9CE59-7621-4208-8BC3-2ACECD58FED2} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{3d2eafc0-96d0-4925-9f7d-ff80b168f243} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{3d2eafc0-96d0-4925-9f7d-ff80b168f243} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{b387c51b-7fe4-4252-8cd4-585592b4dc7e} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{b387c51b-7fe4-4252-8cd4-585592b4dc7e} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{e90aad8b-7f0c-480d-b33e-16779c4cf59d} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{e90aad8b-7f0c-480d-b33e-16779c4cf59d} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{8025d477-47d3-449c-9350-c676140ee829} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{8025d477-47d3-449c-9350-c676140ee829} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{db62c52c-dbae-476c-aeac-fa9966e85326} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{db62c52c-dbae-476c-aeac-fa9966e85326} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{1cf5e433-3cf8-498e-8b5a-f47e23200e07} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{1cf5e433-3cf8-498e-8b5a-f47e23200e07} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{58d879fe-5b40-46aa-ab68-d146ff6a68a0} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{58d879fe-5b40-46aa-ab68-d146ff6a68a0} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{0acabbb8-8f37-4605-9d41-eec1c33eeb95} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{0acabbb8-8f37-4605-9d41-eec1c33eeb95} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{0cc6fe25-a88b-480d-956a-a9a20bd2c65a} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{0cc6fe25-a88b-480d-956a-a9a20bd2c65a} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{8db6ae56-7ea1-421c-9c22-d3247c12c6c4} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{8db6ae56-7ea1-421c-9c22-d3247c12c6c4} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{014a1425-828b-482a-a386-5763b23531c3} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{014a1425-828b-482a-a386-5763b23531c3} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\Interface\{B066DDE3-445D-45dc-BF2A-BC7BAA74C5C5} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{B066DDE3-445D-45dc-BF2A-BC7BAA74C5C5} as TrustedInstaller
:: ----------------------------------------------------------
:: Disable all Security and Maintenance notifications (revert)
echo --- Disable all Security and Maintenance notifications (revert)
:: Restore registry key: HKLM\Software\Microsoft\Windows\CurrentVersion\Security and Maintenance\Providers as TrustedInstaller
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\Security and Maintenance\Checks 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\Security and Maintenance\Checks'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\Security and Maintenance\Providers 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\Security and Maintenance\Providers'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\Action Center\Checks 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\Action Center\Checks'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\Action Center\Providers 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\Action Center\Providers'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ---Disable all Windows Security notifications (revert)----
:: ----------------------------------------------------------
echo --- Disable all Windows Security notifications (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications!DisableNotifications"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications' /v 'DisableNotifications' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications!DisableNotifications"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications' /v 'DisableNotifications' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityCenter!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityCenter' /v 'Enabled' /f 2>$null"
:: Restore registry key: HKLM\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\Windows.SystemToast.SecurityCenter as TrustedInstaller
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Backup\Windows.SystemToast.SecurityCenter 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Backup\Windows.SystemToast.SecurityCenter'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: Disable non-critical Windows Security notifications (revert)
echo --- Disable non-critical Windows Security notifications (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications!DisableEnhancedNotifications"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications' /v 'DisableEnhancedNotifications' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications!DisableEnhancedNotifications"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications' /v 'DisableEnhancedNotifications' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting!DisableEnhancedNotifications"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting' /v 'DisableEnhancedNotifications' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Windows Security taskbar notifications (revert)--
:: ----------------------------------------------------------
echo --- Disable Windows Security taskbar notifications (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\AppUserModelId\Windows.SystemToast.SecurityCenter as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\AppUserModelId\Windows.Defender.SecurityCenter as TrustedInstaller
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Defender Antivirus push notifications (revert)--
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus push notifications (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration!Notification_Suppress"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration' /v 'Notification_Suppress' /f 2>$null"
:: Delete the registry value "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender' /v 'Enabled' /f 2>$null"
:: Restore registry key: HKLM\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\Windows.Defender as TrustedInstaller
:: Restore registry key: HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Backup\Windows.Defender 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Backup\Windows.Defender'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable Defender Antivirus reboot notifications (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus reboot notifications (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration!SuppressRebootNotification"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\UX Configuration' /v 'SuppressRebootNotification' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: Disable Defender Antivirus taskbar notifications (revert)-
:: ----------------------------------------------------------
echo --- Disable Defender Antivirus taskbar notifications (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\AppUserModelId\Microsoft.Windows.Defender 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Classes\AppUserModelId\Microsoft.Windows.Defender'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: Restore registry key: HKLM\SOFTWARE\Classes\AppUserModelId\Windows.Defender 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Classes\AppUserModelId\Windows.Defender'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Security and Maintenance core library (revert)--
:: ----------------------------------------------------------
echo --- Disable Security and Maintenance core library (revert)
:: Restore files matching pattern: "%SYSTEMROOT%\System32\ActionCenter.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\ActionCenter.dll" with additional permissions 
:: ----------------------------------------------------------
:: Disable Security and Maintenance Control Panel applet (revert)
echo --- Disable Security and Maintenance Control Panel applet (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6} as TrustedInstaller
:: Restore files matching pattern: "%SYSTEMROOT%\System32\ActionCenterCPL.dll" with additional permissions 
:: Restore files matching pattern: "%SYSTEMROOT%\SysWOW64\ActionCenterCPL.dll" with additional permissions 
:: ----------------------------------------------------------
:: Disable Security and Maintenance desktop features (revert)
echo --- Disable Security and Maintenance desktop features (revert)
:: Restore registry key: HKLM\SOFTWARE\Classes\CLSID\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A} as TrustedInstaller
:: Restore registry key: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellServiceObjects\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A} 
PowerShell -ExecutionPolicy Unrestricted -Command "function Copy-Acl($Src, $Dst) { $srcKeys = @(Get-ChildItem -LiteralPath $Src -ErrorAction SilentlyContinue); foreach ($key in $srcKeys) { $dstKey = Join-Path $Dst $key.PSChildName; Copy-Acl -Src $key.PSPath -Dst $dstKey; }; $acl = Get-Acl -Path $Src -ErrorAction Stop; $sections = [System.Security.AccessControl.AccessControlSections]::All -band (-bnot [System.Security.AccessControl.AccessControlSections]::Owner); $sddl = $acl.GetSecurityDescriptorSddlForm($sections); $acl.SetSecurityDescriptorSddlForm($sddl, $sections); Set-Acl -Path $Dst -AclObject $acl -ErrorAction Stop; }; function Rename-KeyWithAcl($Old, $New) { try { Copy-Item -LiteralPath $Old -Destination $New -Recurse -Force -ErrorAction Stop; } catch { throw "^""Failed to copy: $_"^""; }; try { Copy-Acl -Src $Old -Dst $New; } catch { Write-Warning "^""Failed to copy ACL: $_"^""; }; try { Remove-Item -LiteralPath $Old -Force -Recurse -ErrorAction Stop | Out-Null; } catch { try { Remove-Item -LiteralPath $New -Force -Recurse -ErrorAction Stop | Out-Null; } catch { Write-Warning "^""Failed to clean up: $_"^""; }; throw "^""Failed to remove: $_"^""; }; }; $rawPath='HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellServiceObjects\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A}'; $suffix ='.OLD'; $global:fail = 0; $global:ok = 0; function Get-Real($s) { while ($s.EndsWith($suffix)) { $s = $s.Substring(0, $s.Length - $suffix.Length); }; return $s; }; function Restore-KeyTree($Path) { $dest = Get-Real $Path; $src = $Path; Write-Host "^""Restoring key: '$dest' from '$src'"^""; if (-Not $src.EndsWith($suffix)) { $src += $suffix; if (-Not (Test-Path -LiteralPath $src)) { Write-Host 'Skipping: No data.'; Restore-Children $dest; return; }; }; if (Test-Path -LiteralPath $dest) { Write-Host 'Skipping to avoid data loss. Key already exists.'; Write-Warning "^""Manual intervention may be required to fully restore from '$src'."^""; } else { try { Rename-KeyWithAcl -Old $src -New $dest -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; Restore-Children $dest; }; function Restore-Children($Path) { Write-Host "^""Restoring values in '$Path'"^""; if (-Not (Test-Path -LiteralPath $Path)) { Write-Host 'Skipping: Key does not exist. No action needed.'; return; }; $values = ( Get-Item -LiteralPath $Path -ErrorAction Stop | Select-Object -ExpandProperty Property ); foreach ($value in $values) { Write-Host "^""Restoring value '$value'"^""; if (-Not $value.EndsWith($suffix)) { Write-Host 'Skipping: No action needed.'; continue; }; $real = Get-Real $value; Write-Host "^""Renaming to '$real'."^""; try { Rename-ItemProperty -LiteralPath $Path -Name $value -NewName $real -ErrorAction Stop; Write-Host 'Successfully restored.'; $global:ok++; } catch { Write-Warning "^""Failed: $_"^""; $global:fail++; }; }; $keys = @(Get-ChildItem -LiteralPath $Path -ErrorAction SilentlyContinue); foreach ($key in $keys) { Restore-KeyTree $key.PSPath; }; }; Write-Host "^""Restoring registry key '$rawPath' recursively."^""; $hive = $rawPath.Split('\')[0]; $path = $hive + ':' + $rawPath.Substring($hive.Length); Restore-KeyTree $path; if ($global:fail) { Write-Error 'Failed to restore'; Exit 1; }"
:: ----------------------------------------------------------
:: Disable prevention of users and apps from accessing dangerous websites (revert)
echo --- Disable prevention of users and apps from accessing dangerous websites (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection!EnableNetworkProtection"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection' /v 'EnableNetworkProtection' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable controlled folder access (revert)---------
:: ----------------------------------------------------------
echo --- Disable controlled folder access (revert)
:: Delete the registry value "HKLM\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access!EnableControlledFolderAccess"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\Software\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access' /v 'EnableControlledFolderAccess' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable "ExploitGuard MDM policy Refresh" task (revert)--
:: ----------------------------------------------------------
echo --- Disable "ExploitGuard MDM policy Refresh" task (revert)
:: Restore scheduled task(s) to default state: `\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable Defender Application Guard isolation (revert)---
:: ----------------------------------------------------------
echo --- Disable Defender Application Guard isolation (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\AppHVSI!AllowAppHVSI_ProviderSet"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\AppHVSI' /v 'AllowAppHVSI_ProviderSet' /f 2>$null"
:: ----------------------------------------------------------
:: Disable Defender Application Guard remote configuration (revert)
echo --- Disable Defender Application Guard remote configuration (revert)
:: Restore registry key: HKLM\Software\Classes\CLSID\{F80FC80C-6A04-46FB-8555-D769E334E9FC} as TrustedInstaller
:: Restore registry key: HKLM\Software\Classes\WOW6432Node\CLSID\{F80FC80C-6A04-46FB-8555-D769E334E9FC} as TrustedInstaller
:: This operation will not run on Windows versions earlier than Windows11-FirstRelease.
:: Restore files matching pattern: "%SYSTEMROOT%\System32\windowsdefenderapplicationguardcsp.dll" with additional permissions 
:: ----------------------------------------------------------
:: Disable auditing events in Defender Application Guard (revert)
echo --- Disable auditing events in Defender Application Guard (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\AppHVSI!AuditApplicationGuard"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\AppHVSI' /v 'AuditApplicationGuard' /f 2>$null"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully