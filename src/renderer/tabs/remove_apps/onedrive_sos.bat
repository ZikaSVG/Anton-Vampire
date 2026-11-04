@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить OneDrive

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Удалить OneDrive
echo.

:: --- USERREG для всех живых SID пользователей
for /f "usebackq tokens=2 delims=\" %%e in (`reg query "HKEY_USERS" ^| findstr /r /x /c:"HKEY_USERS\S-.*" /c:"HKEY_USERS\AME_UserHive_[^_]*"`) do (
  reg query "HKU\%%e" 2^>nul | findstr /c:"Volatile Environment" /c:"AME_UserHive_" > nul 2>&1
  if not errorlevel 1 (
    call :USERREG "%%e"
  )
)

:: --- Убить процессы OneDrive
taskkill /f /im "OneDriveStandaloneUpdater.exe" >nul 2>&1
taskkill /f /im "Microsoft.SharePoint.exe" >nul 2>&1
taskkill /f /im "OneDriveSetup.exe" >nul 2>&1
taskkill /f /im "OneDrive.exe" >nul 2>&1
taskkill /f /im "FileCoAuth.exe" >nul 2>&1

:: --- Пройтись по всем юзерам: удалить папки + ярлыки
for /f "usebackq delims=" %%a in (`dir /b /a:d "%SystemDrive%\Users"`) do (
  rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\OneDrive" >nul 2>&1
  del /q /f "%SystemDrive%\Users\%%a\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1
)

:: --- Перенос файлов из OneDrive в стандартные папки
for /f "usebackq delims=" %%a in (`dir /b /a:d "%SystemDrive%\Users"`) do (
  if not exist "%SystemDrive%\Users\%%a\Desktop" mkdir "%SystemDrive%\Users\%%a\Desktop" >nul 2>&1
  if not exist "%SystemDrive%\Users\%%a\Documents" mkdir "%SystemDrive%\Users\%%a\Documents" >nul 2>&1
  if not exist "%SystemDrive%\Users\%%a\Pictures" mkdir "%SystemDrive%\Users\%%a\Pictures" >nul 2>&1
  if not exist "%SystemDrive%\Users\%%a\Videos" mkdir "%SystemDrive%\Users\%%a\Videos" >nul 2>&1
  if not exist "%SystemDrive%\Users\%%a\Music" mkdir "%SystemDrive%\Users\%%a\Music" >nul 2>&1

  if exist "%SystemDrive%\Users\%%a\OneDrive\Desktop" (for /f "usebackq delims=" %%b in (`dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Desktop"`) do (echo No|move /-Y "%SystemDrive%\Users\%%a\OneDrive\Desktop\%%b" "%SystemDrive%\Users\%%a\Desktop"))
  if exist "%SystemDrive%\Users\%%a\OneDrive\Documents" (for /f "usebackq delims=" %%b in (`dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Documents"`) do (echo No|move /-Y "%SystemDrive%\Users\%%a\OneDrive\Documents\%%b" "%SystemDrive%\Users\%%a\Documents"))
  if exist "%SystemDrive%\Users\%%a\OneDrive\Pictures" (for /f "usebackq delims=" %%b in (`dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Pictures"`) do (echo No|move /-Y "%SystemDrive%\Users\%%a\OneDrive\Pictures\%%b" "%SystemDrive%\Users\%%a\Pictures"))
  if exist "%SystemDrive%\Users\%%a\OneDrive\Videos" (for /f "usebackq delims=" %%b in (`dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Videos"`) do (echo No|move /-Y "%SystemDrive%\Users\%%a\OneDrive\Videos\%%b" "%SystemDrive%\Users\%%a\Videos"))
  if exist "%SystemDrive%\Users\%%a\OneDrive\Music" (for /f "usebackq delims=" %%b in (`dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Music"`) do (echo No|move /-Y "%SystemDrive%\Users\%%a\OneDrive\Music\%%b" "%SystemDrive%\Users\%%a\Music"))

  if exist "%SystemDrive%\Users\%%a\OneDrive\Desktop" dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Desktop" | findstr /R /c:"." > NUL 2>&1 || rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive\Desktop"
  if exist "%SystemDrive%\Users\%%a\OneDrive\Documents" dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Documents" | findstr /R /c:"." > NUL 2>&1 || rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive\Documents"
  if exist "%SystemDrive%\Users\%%a\OneDrive\Pictures" dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Pictures" | findstr /R /c:"." > NUL 2>&1 || rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive\Pictures"
  if exist "%SystemDrive%\Users\%%a\OneDrive\Videos" dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Videos" | findstr /R /c:"." > NUL 2>&1 || rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive\Videos"
  if exist "%SystemDrive%\Users\%%a\OneDrive\Music" dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive\Music" | findstr /R /c:"." > NUL 2>&1 || rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive\Music"

  del /q /f "%SystemDrive%\Users\%%a\OneDrive\Personal Vault.lnk" >nul 2>&1

  :: --- Остатки OneDrive в Desktop\OneDriveFiles
  for /f "usebackq delims=" %%b in (`dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive" 2^>nul ^| findstr /V /X /c:"Desktop" /c:"Documents" /c:"Pictures" /c:"Videos" /c:"Music"`) do (
    if not exist "%SystemDrive%\Users\%%a\Desktop\OneDriveFiles" mkdir "%SystemDrive%\Users\%%a\Desktop\OneDriveFiles" >nul 2>&1
    echo No|move /-Y "%SystemDrive%\Users\%%a\OneDrive\%%b" "%SystemDrive%\Users\%%a\Desktop\OneDriveFiles" >nul 2>&1
  )
  dir /b /a:-s "%SystemDrive%\Users\%%a\OneDrive" 2^>nul | findstr /R /c:"." > NUL 2>&1 || rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive" >nul 2>&1
)

:: --- SyncRootManager
for /f "usebackq delims=" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%e" /f >nul 2>&1

:: --- Задачи OneDrive
for /f "usebackq tokens=1* delims=\" %%A in (`schtasks /query /fo list 2^>nul ^| findstr /c:"\OneDrive Reporting Task" /c:"\OneDrive Standalone Update Task"`) do (
  schtasks /delete /tn "%%B" /f >nul 2>&1
)

exit /b 0

:USERREG
for /f "usebackq delims=" %%e in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BannerStore" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%e" /f >nul 2>&1
for /f "usebackq delims=" %%e in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%e" /f >nul 2>&1
for /f "usebackq delims=" %%e in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%e" /f >nul 2>&1
for /f "usebackq delims=" %%e in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%e" /f >nul 2>&1
goto :eof

echo.
echo [OK] Готово: Удалить OneDrive
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
