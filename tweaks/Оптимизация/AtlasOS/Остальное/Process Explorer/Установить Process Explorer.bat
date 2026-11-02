@echo off
call "%windir%\AtlasModules\Scripts\wingetCheck.cmd" >nul
winget install -e --id Microsoft.Sysinternals.ProcessExplorer --uninstall-previous -l "%windir%\AtlasModules\Apps\ProcessExplorer" -h --accept-source-agreements --accept-package-agreements --force --disable-interactivity >nul
PowerShell -NoP -C "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut("""$([Environment]::GetFolderPath('CommonStartMenu'))\Programs\Process Explorer.lnk"""); $Shortcut.TargetPath = """$([Environment]::GetFolderPath('Windows'))\AtlasModules\Apps\ProcessExplorer\procexp.exe"""; $Shortcut.Save()" >nul
reg add "HKCU\SOFTWARE\Sysinternals\Process Explorer" /v "OneInstance" /t REG_DWORD /d "1" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskmgr.exe" /v "Debugger" /t REG_SZ /d "%windir%\AtlasModules\Apps\ProcessExplorer\procexp.exe" /f >nul
