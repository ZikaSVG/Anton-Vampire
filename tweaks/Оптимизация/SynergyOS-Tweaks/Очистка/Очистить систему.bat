@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить систему

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Очистить систему
echo.

:: --- Очистка системных папок (cleanup.ps1)
if exist "%SystemRoot%\CbsTemp\" rd /s /q "%SystemRoot%\CbsTemp\" >nul 2>&1 & mkdir "%SystemRoot%\CbsTemp\" >nul 2>&1
if exist "%SystemRoot%\Logs\" rd /s /q "%SystemRoot%\Logs\" >nul 2>&1 & mkdir "%SystemRoot%\Logs\" >nul 2>&1
if exist "%SystemRoot%\SoftwareDistribution\" rd /s /q "%SystemRoot%\SoftwareDistribution\" >nul 2>&1 & mkdir "%SystemRoot%\SoftwareDistribution\" >nul 2>&1
if exist "%SystemRoot%\System32\LogFiles\" rd /s /q "%SystemRoot%\System32\LogFiles\" >nul 2>&1 & mkdir "%SystemRoot%\System32\LogFiles\" >nul 2>&1
if exist "%SystemRoot%\System32\LogFiles\WMI\" rd /s /q "%SystemRoot%\System32\LogFiles\WMI\" >nul 2>&1 & mkdir "%SystemRoot%\System32\LogFiles\WMI\" >nul 2>&1
if exist "%SystemRoot%\System32\SleepStudy\" rd /s /q "%SystemRoot%\System32\SleepStudy\" >nul 2>&1 & mkdir "%SystemRoot%\System32\SleepStudy\" >nul 2>&1
if exist "%SystemRoot%\System32\sru\" rd /s /q "%SystemRoot%\System32\sru\" >nul 2>&1 & mkdir "%SystemRoot%\System32\sru\" >nul 2>&1
if exist "%SystemRoot%\System32\WDI\LogFiles\" rd /s /q "%SystemRoot%\System32\WDI\LogFiles\" >nul 2>&1 & mkdir "%SystemRoot%\System32\WDI\LogFiles\" >nul 2>&1
if exist "%SystemRoot%\System32\winevt\Logs\" rd /s /q "%SystemRoot%\System32\winevt\Logs\" >nul 2>&1 & mkdir "%SystemRoot%\System32\winevt\Logs\" >nul 2>&1
if exist "%SystemRoot%\SystemTemp\" rd /s /q "%SystemRoot%\SystemTemp\" >nul 2>&1 & mkdir "%SystemRoot%\SystemTemp\" >nul 2>&1
if exist "%SystemRoot%\Temp\" rd /s /q "%SystemRoot%\Temp\" >nul 2>&1 & mkdir "%SystemRoot%\Temp\" >nul 2>&1

:: --- Восстановить права на SoftwareDistribution (её пересоздаёт WU)
sc config wuauserv start= demand >nul 2>&1
sc start wuauserv >nul 2>&1

echo.
echo [OK] Готово: Очистить систему
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
