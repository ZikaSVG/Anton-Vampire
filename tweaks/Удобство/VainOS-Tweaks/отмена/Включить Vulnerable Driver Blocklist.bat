@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Vulnerable Driver Blocklist

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Vulnerable Driver Blocklist
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Vulnerable Driver Blocklist
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
