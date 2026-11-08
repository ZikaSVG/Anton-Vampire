@echo off
chcp 866 >nul

:: Отключить задачи диагностики памяти
for %%T in (
    "\Microsoft\Windows\MemoryDiagnostic\AutomaticOfflineMemoryDiagnostic"
    "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul