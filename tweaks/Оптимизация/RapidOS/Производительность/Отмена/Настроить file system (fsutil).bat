@echo off
title RapidOS Tweak
:: ---
fsutil behavior set disablecompression 0 >nul 2>&1
fsutil behavior set encryptpagingfile 1 >nul 2>&1
fsutil behavior set disablelastaccess 2 >nul 2>&1
fsutil behavior set quotanotify 3600 >nul 2>&1
fsutil behavior set disable8dot3 0 >nul 2>&1
:: ---
echo Done.
pause
exit /b
