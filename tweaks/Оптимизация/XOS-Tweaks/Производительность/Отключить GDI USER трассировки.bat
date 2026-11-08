@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить GDI USER трассировки

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить GDI USER трассировки
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v GDIEnableReferenceStackTraces /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v USERExtraInstrumentations /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v USERPostMortemLogging /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters" /v VerboseOn /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить GDI USER трассировки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
