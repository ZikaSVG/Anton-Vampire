@echo off
@echo.
@echo t.me/DE3NAKE
@echo.
:: https://privacy.sexy — v0.13.5 — Sun, 04 Aug 2024 20:29:30 GMT
:: Ensure admin privileges
fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
    )
)
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion
:: ----------------------------------------------------------
:: -----Disable "NVIDIA Telemetry Report" task (revert)------
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report" task (revert)
:: Restore scheduled task(s) to default state: `\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -Disable "NVIDIA Telemetry Report on Logon" task (revert)-
:: ----------------------------------------------------------
echo --- Disable "NVIDIA Telemetry Report on Logon" task (revert)
:: Restore scheduled task(s) to default state: `\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -----Disable "NVIDIA telemetry monitor" task (revert)-----
:: ----------------------------------------------------------
echo --- Disable "NVIDIA telemetry monitor" task (revert)
:: Restore scheduled task(s) to default state: `\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}`
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: -------Remove Nvidia telemetry components (revert)--------
:: ----------------------------------------------------------
echo --- Remove Nvidia telemetry components (revert)
:: Restore files matching pattern  : "%PROGRAMFILES(X86)%\NVIDIA Corporation\NvTelemetry\*"
:: Restore files matching pattern  : "%PROGRAMFILES%\NVIDIA Corporation\NvTelemetry\*"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --------Disable Nvidia telemetry drivers (revert)---------
:: ----------------------------------------------------------
echo --- Disable Nvidia telemetry drivers (revert)
:: Restore files matching pattern  : "%SYSTEMROOT%\System32\DriverStore\FileRepository\NvTelemetry*.dll"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: ----Disable participation in Nvidia telemetry (revert)----
:: ----------------------------------------------------------
echo --- Disable participation in Nvidia telemetry (revert)
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client' /v 'OptInOrOutPreference' /f 2>$null"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID44231' /f 2>$null"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID64640' /f 2>$null"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS' /v 'EnableRID66610' /f 2>$null"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup' /v 'SendTelemetryData' /f 2>$null"
:: ----------------------------------------------------------
:: ----------------------------------------------------------
:: --Disable "Nvidia Telemetry Container" service (revert)---
:: ----------------------------------------------------------
echo --- Disable "Nvidia Telemetry Container" service (revert)
:: Restore service(s) to default state: `NvTelemetryContainer`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'NvTelemetryContainer'; $defaultStartupMode = 'Automatic'; $ignoreMissingOnRevert =  $false; Write-Host "^""Enabling service: `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) {; if ($ignoreMissingOnRevert) {; Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if(!$startupType) {; $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if(!$startupType) {; $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if($startupType -eq "^""$defaultStartupMode"^"") {; Write-Host "^""`"^""$serviceName`"^"" is already enabled with `"^""$defaultStartupMode`"^"" start, no further action is needed."^""; } else {; try {; Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Enabled `"^""$serviceName`"^"" successfully with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch {; Write-Error "^""Could not enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if($defaultStartupMode -eq 'Automatic') {; if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) {; Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try {; Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch {; Write-Warning "^""Could not start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else {; Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: ----------------------------------------------------------
:: Pause the script to view the final state
:: Restore previous environment settings
endlocal
:: Exit the script successfully