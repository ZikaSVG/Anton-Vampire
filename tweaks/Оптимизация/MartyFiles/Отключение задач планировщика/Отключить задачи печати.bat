@echo off
chcp 866 >nul

:: Отключить задачи печати (EduPrintProv, очистка заданий)
for %%T in (
    "\Microsoft\Windows\Printing\EduPrintProv"
    "\Microsoft\Windows\Printing\PrintJobCleanupTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul