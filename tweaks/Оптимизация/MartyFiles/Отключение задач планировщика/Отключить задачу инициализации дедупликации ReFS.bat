@echo off
chcp 866 >nul

:: Отключить задачу инициализации дедупликации ReFS
for %%T in (
    "\Microsoft\Windows\ReFsDedupSvc\Initialization"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul