@echo off
title RapidOS Tweak
:: ---
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
