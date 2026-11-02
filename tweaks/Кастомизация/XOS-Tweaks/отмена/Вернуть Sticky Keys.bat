@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить Sticky Keys и Accessibility

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Настроить Sticky Keys и Accessibility
echo.

reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d "510" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d "122" /f
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d "62" /f
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v Flags /t REG_SZ /d "62" /f
reg add "HKCU\Control Panel\Accessibility\HighContrast" /v Flags /t REG_SZ /d "126" /f

echo.
echo [OK] Отменено: Вернуть Sticky Keys
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
