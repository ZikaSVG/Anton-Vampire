@echo off
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle" /v "Icon" /d "powercpl.dll" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle" /v "SubCommands" /d "" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle" /v "Position" /d "Bottom" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle" /v "MUIVerb" /d "CPU Idle" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle\Shell\Disable Idle" /v "MUIVerb" /d "Disable Idle" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle\Shell\Disable Idle" /v "Icon" /d "powercpl.dll" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle\Shell\Disable Idle\Command" /d "cmd /c \"\"%windir%\AtlasDesktop\3. General Configuration\CPU Idle\Disable Idle.cmd\"\" /silent" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle\Shell\Disable Idle\Command" /v "Icon" /d "powercpl.dll" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle\Shell\Enable Idle" /v "MUIVerb" /d "Enable Idle" /f >nul
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\CpuIdle\Shell\Enable Idle\Command" /d "cmd /c \"\"%windir%\AtlasDesktop\3. General Configuration\CPU Idle\Enable Idle (default).cmd\"\" /silent" /f >nul
