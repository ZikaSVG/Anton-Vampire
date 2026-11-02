@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"
set "SETUP=%UTILS%\setup.exe"

echo ================================================================================
echo              MICROSOFT EDGE + WEBVIEW2 — ПОЛНОЕ УДАЛЕНИЕ
echo ================================================================================
echo.
echo   Использует Utils\setup.exe (Microsoft Edge Enterprise Installer).
echo   Если setup.exe нет — fallback на AppX + ручную чистку.
echo.
echo ВНИМАНИЕ: Удаление WebView2 может сломать Teams, Widgets, Office.
echo ================================================================================
echo.

echo [1/5] Завершение процессов...
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im MicrosoftEdgeUpdate.exe >nul 2>&1
taskkill /f /im msedgewebview2.exe >nul 2>&1
taskkill /f /im MicrosoftEdgeCP.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Процессы завершены
echo.

echo [2/5] Проверка setup.exe...
if exist "%SETUP%" (
    echo   [OK] Найден: %SETUP%
    goto :use_setup
) else (
    echo   [ПРЕДУПРЕЖДЕНИЕ] setup.exe не найден в %UTILS%
    echo   Переход к fallback (AppX + ручная чистка)...
    goto :fallback
)

:use_setup
echo [3/5] Удаление Edge через setup.exe...
start /wait "" "%SETUP%" --uninstall --system-level --force-uninstall --msedge >nul 2>&1
echo [OK] Edge удалён
echo.

echo [4/5] Удаление WebView2 через setup.exe...
start /wait "" "%SETUP%" --uninstall --system-level --force-uninstall --msedgewebview >nul 2>&1
echo [OK] WebView2 удалён
echo.

goto :finalize

:fallback
echo [3/5] Fallback: удаление AppX Edge...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Get-AppxPackage -Name '*MicrosoftEdge*' | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }" >nul 2>&1
echo   [OK] AppX Edge удалён
echo.

echo [4/5] Fallback: удаление папок Edge/WebView2...
rd "%ProgramFiles%\Microsoft\Edge" /Q /S >nul 2>&1
rd "%ProgramFiles(x86)%\Microsoft\Edge" /Q /S >nul 2>&1
rd "%ProgramFiles%\Microsoft\EdgeWebView" /Q /S >nul 2>&1
rd "%ProgramFiles(x86)%\Microsoft\EdgeWebView" /Q /S >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\Edge" /Q /S >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\EdgeWebView" /Q /S >nul 2>&1
echo [OK] Папки удалены
echo.

:finalize
echo [5/5] Отключение обновлений Edge...
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "InstallDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "AllowInstallation" /t REG_DWORD /d 0 /f >nul
echo [OK] Обновления отключены
echo.

echo ================================================================================
echo                    ГОТОВО! EDGE + WEBVIEW2 УДАЛЕНЫ
echo ================================================================================
echo.
pause