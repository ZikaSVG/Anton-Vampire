@echo off
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage | Where-Object { $_.NonRemovable -eq $false } | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }" >nul 2>&1
