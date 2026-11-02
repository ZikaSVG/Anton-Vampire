@echo off
reg add "HKCU\Control Panel\Keyboard" /v "PrintScreenKeyForSnippingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
