@echo off
title RapidOS Tweak
:: ---
reg delete "HKCR\AllFileSystemObjects\ShellEx\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
