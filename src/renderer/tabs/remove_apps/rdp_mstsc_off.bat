@echo off
reg add "HKLM\System\ControlSet001\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\System\ControlSet001\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\System\ControlSet001\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\System\ControlSet001\Control\Terminal Server\WinStations\RDP-Tcp" /v "UserAuthentication" /t REG_DWORD /d 0 /f >nul
