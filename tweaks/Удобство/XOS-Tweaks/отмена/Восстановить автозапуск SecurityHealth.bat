@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить автозапуск SecurityHealth

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить автозапуск SecurityHealth
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /t REG_EXPAND_SZ /d "%windir%\system32\SecurityHealthSystray.exe" /f

echo.
echo [OK] Отменено: Восстановить автозапуск SecurityHealth
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
