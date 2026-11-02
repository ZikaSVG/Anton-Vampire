@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить прозрачность

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить прозрачность
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить прозрачность
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
