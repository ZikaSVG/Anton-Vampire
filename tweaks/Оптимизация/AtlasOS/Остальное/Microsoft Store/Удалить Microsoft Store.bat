@echo off
powershell -NoP -NonI -Command "Get-AppxPackage -AllUsers Microsoft.WindowsStore | Remove-AppxPackage" >nul
