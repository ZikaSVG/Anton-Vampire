@echo off
chcp 65001 >nul
title Восстановление устройств
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)

:: Микрофон и камера — оба возможных имени ключа (Win10/Win11)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam"     /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\camera"     /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1

sc config FrameServer                start= demand >nul 2>&1
sc config AudioEndpointBuilder       start= auto   >nul 2>&1
sc config Audiosrv                   start= auto   >nul 2>&1
sc config BthHFSrv                   start= demand >nul 2>&1
sc config bthserv                    start= auto   >nul 2>&1
sc config DeviceAssociationService   start= demand >nul 2>&1
sc config DeviceInstall              start= demand >nul 2>&1
sc config Spooler                    start= auto   >nul 2>&1

echo Готово. Микрофон, камера, Bluetooth, принтер включены.