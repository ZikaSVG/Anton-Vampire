@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить DiagTrack ETL-логи

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить DiagTrack ETL-логи
echo.

del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\DiagTrack*" >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\DiagTrack*" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\ShutdownLogger" >nul 2>&1

echo.
echo [OK] Готово: Удалить DiagTrack ETL-логи
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
