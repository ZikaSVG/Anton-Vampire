@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Применить RunAsTI

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Применить RunAsTI
echo.

:: --- Удаляем ключ HKCR\RunAsTI
reg delete "HKCR\RunAsTI" /f >nul 2>&1

:: --- Удаляем пункты меню RunAsTI
for %%K in (
  "HKCR\batfile\shell\setdesktopwallpaper"
  "HKCR\cmdfile\shell\setdesktopwallpaper"
  "HKCR\exefile\shell\setdesktopwallpaper"
  "HKCR\mscfile\shell\setdesktopwallpaper"
  "HKCR\Microsoft.PowerShellScript.1\shell\setdesktopwallpaper"
  "HKCR\regfile\shell\setdesktopwallpaper"
  "HKCR\Folder\shell\setdesktopwallpaper"
) do reg delete %%K /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать RunAsTI
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
