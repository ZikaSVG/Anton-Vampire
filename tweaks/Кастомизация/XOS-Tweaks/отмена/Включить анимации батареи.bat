@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить всегда-на-батарее анимации

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить всегда-на-батарее анимации
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: Включить анимации батареи
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
