@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить ассоциации 7-Zip и Photo Viewer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить ассоциации 7-Zip и Photo Viewer
echo.

:: --- Удалить UserChoice и SFTA-прогиды
for %%E in (bmp dib jpg jpe jpeg jxr jfif wdp png gif tiff tif 7z zip rar 001 cab iso xz txz lzma tar cpio bz2 bzip2 tbz2 tbz gz gzip tgz tpz z taz lzh lha rpm deb arj vhd wim swm esd fat ntfs dmg hfs xar squashfs apfs) do (
  reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.%%E\UserChoice" /f >nul 2>&1
)
for %%P in (PhotoViewer.FileAssoc.Tiff 7-Zip.7z 7-Zip.zip 7-Zip.rar 7-Zip.001 7-Zip.cab 7-Zip.iso 7-Zip.xz 7-Zip.txz 7-Zip.lzma 7-Zip.tar 7-Zip.cpio 7-Zip.bz2 7-Zip.bzip2 7-Zip.tbz2 7-Zip.tbz 7-Zip.gz 7-Zip.gzip 7-Zip.tgz 7-Zip.tpz 7-Zip.z 7-Zip.taz 7-Zip.lzh 7-Zip.lha 7-Zip.rpm 7-Zip.deb 7-Zip.arj 7-Zip.vhd 7-Zip.wim 7-Zip.swm 7-Zip.esd 7-Zip.fat 7-Zip.ntfs 7-Zip.dmg 7-Zip.hfs 7-Zip.xar 7-Zip.squashfs 7-Zip.apfs) do (
  reg delete "HKCU\Software\Classes\%%P" /f >nul 2>&1
)
reg delete "HKCU\Software\Classes\SFTA.PhotoViewer" /f >nul 2>&1

echo.
echo [OK] Отменено: Отменить ассоциации 7-Zip и Photo Viewer
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
