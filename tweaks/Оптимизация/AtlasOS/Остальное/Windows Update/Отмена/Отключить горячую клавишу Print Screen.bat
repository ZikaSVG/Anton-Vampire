@echo off
reg delete "HKCU\Control Panel\Keyboard" /v "PrintScreenKeyForSnippingEnabled" /f >nul 2>&1
