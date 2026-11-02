@echo off
chcp 65001 >nul
title GameDVR / Панель NVIDIA
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
reg add "HKCU\System\GameConfigStore"      /v "GameDVR_Enabled"     /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar"  /v "AllowAutoGameMode"   /t REG_DWORD /d 0 /f >nul 2>&1
sc config NVDisplay.ContainerLocalSystem start= auto >nul 2>&1
echo Готово. GameDVR отключён, панель NVIDIA возвращена.