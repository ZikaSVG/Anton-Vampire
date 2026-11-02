@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить тёмную тему

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Включить тёмную тему
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Включить тёмную тему
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
