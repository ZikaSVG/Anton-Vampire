@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\Setup\SetupCleanupTask"
    "\Microsoft\Windows\SharedPC\Account Cleanup"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul