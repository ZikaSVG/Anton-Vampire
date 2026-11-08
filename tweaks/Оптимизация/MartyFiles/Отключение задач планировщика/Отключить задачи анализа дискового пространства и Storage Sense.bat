@echo off
chcp 866 >nul

:: Отключить задачи анализа дискового пространства и Storage Sense
for %%T in (
    "\Microsoft\Windows\DiskFootprint\Diagnostics"
    "\Microsoft\Windows\DiskFootprint\StorageSense"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul