@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"
set "SETUP=%UTILS%\setup.exe"

echo ================================================================================
echo              MICROSOFT EDGE + WEBVIEW2 — ХАРДКОР УДАЛЕНИЕ
echo ================================================================================
echo.
echo   AppX + setup.exe + takeown + реестр + задачи + ярлыки + политики.
echo.
echo ВНИМАНИЕ: WebView2 используется в Teams, Widgets, Office.
echo ================================================================================
echo.

echo [1/9] Завершение процессов...
for %%P in (msedge.exe MicrosoftEdgeUpdate.exe msedgewebview2.exe MicrosoftEdgeCP.exe identity_helper.exe) do taskkill /f /im %%P >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Процессы завершены
echo.

echo [2/9] Удаление AppX-пакетов Edge...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Get-AppxPackage -Name '*MicrosoftEdge*' | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }" >nul 2>&1
echo [OK] AppX Edge удалён
echo.

echo [3/9] Удаление через setup.exe (если есть)...
if exist "%SETUP%" (
    echo   Используем %SETUP%
    start /wait "" "%SETUP%" --uninstall --system-level --force-uninstall --msedge >nul 2>&1
    start /wait "" "%SETUP%" --uninstall --system-level --force-uninstall --msedgewebview >nul 2>&1
    echo [OK] setup.exe выполнен
) else (
    echo   [ПРЕДУПРЕЖДЕНИЕ] setup.exe не найден
)
echo.

echo [4/9] Удаление папок с забором владения...
for %%P in (
    "%ProgramFiles%\Microsoft\Edge"
    "%ProgramFiles(x86)%\Microsoft\Edge"
    "%ProgramFiles%\Microsoft\EdgeWebView"
    "%ProgramFiles(x86)%\Microsoft\EdgeWebView"
    "%ProgramFiles%\Microsoft\EdgeUpdate"
    "%ProgramFiles(x86)%\Microsoft\EdgeUpdate"
    "%LOCALAPPDATA%\Microsoft\Edge"
    "%LOCALAPPDATA%\Microsoft\EdgeWebView"
    "%LOCALAPPDATA%\Microsoft\EdgeUpdate"
    "%PROGRAMDATA%\Microsoft\EdgeUpdate"
) do (
    if exist %%P (
        takeown /f %%P /r /d y >nul 2>&1
        icacls %%P /grant administrators:F /t >nul 2>&1
        rd %%P /Q /S >nul 2>&1
    )
)
echo [OK] Папки удалены
echo.

echo [5/9] Удаление ярлыков...
del /f /q "%PUBLIC%\Desktop\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" >nul 2>&1
echo [OK] Ярлыки удалены
echo.

echo [6/9] Удаление задач планировщика Edge...
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
schtasks /delete /tn "\MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
schtasks /delete /tn "\MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
echo [OK] Задачи удалены
echo.

echo [7/9] Удаление реестра Edge...
for %%K in (
    "HKLM\SOFTWARE\Microsoft\Edge"
    "HKLM\SOFTWARE\WOW6432Node\Microsoft\Edge"
    "HKCU\SOFTWARE\Microsoft\Edge"
    "HKLM\SOFTWARE\Microsoft\EdgeUpdate"
    "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate"
    "HKCU\SOFTWARE\Microsoft\EdgeUpdate"
    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
    "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge"
    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
    "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView"
) do reg delete %%K /f >nul 2>&1
echo [OK] Реестр очищен
echo.

echo [8/9] Политики отключения Edge...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "InstallDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "AllowInstallation" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcutDefault" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "RemoveDesktopShortcutDefault" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики добавлены
echo.

echo [9/9] Финальная очистка...
rd "%LOCALAPPDATA%\Microsoft\EdgeUpdate" /Q /S >nul 2>&1
rd "%PROGRAMDATA%\Microsoft\EdgeUpdate" /Q /S >nul 2>&1
gpupdate /force >nul 2>&1
echo [OK] Готово
echo.

echo ================================================================================
echo                    ГОТОВО! EDGE + WEBVIEW2 УДАЛЕНЫ (ХАРДКОР)
echo ================================================================================
echo.
echo ВАЖНО: Перезагрузите компьютер для полного применения.
echo.
pause