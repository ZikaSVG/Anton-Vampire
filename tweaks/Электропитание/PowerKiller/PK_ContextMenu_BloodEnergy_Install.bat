@echo off
setlocal
net session >nul 2>&1 || (echo [!] Run as Administrator. & pause & exit /b 1)
cd /d "%~dp0"

echo ============================================================
echo  Installing Blood Energy context menu
echo ============================================================

echo [1/3] Cleaning old installs (both paths)...
reg delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\BloodEnergy" /f >nul 2>&1
reg delete "HKCR\DesktopBackground\Shell\BloodEnergy" /f >nul 2>&1

echo [2/3] Creating all VampireOS power plans...
call "%~dp0PK_Create_All_Plans.bat"

echo [3/3] Importing Blood Energy menu...
if not exist "%~dp0PK_BloodEnergy.reg" (
    echo [!] PK_BloodEnergy.reg not found next to this installer.
    pause
    exit /b 1
)
reg import "%~dp0PK_BloodEnergy.reg"
if errorlevel 1 (
    echo [!] Registry import failed.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  Blood Energy menu installed at TOP level.
echo  Right-click desktop to use it.
echo ============================================================
echo.
echo Installed entries:
reg query "HKCR\DesktopBackground\Shell\BloodEnergy\shell" /s 2>nul | findstr "MUIVerb"
echo.
pause
