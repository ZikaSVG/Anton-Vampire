@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\Offline Files\Background Synchronization"
    "\Microsoft\Windows\Offline Files\Logon Synchronization"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul