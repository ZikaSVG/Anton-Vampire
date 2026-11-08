@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Take Ownership

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Добавить Take Ownership
echo.

reg add "HKCR\*\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKCR\*\shell\TakeOwnership" /v HasLUAShield /t REG_SZ /d "" /f
reg add "HKCR\*\shell\TakeOwnership" /v NoWorkingDirectory /t REG_SZ /d "" /f
reg add "HKCR\*\shell\TakeOwnership\command" /ve /t REG_SZ /d "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%%1\\\" && icacls \\\"%%1\\\" /grant *S-1-3-4:F /t /c /l' -Verb runAs\"" /f
reg add "HKCR\Directory\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKCR\Directory\shell\TakeOwnership" /v HasLUAShield /t REG_SZ /d "" /f
reg add "HKCR\Directory\shell\TakeOwnership" /v NoWorkingDirectory /t REG_SZ /d "" /f
reg add "HKCR\Directory\shell\TakeOwnership" /v Position /t REG_SZ /d "middle" /f
reg add "HKCR\Directory\shell\TakeOwnership\command" /ve /t REG_SZ /d "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%%1\\\" /r /d y && icacls \\\"%%1\\\" /grant *S-1-3-4:F /t /c /l /q' -Verb runAs\"" /f

echo.
echo [OK] Готово: Добавить Take Ownership
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
