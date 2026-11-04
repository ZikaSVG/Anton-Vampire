@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Update Health Tools

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Удалить Microsoft Update Health Tools
echo.

setlocal EnableDelayedExpansion

:: --- Найти GUID и ProdID
for /f "usebackq tokens=7 delims=\" %%e in (`Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /d /f "Update Health Tools" /s ^| findstr /i /c:"CurrentVersion\Uninstall\"`) do set "GUID=%%e"
for /f "usebackq tokens=4 delims=\" %%e in (`Reg.exe query "HKCR\Installer\Products" /d /f "Update Health Tools" /s ^| findstr /i /c:"Installer\Products\"`) do set "ProdID=%%e"

:: --- Удалить Uninstall-ключ
if not "!GUID!"=="" Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\!GUID!" /f >nul 2>&1

:: --- Удалить Installer-записи
if "!ProdID!"=="" goto :eof
for /f "usebackq delims=" %%e in (`Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes" /d /f "!ProdID!" /s ^| findstr /i /c:"Installer\UpgradeCodes\"`) do Reg.exe delete "%%e" /f >nul 2>&1
Reg.exe delete "HKCR\Installer\Products\!ProdID!" /f >nul 2>&1
Reg.exe delete "HKCR\Installer\Features\!ProdID!" /f >nul 2>&1
for /f "usebackq delims=" %%e in (`Reg.exe query "HKCR\Installer\UpgradeCodes" /d /f "!ProdID!" /s ^| findstr /i /c:"Installer\UpgradeCodes\"`) do Reg.exe delete "%%e" /f >nul 2>&1
for /f "usebackq delims=" %%e in (`Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components" /d /f "!ProdID!" /s ^| findstr /i /c:"S-1-5-18\Components\"`) do Reg.exe delete "%%e" /f >nul 2>&1
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\!ProdID!" /f >nul 2>&1

:: --- Удалить записи в Installer\Folders
for /f "usebackq delims=" %%e in (`powershell -NoP -C "(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders').Property" ^| findstr /i /c:"Update Health Tools"`) do (
  set "var=%%e"
  if "!var:~-1!"=="\" set "var=%%e\"
  Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders" /v "!var!" /f >nul 2>&1
)

:: --- Удалить файлы Update Health Tools
rd /s /q "%ProgramW6432%\Microsoft Update Health Tools" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Microsoft Update Health Tools" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\Update Health Tools" >nul 2>&1

echo.
echo [OK] Готово: Удалить Microsoft Update Health Tools
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
