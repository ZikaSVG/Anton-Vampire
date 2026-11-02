@echo off
chcp 866 >nul

:: Отключить задачи классификации файлов и истории файлов
for %%T in (
    "\Microsoft\Windows\File Classification Infrastructure\Property Definition Sync"
    "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

chcp 65001 >nul