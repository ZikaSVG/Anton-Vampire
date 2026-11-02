@echo off
chcp 866 >nul

:: Отключить задачи: Windows Defender
for %%T in (
    "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
    "\Microsoft\Windows\Windows Defender Cleanup"
    "\Microsoft\Windows\Windows Defender Scheduled Scan"
    "\Microsoft\Windows\Windows Defender Verification"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
