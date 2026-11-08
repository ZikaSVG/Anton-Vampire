@echo off
reg delete "HKCR\exefile\shell\runas" /f >nul 2>&1
