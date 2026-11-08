@echo off
reg delete "HKCR\Directory\shell\runas" /f >nul 2>&1
