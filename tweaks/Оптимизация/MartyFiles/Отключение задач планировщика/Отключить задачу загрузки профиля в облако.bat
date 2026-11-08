@echo off
chcp 866 >nul

:: Отключить задачу: загрузки профиля в облако
for %%T in (
    "\Microsoft\Windows\User Profile Service\HiveUploadTask"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul
