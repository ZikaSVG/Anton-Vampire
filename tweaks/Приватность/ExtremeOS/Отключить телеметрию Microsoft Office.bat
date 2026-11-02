@echo off
:: https://privacy.sexy — v0.13.8 — Fri, 02 Oct 2026 13:55:31 GMT
:: Ensure PowerShell is available
where PowerShell >nul 2>&1 || (
    echo PowerShell is not available. Please install or enable PowerShell.
    pause & exit 1
)
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion


:: ----------------------------------------------------------
:: -------------Disable Microsoft Office logging-------------
:: ----------------------------------------------------------
echo --- Disable Microsoft Office logging
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail!EnableLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail' /v 'EnableLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail!EnableLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail' /v 'EnableLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar!EnableCalendarLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar' /v 'EnableCalendarLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar!EnableCalendarLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar' /v 'EnableCalendarLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options!EnableLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options' /v 'EnableLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options!EnableLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options' /v 'EnableLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM!EnableLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM'; $data =  '0'; reg add 'HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM' /v 'EnableLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM!EnableLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM'; $data =  '0'; reg add 'HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM' /v 'EnableLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM!EnableUpload"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM'; $data =  '0'; reg add 'HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM' /v 'EnableUpload' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM!EnableUpload"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM'; $data =  '0'; reg add 'HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM' /v 'EnableUpload' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --------Disable Microsoft Office client telemetry---------
:: ----------------------------------------------------------
echo --- Disable Microsoft Office client telemetry
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry!DisableTelemetry"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry'; $data =  '1'; reg add 'HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry' /v 'DisableTelemetry' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\ClientTelemetry!DisableTelemetry"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\15.0\Common\ClientTelemetry'; $data =  '1'; reg add 'HKCU\SOFTWARE\Microsoft\Office\15.0\Common\ClientTelemetry' /v 'DisableTelemetry' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry!DisableTelemetry"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry'; $data =  '1'; reg add 'HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry' /v 'DisableTelemetry' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry!VerboseLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry' /v 'VerboseLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\ClientTelemetry!VerboseLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\15.0\Common\ClientTelemetry'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\15.0\Common\ClientTelemetry' /v 'VerboseLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry!VerboseLogging"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry' /v 'VerboseLogging' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: Disable user participation in Office Customer Experience Improvement Program (CEIP)
echo --- Disable user participation in Office Customer Experience Improvement Program (CEIP)
:: Set the registry value: "HKCU\Software\Policies\Microsoft\Office\15.0\Common!QMEnable"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\Software\Policies\Microsoft\Office\15.0\Common'; $data =  '0'; reg add 'HKCU\Software\Policies\Microsoft\Office\15.0\Common' /v 'QMEnable' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\Software\Policies\Microsoft\Office\16.0\Common!QMEnable"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\Software\Policies\Microsoft\Office\16.0\Common'; $data =  '0'; reg add 'HKCU\Software\Policies\Microsoft\Office\16.0\Common' /v 'QMEnable' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------------Disable Microsoft Office feedback-------------
:: ----------------------------------------------------------
echo --- Disable Microsoft Office feedback
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback' /v 'Enabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: Set the registry value: "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback!Enabled"
PowerShell -ExecutionPolicy Unrestricted -Command "$registryPath = 'HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback'; $data =  '0'; reg add 'HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback' /v 'Enabled' /t 'REG_DWORD' /d "^""$data"^"" /f"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable Microsoft Office telemetry agent---------
:: ----------------------------------------------------------
echo --- Disable Microsoft Office telemetry agent
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentFallBack`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentFallBack'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentFallBack2016`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentFallBack2016'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentLogOn`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentLogOn'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: Disable scheduled task(s): `\Microsoft\Office\OfficeTelemetryAgentLogOn2016`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='OfficeTelemetryAgentLogOn2016'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable "Microsoft Office Subscription Heartbeat" task--
:: ----------------------------------------------------------
echo --- Disable "Microsoft Office Subscription Heartbeat" task
:: Disable scheduled task(s): `\Microsoft\Office\Office 15 Subscription Heartbeat`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\Microsoft\Office\'; $taskNamePattern='Office 15 Subscription Heartbeat'; Write-Output "^""Disabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Output "^""Skipping, no tasks matching pattern `"^""$taskNamePattern`"^"" found, no action needed."^""; exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; try { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } catch { Write-Error "^""Failed to disable task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to disable some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: Pause the script to view the final state
pause
:: Restore previous environment settings
endlocal
:: Exit the script successfully
exit /b 0