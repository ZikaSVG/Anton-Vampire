@echo off
chcp 866 >nul

:: Отключить задачи: присоединения к рабочему месту
for %%T in (
    "\Microsoft\Windows\Workplace Join\Automatic-Device-Join"
    "\Microsoft\Windows\Workplace Join\Device-Sync"
    "\Microsoft\Windows\Workplace Join\Recovery-Check"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
