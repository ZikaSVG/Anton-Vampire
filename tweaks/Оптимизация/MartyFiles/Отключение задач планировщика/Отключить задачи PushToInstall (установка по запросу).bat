@echo off
chcp 866 >nul

:: Отключить задачи PushToInstall (установка по запросу)
for %%T in (
    "\Microsoft\Windows\PushToInstall\LoginCheck"
    "\Microsoft\Windows\PushToInstall\Registration"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul