@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo                 ONEDRIVE — ХАРДКОР УДАЛЕНИЕ
echo ================================================================================
echo.
echo   Дополнительно: убийство Explorer, takeown/icacls, WinSxS,
echo   расширенные политики, очистка HKCU\Software\Microsoft\OneDrive.
echo.
echo ВНИМАНИЕ: Explorer перезапустится автоматически.
echo ================================================================================
echo.

echo [1/13] Завершение процессов...
taskkill /f /im OneDrive.exe >nul 2>&1
taskkill /f /im FileCoAuth.exe >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
echo [OK] Процессы завершены
echo.

echo [2/13] Удаление из автозагрузки (HKCU и HKLM)...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
echo [OK] Автозагрузка очищена
echo.

echo [3/13] Деинсталляция через OneDriveSetup.exe...
set "X64=%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
set "X86=%SYSTEMROOT%\System32\OneDriveSetup.exe"
if exist "%X64%" start /wait "" "%X64%" /uninstall
if exist "%X86%" start /wait "" "%X86%" /uninstall
timeout /t 2 /nobreak >nul
echo [OK] Деинсталлятор выполнен
echo.

echo [4/13] Удаление папок с забором владения...
for %%P in (
    "%USERPROFILE%\OneDrive"
    "%USERPROFILE%\OneDrive - Personal"
    "%LOCALAPPDATA%\Microsoft\OneDrive"
    "%PROGRAMDATA%\Microsoft OneDrive"
    "C:\OneDriveTemp"
) do (
    if exist %%P (
        takeown /f %%P /r /d y >nul 2>&1
        icacls %%P /grant administrators:F /t >nul 2>&1
        rd %%P /Q /S >nul 2>&1
    )
)
echo [OK] Папки удалены
echo.

echo [5/13] Удаление ярлыков...
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Links\OneDrive.lnk" >nul 2>&1
del /f /q "%PUBLIC%\Desktop\OneDrive.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\OneDrive.lnk" >nul 2>&1
echo [OK] Ярлыки удалены
echo.

echo [6/13] Удаление CLSID из всех веток...
for %%K in (
    "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
) do reg delete %%K /f >nul 2>&1
echo [OK] CLSID удалены
echo.

echo [7/13] Расширенные политики OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisablePersonalSync" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики добавлены
echo.

echo [8/13] Удаление задач планировщика...
schtasks /delete /tn "\OneDrive Reporting Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Standalone Update Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Per-Machine Standalone Update" /f >nul 2>&1
echo [OK] Задачи удалены
echo.

echo [9/13] Удаление переменных среды...
reg delete "HKCU\Environment" /v "OneDrive" /f >nul 2>&1
reg delete "HKCU\Environment" /v "OneDriveConsumer" /f >nul 2>&1
reg delete "HKCU\Environment" /v "OneDriveCommercial" /f >nul 2>&1
echo [OK] Переменные удалены
echo.

echo [10/13] Очистка HKCU\Software\Microsoft\OneDrive...
reg delete "HKCU\Software\Microsoft\OneDrive" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\OneDrive\Accounts" /f >nul 2>&1
echo [OK] Ветка HKCU очищена
echo.

echo [11/13] Удаление компонента OneDriveSetup из WinSxS...
if exist "%NS%" (
    for /d %%D in ("%SYSTEMROOT%\WinSxS\amd64_microsoft-windows-onedrive-setup*") do (
        "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "rd /s /q ""%%D""" >nul 2>&1
    )
) else (
    for /d %%D in ("%SYSTEMROOT%\WinSxS\amd64_microsoft-windows-onedrive-setup*") do (
        takeown /f "%%D" /r /d y >nul 2>&1
        icacls "%%D" /grant administrators:F /t >nul 2>&1
        rd "%%D" /Q /S >nul 2>&1
    )
)
echo [OK] Компонент WinSxS обработан
echo.

echo [12/13] Удаление OneDriveSetup.exe и OneDrive.ico...
if exist "%NS%" (
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%SYSTEMROOT%\System32\OneDriveSetup.exe"" >nul 2>&1"
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%SYSTEMROOT%\System32\OneDrive.ico"" >nul 2>&1"
    "%NS%" -U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c "del /f /q ""%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"" >nul 2>&1"
) else (
    del /f /q "%SYSTEMROOT%\System32\OneDriveSetup.exe" >nul 2>&1
    del /f /q "%SYSTEMROOT%\System32\OneDrive.ico" >nul 2>&1
    del /f /q "%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe" >nul 2>&1
)
echo [OK] Файлы удалены
echo.

echo [13/13] Применение политик и перезапуск Explorer...
gpupdate /force >nul 2>&1
start explorer.exe
echo [OK] Готово
echo.

echo ================================================================================
echo                    ГОТОВО! ONEDRIVE УДАЛЁН (ХАРДКОР)
echo ================================================================================
echo.
pause