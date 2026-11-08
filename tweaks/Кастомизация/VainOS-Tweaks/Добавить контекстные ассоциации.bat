@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить контекстные ассоциации

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Добавить контекстные ассоциации
echo.

:: --- .nip (nvidiaProfileInspector)
reg add "HKLM\SOFTWARE\Classes\.nip" /v "FriendlyTypeName" /t REG_SZ /d "nvidiaProfileInspector Profile" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\.nip" /v "" /t REG_SZ /d "nvidiaProfileInspector Profile" /f >nul 2>&1
reg add "HKCR\.nip\Shell" /v "" /t REG_SZ /d "Import" /f >nul 2>&1
reg add "HKCR\.nip\Shell\Import\Command" /v "" /t REG_EXPAND_SZ /d ""C:\Windows\Modules\nvidiaprofileinspector.exe" "%1"" /f >nul 2>&1
reg add "HKCR\.nip\DefaultIcon" /v "" /t REG_EXPAND_SZ /d "c:\windows\modules\nvidiaprofileinspector.exe,0" /f >nul 2>&1
:: --- .pow (Power Plan)
reg add "HKCR\.pow" /v "" /t REG_SZ /d "Power Plan" /f >nul 2>&1
reg add "HKCR\.pow" /v "FriendlyTypeName" /t REG_SZ /d "Power Plan" /f >nul 2>&1
reg add "HKCR\.pow\DefaultIcon" /v "" /t REG_EXPAND_SZ /d "%SystemRoot%\System32\powercfg.cpl,-202" /f >nul 2>&1
reg add "HKCR\.pow\shell\Import\command" /v "" /t REG_SZ /d "powercfg /import "%1"" /f >nul 2>&1
:: --- CABFolder\Shell\RunAs (Install)
reg add "HKCR\CABFolder\Shell\RunAs" /v "" /t REG_SZ /d "Install" /f >nul 2>&1
reg add "HKCR\CABFolder\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\CABFolder\Shell\RunAs\Command" /v "" /t REG_SZ /d "cmd /k dism /online /add-package /packagepath:"%1"" /f >nul 2>&1
:: --- .reg\ShellNew
reg add "HKCR\.reg\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\.reg\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "%windir%\regedit.exe,-309" /f >nul 2>&1
:: --- .bat\ShellNew
reg add "HKCR\.bat\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "%windir%\System32\acppage.dll,-6002" /f >nul 2>&1
reg add "HKCR\.bat\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul 2>&1
:: --- .ps1 + ShellNew
reg add "HKCR\.ps1" /v "" /t REG_SZ /d "Microsoft.PowerShellScript.1" /f >nul 2>&1
reg add "HKCR\.ps1\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1" /v "" /t REG_SZ /d "Windows PowerShell Script" /f >nul 2>&1
reg add "HKCR\Microsoft.PowerShellScript.1" /v "FriendlyTypeName" /t REG_SZ /d "Windows PowerShell Script" /f >nul 2>&1

echo.
echo [OK] Готово: Добавить контекстные ассоциации
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
