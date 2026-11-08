@echo off
chcp 866 >nul

:: Отключить задачу удалённой помощи
for %%T in (
    "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul