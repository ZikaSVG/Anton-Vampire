@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить спецвозможности

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить спецвозможности
echo.

reg add "HKCU\SOFTWARE\Microsoft\Ease of Access" /v "selfscan" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Ease of Access" /v "selfvoice" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\HighContrast" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\TimeOut" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\SoundSentry" /v "Flags" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accesibility\SoundSentry" /v "WindowsEffect" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accesibility" /v "Warning Sounds" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accesibility" /v "Sound on Activation" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\MouseKeys" /v "MaximumSpeed" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCU\Control Panel\Accesibility\MouseKeys" /v "TimeToMaximumSpeed" /t REG_SZ /d "" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить спецвозможности
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
