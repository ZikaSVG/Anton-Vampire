@echo off
chcp 866 >nul

:: Отключить задачу оценки производительности WinSAT
for %%T in (
    "\Microsoft\Windows\Maintenance\WinSAT"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul