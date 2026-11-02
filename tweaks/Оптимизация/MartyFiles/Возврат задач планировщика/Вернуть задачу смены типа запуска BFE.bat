@echo off
chcp 866 >nul

:: Вернуть задачу: смены типа запуска BFE
for %%T in (
    "\Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
