@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Убрать SecurityHealth из автозапуска

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Убрать SecurityHealth из автозапуска
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t REG_EXPAND_SZ /d "%windir%\system32\SecurityHealthSystray.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть SecurityHealth в автозапуск
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
