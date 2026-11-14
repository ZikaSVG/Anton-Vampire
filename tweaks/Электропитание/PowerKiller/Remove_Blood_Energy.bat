@echo off
setlocal
net session >nul 2>&1 || ( echo [!] Run as Administrator. & pause & exit /b 1 )
reg delete "HKCR\DesktopBackground\Shell\BloodEnergy" /f >nul 2>&1
echo [OK] Blood Energy removed.