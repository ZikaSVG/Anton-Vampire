@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Удалить SecHealthUI Cache

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Удалить SecHealthUI Cache
echo.

echo Кэш SecHealthUI пересоздастся автоматически.

echo.
echo [OK] Отменено: Восстановить SecHealthUI Cache
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
