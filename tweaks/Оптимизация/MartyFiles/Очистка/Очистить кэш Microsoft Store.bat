@echo off
del /q /f /s "%userprofile%\AppData\Local\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\*.*" >nul 2>&1
rd /q /s "%userprofile%\AppData\Local\Packages\Microsoft.WindowsStore_8wekyb3d8bbwe\LocalCache\" >nul 2>&1
