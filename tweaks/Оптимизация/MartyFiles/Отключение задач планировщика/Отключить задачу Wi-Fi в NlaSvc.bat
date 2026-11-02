@echo off
chcp 866 >nul

:: Отключить задачу Wi-Fi в NlaSvc
for %%T in (
    "\Microsoft\Windows\NlaSvc\WiFiTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul