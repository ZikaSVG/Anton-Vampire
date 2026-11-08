@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить File Explorer CLSID

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить File Explorer CLSID
echo.

:: --- CLSID 2aa9162e — ItemsViewAdapter
reg add "HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /v "" /t REG_SZ /d "CLSID_ItemsViewAdapter" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /v "" /t REG_SZ /d "C:\Windows\System32\Windows.UI.FileExplorer.dll_" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f >nul 2>&1
:: --- CLSID 6480100b — Xaml Island View Adapter
reg add "HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /v "" /t REG_SZ /d "File Explorer Xaml Island View Adapter" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /v "" /t REG_SZ /d "C:\Windows\System32\Windows.UI.FileExplorer.dll_" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32" /v "ThreadingModel" /t REG_SZ /d "Apartment" /f >nul 2>&1
:: --- ValueBanner
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\ValueBanner.IdealStateFeatureControlProvider" /v "ActivationType" /t REG_DWORD /d "0" /f >nul 2>&1
:: --- All Tasks в Control Panel
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "" /t REG_SZ /d "All Tasks" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "InfoTip" /t REG_SZ /d "View list of all Control Panel tasks" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "System.ControlPanel.Category" /t REG_SZ /d "5" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\DefaultIcon" /v "" /t REG_SZ /d "%windir%\System32\imageres.dll,-27" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\Shell\Open\Command" /v "" /t REG_SZ /d "explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "" /t REG_SZ /d "All Tasks" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить File Explorer CLSID
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
