@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "StreamType" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapture" /t REG_DWORD /d "0" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCaptureDir" /t REG_SZ /d "c:\dm.capture\\" /f
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\MPEG2Demultiplexer" /v "WriteCapturePath" /t REG_SZ /d "" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof