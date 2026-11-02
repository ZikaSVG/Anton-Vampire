@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить GDI USER трассировки

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить GDI USER трассировки
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v GDIEnableReferenceStackTraces /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v USERExtraInstrumentations /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v USERPostMortemLogging /f >nul 2>&1

echo.
echo [OK] Отменено: Включить GDI USER трассировки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
