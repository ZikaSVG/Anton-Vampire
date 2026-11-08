@echo off
chcp 866 >nul

:: Отключить задачи категории "Application Experience" (телеметрия совместимости)
for %%T in (
    "\Microsoft\Windows\Application Experience\MareBackup"
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp"
    "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
    "\Microsoft\Windows\Application Experience\SdbinstMergeDbTask"
    "\Microsoft\Windows\Application Experience\StartupAppTask"
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
    "\Microsoft\Windows\Application Experience\ProgramInventoryUpdater"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul