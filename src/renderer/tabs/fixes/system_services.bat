@echo off
chcp 65001 >nul
title Службы Windows
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
sc config WSearch start= auto >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
sc config WpnService  start= auto   >nul 2>&1
sc config vds         start= demand >nul 2>&1
sc config defragsvc   start= demand >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f >nul 2>&1
echo Готово. Поиск, уведомления, дефрагментация восстановлены.