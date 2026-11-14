@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001
title Add Blood Energy

net session 2>&1 || (
  echo [!] Run as Administrator.
  pause & exit /b 1
)

echo Add Blood Energy
echo.

reg delete "HKCR\DesktopBackground\Shell\BloodEnergy" /f 2>&1

reg add "HKCR\DesktopBackground\Shell\BloodEnergy" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy" /v MUIVerb /t REG_SZ /d "Blood Energy" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy" /v Position /t REG_SZ /d "Middle" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy" /v SubCommands /t REG_SZ /d "" /f

:: ============================================================
:: БЛОК 1: Стандартные планы
:: ============================================================
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\01menu" /v MUIVerb /t REG_SZ /d "Сбалансированная" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\01menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\01menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 381b4222-f694-41f0-9685-ff5bb260df2e" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\02menu" /v MUIVerb /t REG_SZ /d "Высокая производительность" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\02menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\02menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\03menu" /v MUIVerb /t REG_SZ /d "Максимальная производительность" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\03menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\03menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive e9a42b02-d5df-448d-aa00-03f14749eb61" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\04menu" /v MUIVerb /t REG_SZ /d "Энергосбережение" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\04menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\04menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive a1841308-3541-4fab-bc81-f71556f20b4a" /f

:: ============================================================
:: БЛОК 2: Кастомные схемы (Разделитель сверху через CommandFlags=32)
:: ============================================================
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\21menu" /v MUIVerb /t REG_SZ /d "Balanced Performance" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\21menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\21menu" /v CommandFlags /t REG_DWORD /d 32 /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\21menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 90a358c8-3bbc-4fb3-8b4e-d7ab065d2614" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\22menu" /v MUIVerb /t REG_SZ /d "Maximum Performance" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\22menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\22menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive a1b2c3d4-e5f6-4789-a0ab-cdef12345678" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\23menu" /v MUIVerb /t REG_SZ /d "Power Saving" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\23menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\23menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive d8e76bb7-6943-4b7c-ab30-441296b72264" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\24menu" /v MUIVerb /t REG_SZ /d "NFS Racing" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\24menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\24menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive b2c3d4e5-f6a7-4890-b1c2-def345678901" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\25menu" /v MUIVerb /t REG_SZ /d "Shooter Low-Latency" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\25menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\25menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive c3d4e5f6-a7b8-4901-c2d3-ef4567890123" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\26menu" /v MUIVerb /t REG_SZ /d "Minimal Input Lag" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\26menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\26menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive d4e5f6a7-b8c9-4012-d3e4-f56789012345" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\27menu" /v MUIVerb /t REG_SZ /d "Energetic Death" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\27menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\27menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 7f8e9d0c-1b2a-4c3d-9e8f-a0b1c2d3e4f5" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\28menu" /v MUIVerb /t REG_SZ /d "Power Killer" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\28menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\28menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 8f0a1b2c-3d4e-5f60-a1b2-c3d4e5f60718" /f

:: ============================================================
:: БЛОК 3: Idle (Разделитель сверху через CommandFlags=32)
:: ============================================================
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\41menu" /v MUIVerb /t REG_SZ /d "Disable Idle" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\41menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\41menu" /v CommandFlags /t REG_DWORD /d 32 /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\41menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f

reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\42menu" /v MUIVerb /t REG_SZ /d "Enable Idle" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\42menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\42menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f

:: ============================================================
:: БЛОК 4: Power Options (Разделитель сверху через CommandFlags=32)
:: ============================================================
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\60menu" /v MUIVerb /t REG_SZ /d "Power Options" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\60menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\60menu" /v CommandFlags /t REG_DWORD /d 32 /f
reg add "HKCR\DesktopBackground\Shell\BloodEnergy\shell\60menu\command" /ve /t REG_SZ /d "control.exe powercfg.cpl" /f

echo.
echo Blood Energy added.
echo.
pause
endlocal