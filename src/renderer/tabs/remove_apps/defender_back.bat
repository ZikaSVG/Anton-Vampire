@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo              WINDOWS DEFENDER — ВОЗВРАТ (после отключения)
echo ================================================================================
echo.

echo [1/3] Удаление политик отключения...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f >nul 2>&1
echo [OK] Политики удалены
echo.

echo [2/3] Запуск служб...
sc start WinDefend >nul 2>&1
sc start WdNisSvc >nul 2>&1
sc start wscsvc >nul 2>&1
echo [OK] Службы запущены
echo.

echo [3/3] Включение SmartScreen...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Warn" /f >nul
gpupdate /force >nul 2>&1
echo [OK] SmartScreen включён
echo.

echo ================================================================================
echo              ГОТОВО! DEFENDER ВОЗВРАЩЁН
echo ================================================================================
echo.
pause