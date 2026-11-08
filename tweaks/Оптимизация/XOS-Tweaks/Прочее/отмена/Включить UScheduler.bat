@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить UScheduler DevHome Outlook

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить UScheduler DevHome Outlook
echo.

echo UScheduler восстановится при следующей проверке обновлений.

echo.
echo [OK] Отменено: Включить UScheduler
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
