@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Outlook ярлыки

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Outlook ярлыки
echo.

del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Outlook (new).lnk" >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Outlook.lnk" >nul 2>&1
powershell -NoProfile -Command ^
  "Get-ChildItem 'C:\Users\*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs' -Filter 'Outlook*' -EA 0 | Where-Object { $_.Extension -eq '.lnk' } | Remove-Item -Force -EA 0;" ^
  "Get-ChildItem 'C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs' -Filter 'Outlook*' -EA 0 | Where-Object { $_.Extension -eq '.lnk' } | Remove-Item -Force -EA 0"

echo.
echo [OK] Готово: Удалить Outlook ярлыки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
