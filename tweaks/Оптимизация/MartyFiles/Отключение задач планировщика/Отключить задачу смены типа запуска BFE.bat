@echo off
chcp 866 >nul

:: Отключить задачу: смены типа запуска BFE
for %%T in (
    "\Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
