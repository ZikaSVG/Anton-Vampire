@echo off
chcp 866 >nul

:: Отключить задачи менеджера лицензий и геолокации
for %%T in (
    "\Microsoft\Windows\License Manager\TempSignedLicenseExchange"
    "\Microsoft\Windows\Location\WindowsActionDialog"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul