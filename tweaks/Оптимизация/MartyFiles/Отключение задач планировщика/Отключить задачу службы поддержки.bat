@echo off
chcp 866 >nul

:: Отключить задачу службы поддержки
for %%T in (
    "\Microsoft\Windows\ContactSupport\Scheduled"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul