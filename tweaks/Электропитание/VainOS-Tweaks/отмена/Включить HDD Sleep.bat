@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить HDD Sleep (Sub_Processor)

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить HDD Sleep (Sub_Processor)
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\dab60367-53fe-4fbc-825e-521d069d2456" /v "Attributes" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить HDD Sleep
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
