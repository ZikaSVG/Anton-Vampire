@echo off
chcp 65001 >nul
title Перезапуск звука
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
echo Перезапуск аудио-движка Windows...
net stop audiosrv /y >nul 2>&1
net stop AudioEndpointBuilder /y >nul 2>&1
net start AudioEndpointBuilder >nul 2>&1
net start audiosrv >nul 2>&1
sc query audiosrv | findstr /i "RUNNING" >nul
if errorlevel 1 (
    echo [!] Не удалось запустить Audiosrv. Проверьте службу вручную.
) else (
    echo Готово. Аудио-движок перезапущен.
)
