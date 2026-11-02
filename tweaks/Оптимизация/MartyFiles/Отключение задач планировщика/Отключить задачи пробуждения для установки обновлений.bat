@echo off
chcp 866 >nul

:: Отключить задачи пробуждения для установки обновлений
for %%T in (
    "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates"
    "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul