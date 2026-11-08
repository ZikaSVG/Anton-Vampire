@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
    "\Microsoft\Windows\CloudExperienceHost\SyncHost"
    "\Microsoft\Windows\CloudRestore\Backup"
    "\Microsoft\Windows\CloudRestore\Restore"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul