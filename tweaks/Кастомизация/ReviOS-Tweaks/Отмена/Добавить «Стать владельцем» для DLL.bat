@echo off
reg delete "HKCR\dllfile\shell\runas" /f >nul 2>&1
