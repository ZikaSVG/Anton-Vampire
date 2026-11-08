@echo off
title RapidOS Tweak
:: ---
fsutil behavior set disablecompression 1 >nul 2>&1
fsutil behavior set encryptpagingfile 0 >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil behavior set quotanotify 5400 >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1
:: ---
echo Done.
pause
exit /b
