@echo off
chcp 866 >nul

for %%T in (
    "\Microsoft\Windows\File Classification Infrastructure\Property Definition Sync"
    "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul