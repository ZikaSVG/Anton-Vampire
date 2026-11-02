@echo off
call "%windir%\AtlasModules\Scripts\setSvc.cmd" fdPHost 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" FDResPub 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" lmhosts 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" SSDPSRV 4
