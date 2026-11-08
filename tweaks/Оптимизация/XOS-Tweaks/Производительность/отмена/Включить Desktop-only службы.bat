@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Desktop-only службы

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Desktop-only службы
echo.

for %%S in (Cmbatt acpiex acpipagr acpipmi acpitime bam) do reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 3 /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Desktop-only службы
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
