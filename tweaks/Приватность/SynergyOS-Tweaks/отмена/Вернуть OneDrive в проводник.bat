@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Убрать OneDrive из проводника

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Убрать OneDrive из проводника
echo.

reg add "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть OneDrive в проводник
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
