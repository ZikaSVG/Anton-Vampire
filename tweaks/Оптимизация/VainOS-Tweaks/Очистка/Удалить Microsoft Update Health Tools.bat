@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Update Health Tools

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить Microsoft Update Health Tools
echo.

setlocal EnableDelayedExpansion

:: --- Найти GUID и ProdID
for /f "usebackq tokens=7 delims=\" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /d /f "Update Health Tools" /s ^| findstr /i /c:"CurrentVersion\Uninstall\"`) do set "GUID=%%e"
for /f "usebackq tokens=4 delims=\" %%e in (`reg query "HKCR\Installer\Products" /d /f "Update Health Tools" /s ^| findstr /i /c:"Installer\Products\"`) do set "ProdID=%%e"

:: --- Удалить Uninstall-ключ
if not "!GUID!"=="" reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\!GUID!" /f >nul 2>&1

:: --- Удалить Installer-записи
if "!ProdID!"=="" goto :eof
for /f "usebackq delims=" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes" /d /f "!ProdID!" /s ^| findstr /i /c:"Installer\UpgradeCodes\"`) do reg delete "%%e" /f >nul 2>&1
reg delete "HKCR\Installer\Products\!ProdID!" /f >nul 2>&1
reg delete "HKCR\Installer\Features\!ProdID!" /f >nul 2>&1
for /f "usebackq delims=" %%e in (`reg query "HKCR\Installer\UpgradeCodes" /d /f "!ProdID!" /s ^| findstr /i /c:"Installer\UpgradeCodes\"`) do reg delete "%%e" /f >nul 2>&1
for /f "usebackq delims=" %%e in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components" /d /f "!ProdID!" /s ^| findstr /i /c:"S-1-5-18\Components\"`) do reg delete "%%e" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\!ProdID!" /f >nul 2>&1

:: --- Удалить папки
for /f "usebackq delims=" %%e in (`powershell -NoProfile -Command "(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders').Property" ^| findstr /i /c:"Update Health Tools"`) do (
  set "var=%%e"
  if "!var:~-1!"=="\" set "var=%%e\"
  reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\Folders" /v "!var!" /f >nul 2>&1
)

echo.
echo [OK] Готово: Удалить Microsoft Update Health Tools
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
