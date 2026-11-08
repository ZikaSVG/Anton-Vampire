@echo off
chcp 866 >nul

:: Отключить задачу резервного копирования реестра
for %%T in (
    "\Microsoft\Windows\Registry\RegIdleBackup"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul