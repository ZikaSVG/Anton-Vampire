@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Импортировать XOS Power Plan

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Импортировать XOS Power Plan
echo.

if exist "%windir%\imribiy.pow" (
  powercfg -import "%windir%\imribiy.pow" 31693169-3169-3169-3169-316931693169 >nul 2>&1
  powercfg /setacvalueindex 31693169-3169-3169-3169-316931693169 SUB_VIDEO VIDEOIDLE 0 >nul 2>&1
  powercfg /setdcvalueindex 31693169-3169-3169-3169-316931693169 SUB_VIDEO VIDEOIDLE 0 >nul 2>&1
  powercfg /setacvalueindex 31693169-3169-3169-3169-316931693169 SUB_SLEEP STANDBYIDLE 0 >nul 2>&1
  powercfg /setdcvalueindex 31693169-3169-3169-3169-316931693169 SUB_SLEEP STANDBYIDLE 0 >nul 2>&1
  powercfg /setacvalueindex 31693169-3169-3169-3169-316931693169 SUB_SLEEP HIBERNATEIDLE 0 >nul 2>&1
  powercfg /setdcvalueindex 31693169-3169-3169-3169-316931693169 SUB_SLEEP HIBERNATEIDLE 0 >nul 2>&1
) else (
  echo [!] imribiy.pow не найден в %windir%
)

echo.
echo [OK] Готово: Импортировать XOS Power Plan
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
