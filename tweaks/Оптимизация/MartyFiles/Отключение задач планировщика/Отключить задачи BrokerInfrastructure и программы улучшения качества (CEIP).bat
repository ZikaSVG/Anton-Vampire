@echo off
chcp 866 >nul

:: Отключить задачи BrokerInfrastructure и программы улучшения качества (CEIP)
for %%T in (
    "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask"
    "\Microsoft\Windows\CEIP\Uploader"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul