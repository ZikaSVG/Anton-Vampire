@echo off
setlocal
net session >nul 2>&1 || (echo [!] Run as Administrator. & pause & exit /b 1)

reg delete "HKCR\DesktopBackground\Shell\BloodEnergy" /f >nul 2>&1
reg delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\BloodEnergy" /f >nul 2>&1
echo Blood Energy menu removed.
