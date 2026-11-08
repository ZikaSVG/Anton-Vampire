@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить всегда-на-батарее анимации

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить всегда-на-батарее анимации
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f

echo.
echo [OK] Готово: Отключить всегда-на-батарее анимации
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
