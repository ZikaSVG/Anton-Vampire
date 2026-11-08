@echo off
chcp 866 >nul

:: Отключить задачи AutoLogger (телеметрия диагностики)
for %%T in (
    "\Microsoft\Windows\AutoLogger\AutoLogger-Diagtrack-Listener"
    "\Microsoft\Windows\AutoLogger\AutoLogger-FileSizeTracking"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul