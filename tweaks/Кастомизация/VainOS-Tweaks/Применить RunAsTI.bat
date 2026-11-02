@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Применить RunAsTI

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Применить RunAsTI
echo.

:: --- Создаём ключ HKCR\RunAsTI и его значения 10..40
reg add "HKCR\RunAsTI" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "10" /t REG_SZ /d "function RunAsTI ($cmd,$arg) { $id='RunAsTI'; $key=\\"Registry::HKU\\$(((whoami /user)-split' ')[-1])\\Volatile Environment\\"; $code=@'" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "11" /t REG_SZ /d " $I=[int32]; $M=$I.module.gettype(\\"System.Runtime.Interop`Services.Mar`shal\\"); $P=$I.module.gettype(\\"System.Int`Ptr\\"); $S=[string]" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "12" /t REG_SZ /d " $D=@(); $T=@(); $DM=[AppDomain]::CurrentDomain.\\"DefineDynami`cAssembly\\"(1,1).\\"DefineDynami`cModule\\"(1); $Z=[uintptr]::size " /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "13" /t REG_SZ /d " 0..5|% {$D += $DM.\\"Defin`eType\\"(\\"AveYo_$_\\",1179913,[ValueType])}; $D += [uintptr]; 4..6|% {$D += $D[$_].\\"MakeByR`efType\\"()}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "14" /t REG_SZ /d " $F='kernel','advapi','advapi', ($S,$S,$I,$I,$I,$I,$I,$S,$D[7],$D[8]), ([uintptr],$S,$I,$I,$D[9]),([uintptr],$S,$I,$I,[byte[]],$I)" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "15" /t REG_SZ /d " 0..2|% {$9=$D[0].\\"DefinePInvok`eMethod\\"(('CreateProcess','RegOpenKeyEx','RegSetValueEx')[$_],$F[$_]+'32',8214,1,$S,$F[$_+3],1,4)}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "16" /t REG_SZ /d " $DF=($P,$I,$P),($I,$I,$I,$I,$P,$D[1]),($I,$S,$S,$S,$I,$I,$I,$I,$I,$I,$I,$I,[int16],[int16],$P,$P,$P,$P),($D[3],$P),($P,$P,$I,$I)" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "17" /t REG_SZ /d " 1..5|% {$k=$_; $n=1; $DF[$_-1]|% {$9=$D[$k].\\"Defin`eField\\"('f' + $n++, $_, 6)}}; 0..5|% {$T += $D[$_].\\"Creat`eType\\"()}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "18" /t REG_SZ /d " 0..5|% {nv \\"A$_\\" ([Activator]::CreateInstance($T[$_])) -fo}; function F ($1,$2) {$T[0].\\"G`etMethod\\"($1).invoke(0,$2)}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "19" /t REG_SZ /d " $TI=(whoami /groups)-like'*1-16-16384*'; $As=0; if(!$cmd) {$cmd='control';$arg='admintools'}; if ($cmd-eq'This PC'){$cmd='file:'}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "20" /t REG_SZ /d " if (!$TI) {'TrustedInstaller','lsass','winlogon'|% {if (!$As) {$9=sc.exe start $_; $As=@(get-process -name $_ -ea 0|% {$_})[0]}}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "21" /t REG_SZ /d " function M ($1,$2,$3) {$M.\\"G`etMethod\\"($1,[type[]]$2).invoke(0,$3)}; $H=@(); $Z,(4*$Z+16)|% {$H += M \\"AllocHG`lobal\\" $I $_}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "22" /t REG_SZ /d " M \\"WriteInt`Ptr\\" ($P,$P) ($H[0],$As.Handle); $A1.f1=131072; $A1.f2=$Z; $A1.f3=$H[0]; $A2.f1=1; $A2.f2=1; $A2.f3=1; $A2.f4=1" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "23" /t REG_SZ /d " $A2.f6=$A1; $A3.f1=10*$Z+32; $A4.f1=$A3; $A4.f2=$H[1]; M \\"StructureTo`Ptr\\" ($D[2],$P,[boolean]) (($A2 -as $D[2]),$A4.f2,$false)" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "24" /t REG_SZ /d " $Run=@($null, \\"powershell -win 1 -nop -c iex `$env:R; # $id\\", 0, 0, 0, 0x0E080600, 0, $null, ($A4 -as $T[4]), ($A5 -as $T[5]))" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "25" /t REG_SZ /d " F 'CreateProcess' $Run; return}; $env:R=''; rp $key $id -force; $priv=[diagnostics.process].\\"GetM`ember\\"('SetPrivilege',42)[0]" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "26" /t REG_SZ /d " 'SeSecurityPrivilege','SeTakeOwnershipPrivilege','SeBackupPrivilege','SeRestorePrivilege' |% {$priv.Invoke($null, @(\\"$_\\",2))}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "27" /t REG_SZ /d " $HKU=[uintptr][uint32]2147483651; $NT='S-1-5-18'; $reg=($HKU,$NT,8,2,($HKU -as $D[9])); F 'RegOpenKeyEx' $reg; $LNK=$reg[4]" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "28" /t REG_SZ /d " function L ($1,$2,$3) {sp 'Registry::HKCR\\AppID\\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}' 'RunAs' $3 -force -ea 0}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "29" /t REG_SZ /d "  $b=[Text.Encoding]::Unicode.GetBytes(\\"\\Registry\\User\\$1\\"); F 'RegSetValueEx' @($2,'SymbolicLinkValue',0,6,[byte[]]$b,$b.Length)}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "30" /t REG_SZ /d " function Q {[int](gwmi win32_process -filter 'name=\\"explorer.exe\\"'|?{$_.getownersid().sid-eq$NT}|select -last 1).ProcessId}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "31" /t REG_SZ /d " $env:wt='powershell'; dir \\"$env:ProgramFiles\\WindowsApps\\Microsoft.WindowsTerminal*\\wt.exe\\" -rec|% {$env:wt='\\"'+$_.FullName+'\\" \\"-d .\\"'}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "32" /t REG_SZ /d " $11bug=($((gwmi Win32_OperatingSystem).BuildNumber)-eq'22000')-AND(($cmd-eq'file:')-OR(test-path -lit $cmd -PathType Container))" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "33" /t REG_SZ /d " if ($11bug) {'System.Windows.Forms','Microsoft.VisualBasic' |% {$9=[Reflection.Assembly]::LoadWithPartialName(\\"'$_\\")}}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "34" /t REG_SZ /d " if ($11bug) {$path='^(l)'+$($cmd -replace '([\\+\\^\\%\\~\\(\\)\\[\\]])','{$1}')+'{ENTER}'; $cmd='control.exe'; $arg='admintools'}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "35" /t REG_SZ /d " L ($key-split'\\\\')[1] $LNK ''; $R=[diagnostics.process]::start($cmd,$arg); if ($R) {$R.PriorityClass='High'; $R.WaitForExit()}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "36" /t REG_SZ /d " if ($11bug) {$w=0; do {if($w-gt40){break}; sleep -mi 250;$w++} until (Q); [Microsoft.VisualBasic.Interaction]::AppActivate($(Q))}" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "37" /t REG_SZ /d " if ($11bug) {[Windows.Forms.SendKeys]::SendWait($path)}; do {sleep 7} while(Q); L '.Default' $LNK 'Interactive User'" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "38" /t REG_SZ /d "'@; $V='';'cmd','arg','id','key'|%{$V+=\\"`n`$$_='$($(gv $_ -val)-replace\\"'\\",\\"''\\")';\\"}; sp $key $id $($V,$code) -type 7 -force -ea 0" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "39" /t REG_SZ /d " start powershell -args \\"-win 1 -nop -c `n$V `$env:R=(gi `$key -ea 0).getvalue(`$id)-join''; iex `$env:R\\" -verb runas" /f >nul 2>&1
reg add "HKCR\RunAsTI" /v "40" /t REG_SZ /d "}; $A=([environment]::commandline-split'-[-]%+ ?',2)[1]-split'\\"([^\\"]+)\\"|([^ ]+)',2|%{$_.Trim(' \\"')}; RunAsTI $A[1] $A[2]" /f >nul 2>&1

:: --- Импортируем RunAsTI.reg (пункты меню)
reg import "%~dp0RunAsTI.reg" >nul 2>&1

echo.
echo [OK] Готово: Применить RunAsTI
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
