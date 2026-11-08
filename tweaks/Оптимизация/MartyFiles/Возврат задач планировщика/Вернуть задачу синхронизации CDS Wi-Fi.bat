@echo off
chcp 866 >nul

:: Вернуть задачу: синхронизации CDS Wi-Fi
for %%T in (
    "\Microsoft\Windows\WlanSvc\CDSSync"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
