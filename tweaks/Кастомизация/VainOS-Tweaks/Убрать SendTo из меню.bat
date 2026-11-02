@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Убрать SendTo из меню

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Убрать SendTo из меню
echo.

reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" /f >nul 2>&1
reg delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo" /f >nul 2>&1

echo.
echo [OK] Готово: Убрать SendTo из меню
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
