@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Заблокировать телеметрию через hosts

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Заблокировать телеметрию через hosts
echo.

set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"
set "BACKUP=%SystemRoot%\System32\drivers\etc\hosts.vainos.bak"

if exist "%BACKUP%" (
  copy /y "%BACKUP%" "%HOSTS%" >nul 2>&1
  del /f /q "%BACKUP%" >nul 2>&1
) else (
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$h='%HOSTS%'; $c=Get-Content -LiteralPath $h -Raw -EA 0;" ^
    "$c=[regex]::Replace($c,'(?ms)^# === VainOS telemetry block BEGIN ===.*?^# === VainOS telemetry block END ===\r?\n?','');" ^
    "Set-Content -LiteralPath $h -Value $c -Encoding ASCII -EA 0" >nul 2>&1
)
ipconfig /flushdns >nul 2>&1

echo.
echo [OK] Отменено: Восстановить hosts
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
