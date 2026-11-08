@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /d "" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{BD472F60-27FA-11cf-B8B4-444553540000}" /d "" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{EE07CEF5-3441-4CFB-870A-4002C724783A}" /d "" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{D12E3394-DE4B-4777-93E9-DF0AC88F8584}" /d "" /f >nul
