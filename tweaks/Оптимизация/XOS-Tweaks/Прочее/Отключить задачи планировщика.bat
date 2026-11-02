@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить задачи планировщика

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить задачи планировщика
echo.

for %%T in (
  "\Microsoft\Windows\Application Experience\MareBackup"
  "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
  "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
  "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
  "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
  "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
  "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
  "\Microsoft\Windows\Customer Experience Improvement Program\Uploader"
  "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
  "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
  "\Microsoft\Windows\Feedback\Siuf\DmClient"
  "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
  "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
  "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
  "\Microsoft\Windows\Diagnosis\Scheduled"
  "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner"
  "\Microsoft\Windows\Maintenance\WinSAT"
  "\Microsoft\Windows\Registry\RegIdleBackup"
  "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
  "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents"
  "\Microsoft\Windows\MemoryDiagnostic\AutomaticOfflineMemoryDiagnostic"
  "\Microsoft\Windows\Data Integrity Scan\Data Integrity Check And Scan"
  "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan"
  "\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan for Crash Recovery"
  "\Microsoft\Windows\DiskFootprint\Diagnostics"
  "\Microsoft\Windows\WDI\ResolutionHost"
  "\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
  "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
  "\Microsoft\Windows\SettingSync\NetworkStateChangeTask"
  "\Microsoft\Windows\SettingSync\BackgroundUploadTask"
  "\Microsoft\Windows\Maps\MapsToastTask"
  "\Microsoft\Windows\AccountHealth\RecoverabilityToastTask"
  "\Microsoft\Windows\Hotpatch\Monitoring"
  "\Microsoft\Windows\PerformanceTrace\RequestTrace"
  "\Microsoft\Windows\PerformanceTrace\WhesvcToast"
  "\Microsoft\Windows\Shell\FamilySafetyMonitor"
  "\Microsoft\Windows\Shell\FamilySafetyRefreshTask"
  "\Microsoft\Windows\UsageAndQualityInsights\UsageAndQualityInsights-MaintenanceTask"
  "\Microsoft\Windows\Sustainability\PowerGridForecastTask"
  "\Microsoft\Windows\Sustainability\SustainabilityTelemetry"
  "\Microsoft\Windows\CloudRestore\Backup"
  "\Microsoft\Windows\CloudRestore\Restore"
  "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Work"
  "\Microsoft\Windows\UpdateOrchestrator\UIEOrchestrator"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateModelTask"
  "\Microsoft\Windows\UpdateOrchestrator\USO_Broker_Display"
  "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display"
  "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot"
  "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Start"
  "\Microsoft\Windows\UpdateOrchestrator\Universal Orchestrator Idle Start"
  "\Microsoft\Windows\UpdateOrchestrator\Reboot"
  "\Microsoft\Windows\WaaSMedic\PerformRemediation"
  "\Microsoft\Windows\WindowsUpdate\Scheduled Start"
  "\Microsoft\Windows\WindowsUpdate\sih"
  "\Microsoft\Windows\WindowsUpdate\sihboot"
  "\Microsoft\Windows\WindowsUpdate\sihpostreboot"
  "\Microsoft\Windows\InstallService\RestoreDevice"
  "\Microsoft\Windows\InstallService\ScanForUpdates"
  "\Microsoft\Windows\InstallService\SmartRetry"
) do schtasks /Change /TN "%%~T" /Disable >nul 2>&1
powershell -NoProfile -Command "Get-ScheduledTask -TaskPath '\Microsoft\Office\*' -EA 0 | Disable-ScheduledTask -EA 0" >nul 2>&1

echo.
echo [OK] Готово: Отключить задачи планировщика
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
