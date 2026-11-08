@echo off
chcp 866 >nul

:: Отключить задачи отчётов об ошибках
for %%T in (
    "\Microsoft\Windows\ErrorReporting\QueueReporting"
    "\Microsoft\Windows\ErrorReporting\KernelCeipTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul