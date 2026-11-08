@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Скрыть страницы в Параметрах

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Скрыть страницы в Параметрах
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /t REG_SZ /d "hide:home;privacy-automaticfiledownloads;privacy-feedback;windowsinsider;deviceusage;maps;otherusers;findmydevice;windowsdefender;quiethours;powersleep;batterysaver;batterysaver-settings;storagesense;storagepolicies;savelocations;project;crossdevice;mobile-devices;network-dialup;videoplayback;search-permissions;cortana-windowssearch;privacy-speech;privacy-speechtyping;privacy-activityhistory;recovery;troubleshoot;privacy-general;pen;personalization-textinput" /f >nul 2>&1

echo.
echo [OK] Готово: Скрыть страницы в Параметрах
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
