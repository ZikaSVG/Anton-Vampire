@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Оптимизация Input HKLM

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Оптимизация Input HKLM
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Input" /v IsInputAppPreloadEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Input\Settings" /v DisableExpressiveInputShellHotkey /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Input\Settings" /v DisablePersonalizationGTKM /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v DisableExpressiveInputShellHotkey /f >nul 2>&1

echo.
echo [OK] Отменено: Откат оптимизации Input HKLM
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
