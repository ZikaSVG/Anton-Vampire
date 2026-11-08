@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Take Ownership

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Добавить Take Ownership
echo.

reg add "HKCR\Directory\shell\runas" /v "" /t REG_SZ /d "Take Ownership" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /c takeown /f %1 /r /d y && icacls %1 /grant administrators:F" /f >nul 2>&1
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f %1 /r /d y && icacls %1 /grant administrators:F" /f >nul 2>&1

echo.
echo [OK] Готово: Добавить Take Ownership
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
