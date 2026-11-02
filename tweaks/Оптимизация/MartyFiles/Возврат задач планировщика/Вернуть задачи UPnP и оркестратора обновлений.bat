@echo off
chcp 866 >nul

:: Вернуть задачи: UPnP и оркестратора обновлений
for %%T in (
    "\Microsoft\Windows\UPnP\UPnPHostConfig"
    "\Microsoft\Windows\UpdateOrchestrator\CleanupUpdateTask"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
