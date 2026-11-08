@echo off
reg add "HKCR\*\shell\runas" /f
reg add "HKCR\*\shell\runas" /ve /d "Take Ownership" /f
reg add "HKCR\*\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
reg add "HKCR\*\shell\runas" /v "Position" /t REG_SZ /d "middle" /f
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant *S-1-3-4:F /c /l" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%1\" && icacls \"%1\" /grant *S-1-3-4:F /c /l" /f
