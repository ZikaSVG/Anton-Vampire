@echo off
chcp 866 >nul

:: Отключить задачи очистки обновлений и лицензирования Clip
for %%T in (
    "\Microsoft\Windows\Cleanup\UpdateCleanup"
    "\Microsoft\Windows\Clip\License Validation"
    "\Microsoft\Windows\Clip\LicenseImdsIntegration"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul