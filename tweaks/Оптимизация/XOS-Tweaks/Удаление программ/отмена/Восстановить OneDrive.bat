@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить OneDrive

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить OneDrive
echo.

echo Скачайте OneDrive: https://www.microsoft.com/microsoft-365/onedrive/download

echo.
echo [OK] Отменено: Восстановить OneDrive
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
