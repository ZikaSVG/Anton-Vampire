@echo off
reg add "HKCR\SystemFileAssociations\image\shell\print" /v "ProgrammaticAccessOnly" /t REG_SZ /d "" /f >nul
call "%windir%\AtlasModules\Scripts\setSvc.cmd" Spooler 4
call "%windir%\AtlasModules\Scripts\setSvc.cmd" PrintWorkFlowUserSvc 4
for %%a in ("Printing-Foundation-Features" "Printing-Foundation-InternetPrinting-Client" "Printing-XPSServices-Features" "Printing-PrintToPDFServices-Features") do dism /Online /Disable-Feature /FeatureName:"%%a" /NoRestart >nul
