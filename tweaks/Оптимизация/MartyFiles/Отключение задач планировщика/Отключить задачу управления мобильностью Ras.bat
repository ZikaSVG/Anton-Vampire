@echo off
chcp 866 >nul

:: Отключить задачу управления мобильностью Ras
for %%T in (
    "\Microsoft\Windows\Ras\MobilityManager"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul