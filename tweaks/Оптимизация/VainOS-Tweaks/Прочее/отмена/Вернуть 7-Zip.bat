@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить 7-Zip

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить 7-Zip
echo.

reg delete "HKCU\Software\7-Zip\FM\Columns" /v "RootFolder" /f >nul 2>&1
reg delete "HKCU\Software\7-Zip\Options" /v "ContextMenu" /f >nul 2>&1
reg delete "HKCU\Software\7-Zip\Options" /v "ElimDupExtract" /f >nul 2>&1
reg delete "HKCR\Applications\7zFM.exe\shell\open\command" /f >nul 2>&1
reg delete "HKCR\*\OpenWithList\7zFM.exe" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть 7-Zip
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
