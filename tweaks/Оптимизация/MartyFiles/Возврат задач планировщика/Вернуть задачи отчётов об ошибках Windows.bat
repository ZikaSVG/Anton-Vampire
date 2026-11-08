@echo off
chcp 866 >nul

:: Вернуть задачи: отчётов об ошибках Windows
for %%T in (
    "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
    "\Microsoft\Windows\Windows Error Reporting\ReportQueue"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
