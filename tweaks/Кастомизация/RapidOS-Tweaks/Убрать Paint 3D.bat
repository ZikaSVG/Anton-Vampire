@echo off
title RapidOS Tweak
:: ---
reg delete "HKCR\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.fbx\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.gif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jfif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpe\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpeg\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.tiff\Shell\3D Edit" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
