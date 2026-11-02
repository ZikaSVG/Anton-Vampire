@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Search

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить Windows Search
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\wsearch" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
sc stop wsearch >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"SearchEngine-Client-Package" /NoRestart >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Search
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
