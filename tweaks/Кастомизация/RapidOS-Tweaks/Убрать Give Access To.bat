@echo off
title RapidOS Tweak
:: ---
reg delete "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
