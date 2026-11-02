@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить OneDrive

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить OneDrive
echo.

:: --- Проверка: не удаляем, если есть файлы в OneDrive
for /f "usebackq delims=" %%a in (`dir /b /a:d "%SystemDrive%\Users"`) do (
  if exist "%SystemDrive%\Users\%%a\OneDrive" (
    dir "%SystemDrive%\Users\%%a\OneDrive" /b | findstr "." > nul 2>&1 && (
      echo [!] OneDrive содержит файлы — пропускаем удаление.
      pause & exit /b 1
    )
  )
)

:: --- Убить процессы
taskkill /f /im OneDrive.exe > nul 2>&1

:: --- Удалить OneDriveSetup
for %%a in (
  "%windir%\System32\OneDriveSetup.exe"
  "%windir%\SysWOW64\OneDriveSetup.exe"
) do (
  if exist "%%a" "%%a" /uninstall > nul 2>&1
)

:: --- Удалить папки
rmdir /q /s "%ProgramData%\Microsoft OneDrive" > nul 2>&1
rmdir /q /s "%LOCALAPPDATA%\Microsoft\OneDrive" > nul 2>&1

:: --- Пройтись по всем юзерам
for /f "usebackq delims=" %%a in (`dir /b /a:d "%SystemDrive%\Users"`) do (
  rmdir /q /s "%SystemDrive%\Users\%%a\AppData\Local\Microsoft\OneDrive" > nul 2>&1
  rmdir /q /s "%SystemDrive%\Users\%%a\OneDrive" > nul 2>&1
  del /q /f "%SystemDrive%\Users\%%a\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" > nul 2>&1
)

:: --- SyncRootManager
for /f "usebackq delims=" %%a in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SyncRootManager" 2^>nul ^| findstr /i /c:"OneDrive"`) do reg delete "%%a" /f > nul 2>&1

:: --- Задачи OneDrive
for /f "tokens=2 delims=\" %%a in ('schtasks /query /fo list /v 2^>nul ^| findstr /c:"\OneDrive Reporting Task" /c:"\OneDrive Standalone Update Task"') do (
  schtasks /delete /tn "%%a" /f > nul 2>&1
)

:: --- USERREG для всех SID
for /f "delims=" %%U in ('reg query HKU 2^>nul ^| findstr /r "S-1-5-21"') do (
  set "USID=%%U"
  set "USID=!USID:HKEY_USERS\=!"
  call :USERREG !USID!
)
goto :done

:USERREG
for /f "usebackq delims=" %%a in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BannerStore" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
for /f "usebackq delims=" %%a in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\Handlers" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
for /f "usebackq delims=" %%a in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
for /f "usebackq delims=" %%a in (`reg query "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /i /c:"OneDrive" 2^>nul`) do reg delete "%%a" /f > nul 2>&1
reg add "HKU\%~1\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKU\%~1\SOFTWARE\Classes\WOW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f > nul 2>&1
reg delete "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > nul 2>&1
reg delete "HKU\%~1\Environment" /v "OneDrive" /f > nul 2>&1
reg delete "HKU\%~1\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f > nul 2>&1
goto :eof

:done

echo.
echo [OK] Готово: Удалить OneDrive
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
