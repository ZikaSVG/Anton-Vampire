@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Скрыть иконку Defender в трее

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Скрыть иконку Defender в трее
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: Показать иконку Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
