@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить Sticky Keys и Accessibility

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Настроить Sticky Keys и Accessibility
echo.

reg add "HKCU\SOFTWARE\Microsoft\Narrator\NoRoam" /v WinEnterLaunchEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d "2" /f
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d "34" /f
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v Flags /t REG_SZ /d "130" /f
reg add "HKCU\Control Panel\Accessibility\HighContrast" /v Flags /t REG_SZ /d "4194" /f

echo.
echo [OK] Готово: Настроить Sticky Keys и Accessibility
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
