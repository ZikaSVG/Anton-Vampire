@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Включить Segment Heap

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Включить Segment Heap
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "Segment Heap" /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: Отключить Segment Heap
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
