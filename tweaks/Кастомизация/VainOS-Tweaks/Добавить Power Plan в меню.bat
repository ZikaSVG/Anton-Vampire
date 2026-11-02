@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Добавить Power Plan в меню

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Добавить Power Plan в меню
echo.

:: --- Верхний уровень
reg add "HKCR\DesktopBackground\Shell\Idle" /v "Icon" /t REG_SZ /d "powercpl.dll" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle" /v "MUIVerb" /t REG_SZ /d "Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle" /v "Position" /t REG_SZ /d "Bottom" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle" /v "SubCommands" /t REG_SZ /d "" /f >nul 2>&1

:: --- Подпункты
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle001" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle001" /v "MUIVerb" /t REG_SZ /d "Power Saver" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle001\command" /v "" /t REG_SZ /d "powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle002" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle002" /v "MUIVerb" /t REG_SZ /d "Balanced" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle002\command" /v "" /t REG_SZ /d "powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle003" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle003" /v "MUIVerb" /t REG_SZ /d "High Performance" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle003\command" /v "" /t REG_SZ /d "powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle004" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle004" /v "MUIVerb" /t REG_SZ /d "XOS Power Plan" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle004\command" /v "" /t REG_SZ /d "powercfg /setactive 77777777-7777-7777-7777-777777777777" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle005" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle005" /v "MUIVerb" /t REG_SZ /d "Disable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle005\command" /v "" /t REG_SZ /d "C:\Windows\Modules\IdleOFF.bat" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle006" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle006" /v "MUIVerb" /t REG_SZ /d "Enable Idle" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle006\command" /v "" /t REG_SZ /d "C:\Windows\Modules\IdleON.bat" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle007" /v "HasLUAShield" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle007" /v "MUIVerb" /t REG_SZ /d "Power Options" /f >nul 2>&1
reg add "HKCR\DesktopBackground\Shell\Idle\Shell\Idle007\command" /v "" /t REG_SZ /d "control.exe powercfg.cpl" /f >nul 2>&1

echo.
echo [OK] Готово: Добавить Power Plan в меню
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
