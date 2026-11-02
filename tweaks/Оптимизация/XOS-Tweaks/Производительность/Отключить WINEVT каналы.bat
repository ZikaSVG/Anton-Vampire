@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить WINEVT каналы

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить WINEVT каналы
echo.

powershell -NoProfile -Command "try { $r=[Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels',$true); if ($r) { foreach ($n in $r.GetSubKeyNames()) { $s=$null; try { $s=$r.OpenSubKey($n,$true); if ($s -and ($s.GetValue('Enabled') -eq 1)) { $s.SetValue('Enabled',0,'DWord') } } catch {} finally { if ($s) { $s.Close() } } }; $r.Close() } } catch {}"

echo.
echo [OK] Готово: Отключить WINEVT каналы
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
