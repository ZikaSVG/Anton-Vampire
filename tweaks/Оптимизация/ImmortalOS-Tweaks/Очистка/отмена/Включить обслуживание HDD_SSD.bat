@echo off
chcp 65001 >nul 2>&1

net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

fsutil behavior set disablelastaccess 2 >nul 2>&1
fsutil behavior set disable8dot3 0 >nul 2>&1
fsutil behavior set disablecompression 0 >nul 2>&1
fsutil behavior set disableencryption 0 >nul 2>&1
fsutil repair set C: 9 >nul 2>&1

exit /b 0
