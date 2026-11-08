@echo off
reg delete "HKCR\*\shell\runas" /f >nul 2>&1
