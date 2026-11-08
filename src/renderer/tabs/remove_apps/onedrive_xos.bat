@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem === Пути к Utils ===
set "UTILS=%~dp0..\..\..\Utils"
set "NS=%UTILS%\NSudoLG.exe"

echo ================================================================================
echo                 ONEDRIVE — ПОЛНОЕ УДАЛЕНИЕ (xOS Edition)
echo ================================================================================
echo.
echo   Процесс + автозагрузка + setup.exe + папки + ярлыки + CLSID +
echo   политики + задачи + переменные среды + gpupdate.
echo.
echo ================================================================================
echo.

echo [1/11] Завершение процесса OneDrive...
taskkill /f /im OneDrive.exe > nul 2>&1
taskkill /f /im OneDrive.App.exe > nul 2>&1
taskkill /f /im FileCoAuth.exe > nul 2>&1
timeout /t 1 /nobreak >nul
echo [OK] Процесс завершён
echo.

echo [2/11] Удаление OneDrive из автозагрузки...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1
echo [OK] Автозагрузка очищена
echo.

echo [3/11] Деинсталляция OneDrive...
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

echo [4/11] Удаление папок OneDrive...
rd "%USERPROFILE%\OneDrive" /Q /S >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S >nul 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S >nul 2>&1
rd "C:\OneDriveTemp" /Q /S >nul 2>&1
echo [OK] Папки удалены
echo.

echo [5/11] Удаление ярлыков OneDrive...
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Links\OneDrive.lnk" >nul 2>&1
del /f /q "%SYSTEMROOT%\ServiceProfiles\LocalService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
del /f /q "%SYSTEMROOT%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
echo [OK] Ярлыки удалены
echo.

echo [6/11] Удаление CLSID OneDrive...
reg delete "HKCU\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
echo [OK] CLSID удалён
echo.

echo [7/11] Добавление политик отключения OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f >nul
echo [OK] Политики добавлены
echo.

echo [8/11] Удаление задач планировщика OneDrive...
schtasks /delete /tn "\OneDrive Reporting Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Standalone Update Task" /f >nul 2>&1
schtasks /delete /tn "\OneDrive Per-Machine Standalone Update" /f >nul 2>&1
echo [OK] Задачи удалены
echo.

echo [9/11] Удаление переменной среды OneDrive...
reg delete "HKCU\Environment" /v "OneDrive" /f >nul 2>&1
echo [OK] Переменная удалена
echo.

echo [10/11] Применение gpupdate /force...
gpupdate /force >nul 2>&1
echo [OK] Политики применены
echo.

echo [11/11] Проверка результата...
if exist "%LOCALAPPDATA%\Microsoft\OneDrive" (
    echo [ПРЕДУПРЕЖДЕНИЕ] OneDrive всё ещё присутствует
) else (
    echo [OK] OneDrive полностью удалён
)
echo.

echo [XOS] Удалить OneDrive
echo.

taskkill /f /im OneDrive.exe > nul 2>&1
taskkill /f /im OneDrive.App.exe > nul 2>&1
taskkill /f /im FileCoAuth.exe > nul 2>&1

for %%k in (
  "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDrive"
  "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\OneDrive"
  "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDrive"
) do (
  for /f "tokens=2,*" %%a in ('reg query %%k /v UninstallString 2^>nul ^| findstr /i "UninstallString"') do %%b > nul 2>&1
)

for %%a in (
  "%windir%\System32\OneDriveSetup.exe"
  "%windir%\SysWOW64\OneDriveSetup.exe"
) do if exist "%%a" "%%a" /uninstall > nul 2>&1

for %%r in (
  "%ProgramFiles%\Microsoft OneDrive"
  "%ProgramFiles(x86)%\Microsoft OneDrive"
  "%LOCALAPPDATA%\Microsoft\OneDrive"
) do (
  if exist "%%~r" (
    for /f "delims=" %%f in ('dir /b /s "%%~r\OneDriveSetup.exe" 2^>nul') do "%%f" /uninstall > nul 2>&1
  )
)

rmdir /q /s "%ProgramData%\Microsoft OneDrive" > nul 2>&1
rmdir /q /s "%ProgramFiles%\Microsoft OneDrive" > nul 2>&1
rmdir /q /s "%ProgramFiles(x86)%\Microsoft OneDrive" > nul 2>&1
rmdir /q /s "%LOCALAPPDATA%\Microsoft\OneDrive" > nul 2>&1

for /f "usebackq delims=" %%a in (`dir /b /a:d "%SystemDrive%\Users"`) do (
  rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\OneDrive" > nul 2>&1
  rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive" > nul 2>&1
  del /q /f "%SystemDrive%\Users\%%a\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive*.lnk" > nul 2>&1
)
del /q /f "%ProgramData%\Microsoft\Windows\Start Menu\Programs\OneDrive*.lnk" > nul 2>&1

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDrive" /f > nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\OneDrive" /f > nul 2>&1

for /f "usebackq delims=" %%a in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%a" /f > nul 2>&1

for /f "tokens=2 delims=\" %%a in ('schtasks /query /fo list /v 2^>nul ^| findstr /c:"\OneDrive Reporting Task" /c:"\OneDrive Standalone Update Task"') do schtasks /delete /tn "%%a" /f > nul 2>&1

for /f "usebackq delims=" %%s in (`reg query HKU 2^>nul ^| findstr /r "S-1-5-21-[0-9]*-[0-9]*-[0-9]*$"`) do (
  for /f "usebackq delims=" %%a in (`reg query "%%s\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BannerStore" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
  for /f "usebackq delims=" %%a in (`reg query "%%s\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
  for /f "usebackq delims=" %%a in (`reg query "%%s\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
  for /f "usebackq delims=" %%a in (`reg query "%%s\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
  reg add "%%s\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > nul 2>&1
  reg add "%%s\SOFTWARE\Classes\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > nul 2>&1
  reg delete "%%s\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > nul 2>&1
  reg delete "%%s\Environment" /v "OneDrive" /f > nul 2>&1
  reg delete "%%s\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f > nul 2>&1
  reg delete "%%s\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f > nul 2>&1
  reg delete "%%s\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v "IconStreams" /f > nul 2>&1
  reg delete "%%s\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v "PastIconsStream" /f > nul 2>&1
)

reg load "HKU\XOSDefault" "%SystemDrive%\Users\Default\NTUSER.DAT" > nul 2>&1
if not errorlevel 1 (
  reg delete "HKU\XOSDefault\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f > nul 2>&1
  reg delete "HKU\XOSDefault\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f > nul 2>&1
  reg add "HKU\XOSDefault\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > nul 2>&1
  reg unload "HKU\XOSDefault" > nul 2>&1
)

powershell -NoProfile -Command "Get-AppxPackage -Name '*OneDrive*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"

echo.
echo [OK] Готово: Удалить OneDrive
echo [OK] Рекомендуется перезагрузка.
echo.

echo ================================================================================
echo                    ГОТОВО! ONEDRIVE УДАЛЁН ПОЛНОСТЬЮ
echo ================================================================================
echo.
pause