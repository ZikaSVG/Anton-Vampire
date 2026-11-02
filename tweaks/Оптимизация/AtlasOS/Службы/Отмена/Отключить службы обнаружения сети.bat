@echo off
call "%windir%\AtlasModules\Scripts\setSvc.cmd" fdPHost 3
call "%windir%\AtlasModules\Scripts\setSvc.cmd" FDResPub 3
call "%windir%\AtlasModules\Scripts\setSvc.cmd" lmhosts 3
call "%windir%\AtlasModules\Scripts\setSvc.cmd" netman 3
call "%windir%\AtlasModules\Scripts\setSvc.cmd" SSDPSRV 3
