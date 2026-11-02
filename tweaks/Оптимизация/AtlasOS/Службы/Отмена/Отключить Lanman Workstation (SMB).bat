@echo off
call "%windir%\AtlasModules\Scripts\setSvc.cmd" KSecPkg 0
call "%windir%\AtlasModules\Scripts\setSvc.cmd" LanmanServer 2
call "%windir%\AtlasModules\Scripts\setSvc.cmd" LanmanWorkstation 2
call "%windir%\AtlasModules\Scripts\setSvc.cmd" mrxsmb 3
call "%windir%\AtlasModules\Scripts\setSvc.cmd" mrxsmb20 3
call "%windir%\AtlasModules\Scripts\setSvc.cmd" rdbss 1
call "%windir%\AtlasModules\Scripts\setSvc.cmd" srv2 3
DISM /Online /Enable-Feature /FeatureName:"SmbDirect" /NoRestart >nul
