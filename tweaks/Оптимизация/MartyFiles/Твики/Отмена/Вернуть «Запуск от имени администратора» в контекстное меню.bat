@echo off
for %%b in (batfile cmdfile exefile cplfile mscfile) do reg delete "HKLM\Software\Classes\%%b\shell\runas" /v "ProgrammaticAccessOnly" /f >nul 2>&1
reg delete "HKLM\Software\Classes\exefile\shell\runas2" /v "ProgrammaticAccessOnly" /f >nul 2>&1
