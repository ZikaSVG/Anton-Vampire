@echo off
chcp 866 >nul

:: Вернуть задачи: управления сжатием WOF
for %%T in (
    "\Microsoft\Windows\WOF\WIM-Hash-Management"
    "\Microsoft\Windows\WOF\WIM-Hash-Validation"
) do schtasks /Change /TN %%T /Enable >nul 2>&1

chcp 65001 >nul
