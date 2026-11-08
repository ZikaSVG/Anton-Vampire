@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить задачи Defender

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить задачи Defender
echo.

DISM.exe /Online /Enable-Feature /FeatureName:"Windows-Defender-Default-Definitions" /NoRestart >nul 2>&1
:: --- Задачи восстановятся только сбросом Windows. Удаляем через schtasks /create не имеет смысла.
echo [!] Задачи Defender удалены и не восстанавливаются автоматически.

echo.
echo [OK] Отменено: Включить задачи Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
