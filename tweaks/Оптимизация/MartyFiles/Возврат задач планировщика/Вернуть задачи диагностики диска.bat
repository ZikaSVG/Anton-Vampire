@echo off
chcp 866 >nul

:: Вернуть задачи: диагностики диска
for %%T in (
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
    "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
    "\Microsoft\Windows\DiskDiagnostic\DiagnosticResolver"
    "\Microsoft\Windows\DiskDiagnostic\DiskDiagnostic"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
