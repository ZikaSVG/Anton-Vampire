@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Search

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Windows Search
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\wsearch" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
DISM.exe /Online /Enable-Feature /FeatureName:"SearchEngine-Client-Package" /NoRestart >nul 2>&1

echo.
echo [OK] Отменено: Включить Windows Search
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
