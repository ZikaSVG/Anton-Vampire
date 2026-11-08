@echo off
reg add "HKCR\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 1 /f >nul
