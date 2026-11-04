@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Microsoft Photos с заменой на Photo Viewer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Удалить Microsoft Photos с заменой на Photo Viewer
echo.

powershell -NoProfile -Command "Get-AppxPackage -Name '*Microsoft.Windows.Photos*' -AllUsers -EA 0 | Remove-AppxPackage -AllUsers -EA 0"

powershell -NoProfile -Command ^
  "$b='HKLM:\SOFTWARE\Classes\Applications\photoviewer.dll';" ^
  "New-Item \"$b\shell\open\command\" -Force|Out-Null; New-Item \"$b\shell\open\DropTarget\" -Force|Out-Null;" ^
  "New-Item \"$b\shell\print\command\" -Force|Out-Null; New-Item \"$b\shell\print\DropTarget\" -Force|Out-Null;" ^
  "Set-ItemProperty \"$b\shell\open\" -Name 'MuiVerb' -Value '@photoviewer.dll,-3043';" ^
  "$c='%SystemRoot%\System32\rundll32.exe \"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %1';" ^
  "[Microsoft.Win32.Registry]::SetValue('HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Applications\photoviewer.dll\shell\open\command','',$c,[Microsoft.Win32.RegistryValueKind]::ExpandString);" ^
  "Set-ItemProperty \"$b\shell\open\DropTarget\" -Name 'Clsid' -Value '{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}'"

powershell -NoProfile -Command ^
  "$p='HKLM:\SOFTWARE\Classes\PhotoViewer.FileAssoc.Tiff';" ^
  "New-Item \"$p\shell\open\command\" -Force|Out-Null; New-Item \"$p\shell\open\DropTarget\" -Force|Out-Null; New-Item \"$p\DefaultIcon\" -Force|Out-Null;" ^
  "Set-ItemProperty \"$p\" -Name 'FriendlyTypeName' -Value '@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3058' -Type ExpandString;" ^
  "$c='%SystemRoot%\System32\rundll32.exe \"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %1';" ^
  "[Microsoft.Win32.Registry]::SetValue('HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Tiff\shell\open\command','',$c,[Microsoft.Win32.RegistryValueKind]::ExpandString);" ^
  "[Microsoft.Win32.Registry]::SetValue('HKEY_LOCAL_MACHINE\SOFTWARE\Classes\PhotoViewer.FileAssoc.Tiff\DefaultIcon','','%SystemRoot%\System32\imageres.dll,-122',[Microsoft.Win32.RegistryValueKind]::ExpandString)"

powershell -NoProfile -Command ^
  "$e=@('.bmp','.dib','.jpg','.jpe','.jpeg','.jxr','.jfif','.wdp','.png','.gif','.tiff','.tif','.ico');" ^
  "foreach ($x in $e) { [Microsoft.Win32.Registry]::SetValue('HKEY_CURRENT_USER\Software\Classes\'+$x,'','PhotoViewer.FileAssoc.Tiff'); [Microsoft.Win32.Registry]::SetValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations',$x,'PhotoViewer.FileAssoc.Tiff') }"

echo.
echo [OK] Готово: Удалить Microsoft Photos с заменой на Photo Viewer
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
