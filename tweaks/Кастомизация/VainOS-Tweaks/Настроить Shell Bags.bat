@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить Shell Bags

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить Shell Bags
echo.

reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v "FolderType" /f >nul 2>&1
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v "FolderType" /t REG_SZ /d "NotSpecified" /f >nul 2>&1
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v "Logo" /t REG_SZ /d "imageres.dll,-3" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить Shell Bags
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
