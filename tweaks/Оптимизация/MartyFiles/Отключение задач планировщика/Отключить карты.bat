@echo off
chcp 866 >nul

:: Отключить задачи карт (уведомления и обновления)
for %%T in (
    "\Microsoft\Windows\Maps\MapsToastTask"
    "\Microsoft\Windows\Maps\MapsUpdateTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul