@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить PowerShell

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить PowerShell
echo.

:: --- Отключить телеметрию
setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>&1

:: --- ftype + ExecutionPolicy
ftype Microsoft.PowerShellScript.1="%windir%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -EP Unrestricted -File "%1" %* >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "Unrestricted" /f >nul 2>&1

:: --- Ассоциации
reg add "HKCR\Microsoft.PowerShellScript.1\Shell" /v "" /t REG_SZ /d "Open" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\Open\Command" /v "" /t REG_EXPAND_SZ /d ""%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" "%1"" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs\Command" /v "" /t REG_EXPAND_SZ /d ""%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" "%1"" /f >nul 2>&1
reg add "HKCR\.psm1" /v "" /t REG_SZ /d "Microsoft.PowerShellModule.1" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellModule.1\Shell" /v "" /t REG_SZ /d "Open" /f >nul 2>&1
reg add "HKCR\.psm1\OpenWithProgids" /f >nul 2>&1
reg add "HKCR\.ps1\OpenWithProgids" /f >nul 2>&1

:: --- Module Logging / Script Block Logging = 0
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" /v "EnableModuleLogging" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockLogging" /t REG_DWORD /d "0" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить PowerShell
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
