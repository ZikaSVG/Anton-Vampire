@echo off
chcp 866 >nul

:: Отключить задачу: синхронизации CDS Wi-Fi
for %%T in (
    "\Microsoft\Windows\WlanSvc\CDSSync"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
