@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo              MICROSOFT EDGE — УДАЛЕНИЕ APPX (без WebView2)
echo ================================================================================
echo.
echo   Удаляет только AppX-пакет Edge. WebView2 НЕ трогает,
echo   поэтому Teams, Widgets, Office продолжат работать.
echo.
echo ================================================================================
echo.

echo [1/4] Завершение процессов Edge...
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im MicrosoftEdgeUpdate.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Процессы завершены
echo.

echo [2/4] Удаление AppX-пакета Edge...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Get-AppxPackage -Name '*MicrosoftEdge*' | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }" >nul 2>&1
echo [OK] AppX-пакет Edge удалён
echo.

echo [3/4] Удаление Edge из автозагрузки...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
echo [OK] Автозагрузка очищена
echo.

echo [4/4] Отключение обновлений Edge...
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "InstallDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "AllowInstallation" /t REG_DWORD /d 0 /f >nul
echo [OK] Обновления Edge отключены
echo.

echo ================================================================================
echo                    ГОТОВО! EDGE (APPX) УДАЛЁН
echo ================================================================================
echo.
pause