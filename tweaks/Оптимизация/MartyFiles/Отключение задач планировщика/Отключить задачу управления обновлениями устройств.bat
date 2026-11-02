@echo off
chcp 866 >nul

:: Отключить задачу управления обновлениями устройств
for %%T in (
    "\Microsoft\Windows\DUSM\dusmtask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul