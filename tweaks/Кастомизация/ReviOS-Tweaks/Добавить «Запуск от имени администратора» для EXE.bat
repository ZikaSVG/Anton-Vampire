@echo off
reg add "HKCR\exefile\shell\runas" /f
reg add "HKCR\exefile\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f
reg add "HKCR\exefile\shell\runas\command" /ve /d "\"%1\" %*" /f
reg add "HKCR\exefile\shell\runas\command" /v "IsolatedCommand" /d "\"%1\" %*" /f
