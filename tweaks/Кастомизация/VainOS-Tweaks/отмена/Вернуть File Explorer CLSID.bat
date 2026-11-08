@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить File Explorer CLSID

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить File Explorer CLSID
echo.

reg delete "HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}" /f >nul 2>&1
reg delete "HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\ValueBanner.IdealStateFeatureControlProvider" /v "ActivationType" /f >nul 2>&1
reg delete "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть File Explorer CLSID
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
