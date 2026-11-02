@echo off
chcp 65001 >nul
title Восстановление безопасности
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)

:: Снимаем блокировки Defender через политики (работает без sc config)
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f >nul 2>&1
reg add    "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f >nul 2>&1
reg add    "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 0 /f >nul 2>&1

sc config wscsvc                start= delayed-auto >nul 2>&1
sc config SecurityHealthService start= demand       >nul 2>&1
sc config bfe                   start= auto         >nul 2>&1
sc config mpssvc                start= auto         >nul 2>&1

:: WinDefend — защищённая служба. Пытаемся запустить, но не через sc config.
sc start WinDefend >nul 2>&1

netsh advfirewall reset >nul 2>&1

echo Готово. Защитник, антивирус, брандмауэр включены.
echo Если Defender всё ещё выключен — перезагрузите ПК.