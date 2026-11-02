@echo off
dism /online /cleanup-image /restorehealth
sfc /scannow
