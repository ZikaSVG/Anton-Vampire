@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Скрыть последнего пользователя

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Скрыть последнего пользователя
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v dontdisplaylastusername /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Показать последнего пользователя
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
