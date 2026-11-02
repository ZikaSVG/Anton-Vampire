@echo off
chcp 866 >nul

:: Отключить задачу: обновления кэша групповых политик
for %%T in (
    "\Microsoft\Windows\WindowsUpdate\Refresh Group Policy Cache"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
