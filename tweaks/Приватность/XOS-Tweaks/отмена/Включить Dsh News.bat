@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Dsh News and Interests

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Dsh News and Interests
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Dsh News
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
