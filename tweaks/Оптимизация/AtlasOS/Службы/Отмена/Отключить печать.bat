@echo off
reg delete "HKCR\SystemFileAssociations\image\shell\print" /v "ProgrammaticAccessOnly" /f >nul 2>&1
call "%windir%\AtlasModules\Scripts\setSvc.cmd" Spooler 2
call "%windir%\AtlasModules\Scripts\setSvc.cmd" PrintWorkFlowUserSvc 3
for %%a in ("Printing-Foundation-Features" "Printing-Foundation-InternetPrinting-Client" "Printing-XPSServices-Features" "Printing-PrintToPDFServices-Features") do dism /Online /Enable-Feature /FeatureName:"%%a" /NoRestart >nul
