@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo                 ONEDRIVE — МЯГКОЕ УДАЛЕНИЕ (Optimizer)
echo ================================================================================
echo.
echo   Процесс + официальный деинсталлятор + папки + CLSID из Проводника.
echo   Без политик, без задач, без блокировки переустановки.
echo.
echo ================================================================================
echo.

echo [1/4] Завершение процесса OneDrive.exe...
taskkill /f /im OneDrive.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Процесс завершён
echo.

echo [2/4] Удаление через OneDriveSetup.exe...
set "X64=%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
set "X86=%SYSTEMROOT%\System32\OneDriveSetup.exe"

if exist "%X64%" (
    start /wait "" "%X64%" /uninstall
) else if exist "%X86%" (
    start /wait "" "%X86%" /uninstall
) else (
    echo   [ПРЕДУПРЕЖДЕНИЕ] OneDriveSetup.exe не найден
)
timeout /t 2 /nobreak >nul
echo [OK] Деинсталлятор выполнен
echo.

echo [3/4] Удаление папок OneDrive...
rd "%USERPROFILE%\OneDrive" /Q /S >nul 2>&1
rd "C:\OneDriveTemp" /Q /S >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >nul 2>&1
rd "%LOCALAPPDATA%\OneDrive" /Q /S >nul 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >nul 2>&1
echo [OK] Папки удалены
echo.

echo [4/4] Удаление OneDrive из панели Проводника...
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
echo [OK] CLSID удалён
echo.

echo ================================================================================
echo                       ГОТОВО! ONEDRIVE УДАЛЁН (мягко)
echo ================================================================================
echo.
pause