@echo off
Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1
