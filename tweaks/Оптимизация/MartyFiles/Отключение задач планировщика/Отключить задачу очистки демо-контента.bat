@echo off
chcp 866 >nul

:: Отключить задачу очистки демо-контента
for %%T in (
    "\Microsoft\Windows\RetailDemo\CleanupOfflineContent"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul