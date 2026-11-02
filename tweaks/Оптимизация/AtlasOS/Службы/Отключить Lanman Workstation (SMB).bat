@echo off
call "%windir%\AtlasModules\Scripts\setSvc.cmd" KSecPkg 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" LanmanServer 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" LanmanWorkstation 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" mrxsmb 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" mrxsmb20 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" rdbss 3
call "%windir%\AtlasModules\Scripts\setSvc.cmd" srv2 4
DISM /Online /Disable-Feature /FeatureName:"SmbDirect" /NoRestart >nul
