@echo off
chcp 866 >nul

:: Вернуть задачи: WaaSMedic
for %%T in (
    "\Microsoft\Windows\WaaSMedic\PerformRemediation"
    "\Microsoft\Windows\WaaSMedic\ScanForUpdates"
    "\Microsoft\Windows\WaaSMedic\WsusScan"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
