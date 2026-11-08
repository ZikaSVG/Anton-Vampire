@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Disable Enable Idle

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Добавить Disable Enable Idle
echo.

reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v MUIVerb /t REG_SZ /d "Disable Idle" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /v CommandFlags /t REG_DWORD /d 32 /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && powercfg -setactive scheme_current" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v MUIVerb /t REG_SZ /d "Enable Idle" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /v Icon /t REG_SZ /d "powercpl.dll" /f
reg add "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu\command" /ve /t REG_SZ /d "cmd.exe /c powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0 && powercfg -setactive scheme_current" /f

echo.
echo [OK] Готово: Добавить Disable Enable Idle
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
