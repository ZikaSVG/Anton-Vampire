@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить полный список задач планировщика

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить полный список задач планировщика
echo.

for %%T in (
  "\Microsoft\Windows\UpdateOrchestrator\Report policies"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work"
  "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work"
  "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_OobeAppReady"
  "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task"
  "\Microsoft\Windows\UpdateOrchestrator\AC Power Download"
  "\Microsoft\Windows\UpdateOrchestrator\AC Power Install"
  "\Microsoft\Windows\UpdateOrchestrator\Backup Scan"
  "\Microsoft\Windows\UpdateOrchestrator\Battery Saver Deferred Install"
  "\Microsoft\Windows\UpdateOrchestrator\Driver Install"
  "\Microsoft\Windows\UpdateOrchestrator\Maintenance Install"
  "\Microsoft\Windows\UpdateOrchestrator\MusUx_LogonUpdateResults"
  "\Microsoft\Windows\UpdateOrchestrator\MusUx_UpdateInterval"
  "\Microsoft\Windows\UpdateOrchestrator\Policy Install"
  "\Microsoft\Windows\UpdateOrchestrator\Reboot_AC"
  "\Microsoft\Windows\UpdateOrchestrator\Reboot_Battery"
  "\Microsoft\Windows\UpdateOrchestrator\Refresh Settings"
  "\Microsoft\Windows\UpdateOrchestrator\Resume On Boot"
  "\Microsoft\Windows\UpdateOrchestrator\Schedule Retry Scan"
  "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistant"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantAllUsersRun"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantCalendarRun"
  "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantWakeupRun"
  "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser"
  "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates"
  "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates"
  "\Microsoft\Windows\WindowsUpdate\AUScheduledInstall"
  "\Microsoft\Windows\WindowsUpdate\AUSessionConnect"
  "\Microsoft\Windows\WindowsUpdate\Automatic App Update"
  "\Microsoft\Windows\WindowsUpdate\RUXIM\PLUGScheduler"
  "\Microsoft\Windows\WindowsUpdate\Scheduled Start With Network"
  "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerCeipAssistant"
  "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleCollector"
  "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleUsageCollector"
  "\Microsoft\Windows\Autochk\Proxy"
  "\Microsoft\Windows\Printing\PrinterCleanupTask"
  "\Microsoft\Windows\Printing\PrintJobCleanupTask"
  "\Microsoft\Windows\Printing\EduPrintProv"
  "\Microsoft\Windows\WindowsAI\Recall\PolicyConfiguration"
  "\Microsoft\Windows\WindowsAI\Settings\InitialConfiguration"
  "\Microsoft\Windows\WindowsAI\ClickToDo\ModelCachingIdle"
  "\Microsoft\Windows\WindowsAI\ClickToDo\ModelCachingLimit"
  "\Microsoft\Windows\WindowsAI\ClickToDo\ModelCachingUpdate"
) do schtasks /Change /TN "%%~T" /Disable >nul 2>&1

echo.
echo [OK] Готово: Отключить полный список задач планировщика
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
