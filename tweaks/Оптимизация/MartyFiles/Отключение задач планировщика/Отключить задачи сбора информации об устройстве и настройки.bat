@echo off
chcp 866 >nul

:: Отключить задачи сбора информации об устройстве и настройки
for %%T in (
    "\Microsoft\Windows\Device Information\Device"
    "\Microsoft\Windows\Device Information\Device User"
    "\Microsoft\Windows\Device Setup\Driver Recovery on Reboot"
    "\Microsoft\Windows\Device Setup\Metadata Refresh"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul