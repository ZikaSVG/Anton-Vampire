@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Choose Power Plan

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Добавить Choose Power Plan
echo.

reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v MUIVerb /t REG_SZ /d "Choose Power Plan" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v Position /t REG_SZ /d "Middle" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan" /v SubCommands /t REG_SZ /d "" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\01menu" /v MUIVerb /t REG_SZ /d "Power Saver" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\01menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\01menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive a1841308-3541-4fab-bc81-f71556f20b4a" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\02menu" /v MUIVerb /t REG_SZ /d "Balanced" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\02menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\02menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 381b4222-f694-41f0-9685-ff5bb260df2e" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\03menu" /v MUIVerb /t REG_SZ /d "High Performance" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\03menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\03menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\04menu" /v MUIVerb /t REG_SZ /d "XOS Power Plan" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\04menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\04menu\command" /ve /t REG_SZ /d "powercfg.exe /setactive 31693169-3169-3169-3169-316931693169" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu" /v MUIVerb /t REG_SZ /d "Power Options" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu" /v CommandFlags /t REG_DWORD /d 32 /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\07menu\command" /ve /t REG_SZ /d "control.exe powercfg.cpl" /f

echo.
echo [OK] Готово: Добавить Choose Power Plan
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
