@echo off
reg delete "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /f >nul 2>&1
reg delete "HKU\.DEFAULT\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /f >nul 2>&1
