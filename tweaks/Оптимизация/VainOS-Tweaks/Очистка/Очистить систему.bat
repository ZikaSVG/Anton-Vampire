@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить систему

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Очистить систему
echo.

:: --- Temp текущего пользователя (кроме AME)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-ChildItem -Path \"$env:TEMP\" -EA 0 | Where-Object { $_.Name -ne 'AME' } | Remove-Item -Force -Recurse -EA 0" >nul 2>&1

:: --- Windows\Temp
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Remove-Item -Path \"$([Environment]::GetFolderPath('Windows'))\Temp\*\" -Force -Recurse -EA 0" >nul 2>&1

:: --- Удалить VSS-снапшоты
vssadmin delete shadows /all /quiet >nul 2>&1

:: --- Очистить все журналы событий
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "wevtutil el | ForEach-Object { wevtutil cl \"$_\" } 2>&1 | Out-Null" >nul 2>&1

echo.
echo [OK] Готово: Очистить систему
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
