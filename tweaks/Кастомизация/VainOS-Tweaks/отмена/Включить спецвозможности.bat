@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить спецвозможности

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить спецвозможности
echo.

reg delete "HKCU\SOFTWARE\Microsoft\Ease of Access" /v "selfscan" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Ease of Access" /v "selfvoice" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\HighContrast" /v "Flags" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\TimeOut" /v "Flags" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\SoundSentry" /v "Flags" /f >nul 2>&1
reg delete "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accesibility\SoundSentry" /v "WindowsEffect" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accesibility" /v "Warning Sounds" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accesibility" /v "Sound on Activation" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accessibility\MouseKeys" /v "MaximumSpeed" /f >nul 2>&1
reg delete "HKCU\Control Panel\Accesibility\MouseKeys" /v "TimeToMaximumSpeed" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить спецвозможности
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
