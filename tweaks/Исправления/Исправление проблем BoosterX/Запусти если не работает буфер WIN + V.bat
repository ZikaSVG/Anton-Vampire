@echo off
REM         .
REM   FSE (File Synchronization Engine)      "Start"  2.
REM  2       .
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FSE" /v "Start" /t REG_DWORD /d 2 /f
REM   EFS (Encrypting File System)  ,    "Start"  2.
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EFS" /v "Start" /t REG_DWORD /d 2 /f
REM   for,      "Start"   "cbdhsvc" (Cloud Backup Data Host Service).
for /f %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /k /f "cbdhsvc" ^| find /i "cbdhsvc"') do (
    reg add "%%i" /v "Start" /t reg_dword /d 2 /f
) > NUL 2>&1
REM - 'reg query'  ,   cbdhsvc,      for.
REM - 'find /i'  ,   ,  "cbdhsvc".
REM -    "Start"   2   ,   .
REM   EFS .
sc start EFS
REM    EFS  " ".
sc config EFS start=demand
REM     AllowClipboardHistory  .
REM        Windows.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v AllowClipboardHistory /t REG_DWORD /d 1 /f
REM  ,         gpedit.msc.
echo Win+R  gpedit. msc    Enter.
echo     =>   =>  =>  є =>       - 