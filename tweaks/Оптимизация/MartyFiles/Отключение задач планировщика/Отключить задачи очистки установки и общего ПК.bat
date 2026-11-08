@echo off
chcp 866 >nul

:: Отключить задачи очистки установки и общего ПК
for %%T in (
    "\Microsoft\Windows\Setup\SetupCleanupTask"
    "\Microsoft\Windows\SharedPC\Account Cleanup"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul