@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить 7-Zip

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить 7-Zip
echo.

reg add "HKCU\Software\7-Zip\FM\Columns" /v "RootFolder" /t REG_BINARY /d "0100000000000000010000000400000001000000a0000000" /f >nul 2>&1
reg add "HKCU\Software\7-Zip\Options" /v "ContextMenu" /t REG_DWORD /d "4871" /f >nul 2>&1
reg add "HKCU\Software\7-Zip\Options" /v "ElimDupExtract" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCR\Applications\7zFM.exe\shell\open\command" /v "" /t REG_SZ /d ""C:\Program Files\7-Zip\7zFM.exe" "%1"" /f >nul 2>&1
reg add "HKCR\*\OpenWithList\7zFM.exe" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить 7-Zip
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
