@echo off
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /ve /t REG_SZ /d "All Tasks" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "InfoTip" /t REG_SZ /d "View list of all Control Panel tasks" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /v "System.ControlPanel.Category" /t REG_SZ /d "5" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\DefaultIcon" /ve /t REG_SZ /d "%WinDir%\System32\imageres.dll,-27" /f >nul 2>&1
reg add "HKCR\CLSID\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}\Shell\Open\Command" /ve /t REG_SZ /d "explorer.exe shell:::{ED7BA470-8E54-465E-825C-99712043E01C}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{D15ED2E1-C75B-443c-BD7C-FC03B2F08C17}" /ve /t REG_SZ /d "All Tasks" /f >nul 2>&1
