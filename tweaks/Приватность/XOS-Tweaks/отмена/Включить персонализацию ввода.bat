@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить персонализацию ввода

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить персонализацию ввода
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v AllowInputPersonalization /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /f >nul 2>&1

echo.
echo [OK] Отменено: Включить персонализацию ввода
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
