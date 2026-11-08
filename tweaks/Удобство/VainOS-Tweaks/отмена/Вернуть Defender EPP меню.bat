@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Defender EPP меню

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Defender EPP меню
echo.

reg add "HKLM\SOFTWARE\Classes\*\ShellEx\ContextMenuHandlers\EPP" /v "" /t REG_SZ /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\Drive\ShellEx\ContextMenuHandlers\EPP" /v "" /t REG_SZ /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\Directory\ShellEx\ContextMenuHandlers\EPP" /v "" /t REG_SZ /d "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть Defender EPP меню
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
