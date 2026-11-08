@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\Device Information\Device"
    "\Microsoft\Windows\Device Information\Device User"
    "\Microsoft\Windows\Device Setup\Driver Recovery on Reboot"
    "\Microsoft\Windows\Device Setup\Metadata Refresh"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul