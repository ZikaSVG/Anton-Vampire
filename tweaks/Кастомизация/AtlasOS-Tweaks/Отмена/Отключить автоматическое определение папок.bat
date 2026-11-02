@echo off
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders" /f >nul 2>&1
