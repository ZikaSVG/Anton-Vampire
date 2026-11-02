@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить голосовую активацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить голосовую активацию
echo.

reg add "HKCU\Software\Microsoft\Speech_OneCore\Preferences" /v VoiceActivationOn /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить голосовую активацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
