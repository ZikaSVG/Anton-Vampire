@echo off
chcp 866 >nul

:: Отключить задачи: подписки
for %%T in (
    "\Microsoft\Windows\Subscription\EnableLicenseAcquisition"
    "\Microsoft\Windows\Subscription\LicenseAcquisition"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
