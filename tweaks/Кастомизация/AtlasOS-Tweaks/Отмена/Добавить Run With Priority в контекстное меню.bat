@echo off
reg delete "HKCR\exefile\shell\Priority" /f >nul 2>&1
