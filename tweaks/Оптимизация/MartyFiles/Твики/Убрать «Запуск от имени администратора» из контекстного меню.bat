@echo off
for %%b in (batfile cmdfile exefile cplfile mscfile) do reg add "HKLM\Software\Classes\%%b\shell\runas" /v "ProgrammaticAccessOnly" /t REG_SZ /d "" /f >nul
reg add "HKLM\Software\Classes\exefile\shell\runas2" /v "ProgrammaticAccessOnly" /t REG_SZ /d "" /f >nul
