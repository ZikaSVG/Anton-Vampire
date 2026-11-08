@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить PendingFileRenameOperations leftovers

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить PendingFileRenameOperations leftovers
echo.

powershell -NoProfile -Command ^
  "$p=@(); $d=@(" ^
  "  ($env:ProgramFiles+'\WindowsApps\Microsoft.HEVCVideoExtension*')," ^
  "  ($env:ProgramFiles+'\WindowsApps\Microsoft.MicrosoftSolitaireCollection*')," ^
  "  ($env:ProgramFiles+'\WindowsApps\Microsoft.WindowsTerminal*')," ^
  "  ($env:ProgramFiles+'\WindowsApps\Microsoft.SkypeApp*')," ^
  "  ('C:\Users\*\AppData\Local\Packages\Microsoft.WidgetsPlatformRuntime_8wekyb3d8bbwe')," ^
  "  ($env:ProgramFiles+'\WindowsApps\MicrosoftCorporationII.WindowsSubsystemForLinux*')," ^
  "  ($env:ProgramFiles+'\WindowsApps\MSTeams_*')," ^
  "  ('C:\Users\*\AppData\Local\Packages\MSTeams_8wekyb3d8bbwe')," ^
  "  ([Environment]::GetFolderPath('ProgramFilesX86')+'\Microsoft\Edge\Application')," ^
  "  ($env:windir+'\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe')" ^
  ");" ^
  "foreach ($x in $d) { Get-Item $x -EA 0 | ForEach-Object { Get-ChildItem $_.FullName -Recurse -Force -EA 0 | Sort-Object { $_.FullName.Length } -Descending | ForEach-Object { $p += ('\??\'+$_.FullName); $p += '' }; $p += ('\??\'+$_.FullName); $p += '' } };" ^
  "if ($p.Count -gt 0) { $r='HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager'; $e=(Get-ItemProperty -Path $r -Name 'PendingFileRenameOperations' -EA 0).PendingFileRenameOperations; if ($e) { $p=$e+$p }; Set-ItemProperty -Path $r -Name 'PendingFileRenameOperations' -Value $p -Type MultiString -Force }"

echo.
echo [OK] Готово: Очистить PendingFileRenameOperations leftovers
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
