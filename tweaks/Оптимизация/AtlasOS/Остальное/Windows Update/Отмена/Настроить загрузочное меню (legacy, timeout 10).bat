@echo off
bcdedit /timeout 30 >nul 2>&1
bcdedit /set bootmenupolicy standard >nul 2>&1
