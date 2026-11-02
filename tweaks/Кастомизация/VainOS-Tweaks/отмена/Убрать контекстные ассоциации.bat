@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить контекстные ассоциации

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Добавить контекстные ассоциации
echo.

reg delete "HKLM\SOFTWARE\Classes\.nip" /v "FriendlyTypeName" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\.nip" /v "" /f >nul 2>&1
reg delete "HKCR\.nip" /f >nul 2>&1
reg delete "HKCR\.pow" /f >nul 2>&1
reg delete "HKCR\CABFolder\Shell\RunAs" /f >nul 2>&1
reg delete "HKCR\.reg\ShellNew" /f >nul 2>&1
reg delete "HKCR\.bat\ShellNew" /f >nul 2>&1
reg delete "HKCR\.ps1\ShellNew" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать контекстные ассоциации
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
