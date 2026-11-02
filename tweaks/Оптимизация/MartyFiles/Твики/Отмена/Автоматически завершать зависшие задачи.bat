@echo off
reg add "HKCR\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 0 /f >nul
