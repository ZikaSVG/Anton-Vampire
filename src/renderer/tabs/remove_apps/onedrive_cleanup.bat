@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ================================================================================
echo              ONEDRIVE — ЗАЧИСТКА СЛЕДОВ
echo ================================================================================
echo.
echo   Удаляет остатки после удаления OneDrive:
echo     - пустые папки
echo     - ярлыки в меню Пуск и на рабочем столе
echo     - кэш и временные файлы
echo     - ветки реестра с путями
echo.
echo   Запускать ПОСЛЕ основного удаления.
echo.
echo ================================================================================
echo.

echo [1/6] Удаление ярлыков...
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Links\OneDrive.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\OneDrive.lnk" >nul 2>&1
del /f /q "%PUBLIC%\Desktop\OneDrive.lnk" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\OneDrive.lnk" >nul 2>&1
echo [OK] Ярлыки удалены
echo.

echo [2/6] Удаление пустых папок OneDrive...
for %%P in (
    "%USERPROFILE%\OneDrive"
    "%USERPROFILE%\OneDrive - Personal"
    "%USERPROFILE%\OneDrive - Компания"
    "%LOCALAPPDATA%\Microsoft\OneDrive"
    "%PROGRAMDATA%\Microsoft OneDrive"
    "C:\OneDriveTemp"
) do (
    if exist %%P rd %%P /Q /S >nul 2>&1
)
echo [OK] Папки удалены
echo.

echo [3/6] Очистка кэша Проводника...
rd "%LOCALAPPDATA%\Microsoft\Windows\Explorer" /Q /S >nul 2>&1
echo [OK] Кэш Проводника очищен
echo.

echo [4/6] Удаление веток реестра с путями...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
echo [OK] Ветки реестра очищены
echo.

echo [5/6] Удаление временных файлов OneDrive...
del /f /q "%TEMP%\OneDrive*" >nul 2>&1
del /f /q "%TEMP%\*.oneDrive*" >nul 2>&1
echo [OK] Временные файлы удалены
echo.

echo [6/6] Перезапуск Проводника...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
start explorer.exe
echo [OK] Проводник перезапущен
echo.

echo ================================================================================
echo                    ГОТОВО! СЛЕДЫ ONEDRIVE ОЧИЩЕНЫ
echo ================================================================================
echo.
pause