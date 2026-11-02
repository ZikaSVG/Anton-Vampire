@echo off
chcp 65001 >nul 2>&1

net session >nul 2>&1
if %errorLevel% neq 0 exit /b 1

fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set disablecompression 1 >nul 2>&1
fsutil behavior set disableencryption 1 >nul 2>&1
fsutil repair set C: 0 >nul 2>&1

exit /b 0
