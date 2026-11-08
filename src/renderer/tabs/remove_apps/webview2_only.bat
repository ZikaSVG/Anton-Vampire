@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"
set "SETUP=%UTILS%\setup.exe"

echo ================================================================================
echo              MICROSOFT WEBVIEW2 — УДАЛЕНИЕ
echo ================================================================================
echo.
echo   Удаляет только WebView2 Runtime. Edge НЕ трогает.
echo.
echo ВНИМАНИЕ: WebView2 используется в Teams, Widgets, Office,
echo           Slack, Discord и др. приложениях.
echo ================================================================================
echo.

echo [1/5] Завершение процессов WebView2...
taskkill /f /im msedgewebview2.exe >nul 2>&1
taskkill /f /im MicrosoftEdgeUpdate.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Процессы завершены
echo.

echo [2/5] Удаление через setup.exe (если есть)...
if exist "%SETUP%" (
    start /wait "" "%SETUP%" --uninstall --system-level --force-uninstall --msedgewebview >nul 2>&1
    echo [OK] setup.exe выполнен
) else (
    echo   [ПРЕДУПРЕЖДЕНИЕ] setup.exe не найден — AppX + ручная чистка
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "Get-AppxPackage -Name '*MicrosoftEdgeWebView*' | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }" >nul 2>&1
)
echo.

echo [3/5] Удаление папок WebView2...
rd "%ProgramFiles%\Microsoft\EdgeWebView" /Q /S >nul 2>&1
rd "%ProgramFiles(x86)%\Microsoft\EdgeWebView" /Q /S >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\EdgeWebView" /Q /S >nul 2>&1
echo [OK] Папки удалены
echo.

echo [4/5] Удаление записей реестра WebView2...
reg delete "HKLM\SOFTWARE\Microsoft\EdgeUpdate\Clients\{F1E7E9CD-BA48-4B1F-9E1A-3F5F7E5CF8F3}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F1E7E9CD-BA48-4B1F-9E1A-3F5F7E5CF8F3}" /f >nul 2>&1
echo [OK] Реестр очищен
echo.

echo [5/5] Блокировка переустановки...
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "InstallDefault" /t REG_DWORD /d 0 /f >nul
echo [OK] Переустановка заблокирована
echo.

echo ================================================================================
echo                    ГОТОВО! WEBVIEW2 УДАЛЁН
echo ================================================================================
echo.
pause