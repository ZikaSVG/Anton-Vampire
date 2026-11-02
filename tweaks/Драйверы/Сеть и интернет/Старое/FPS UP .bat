@Echo Off
Title Reg Converter v1.1 & Color 1A
cd %systemroot%\system32
call :IsAdmin
:: ---------------------------------------------------  !!! Incorrect Data Found !!!  -------------------------------------------------------------
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video --> PowerMizerEnable"= hex:0
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video --> PowermizerLevel"= hex:1
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Video --> PowermizerLevelAC"= :hex:1
:: ------------------------------------------------------------------------------------------------------------------------------------------------
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TcpAckFrequency" /t REG_DWORD /d "19" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "NumTcbTablePartitions" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TCPNoDelay" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TcpWindowSize" /t REG_DWORD /d "365000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "SackOpts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TcpMaxDataRetransmissions" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "Tcp1323Opts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TCPTimedWaitDelay" /t REG_DWORD /d "30" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "IRPStackSize" /t REG_DWORD /d "18" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "DefaultTTL" /t REG_DWORD /d "64" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "KeepAliveTime" /t REG_DWORD /d "60000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "KeepAliveInterval" /t REG_DWORD /d "1000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TCPInitialRtt" /t REG_DWORD /d "300" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TcpRecSegmentSize" /t REG_DWORD /d "2446674" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "EnablePMTUBHDetect" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxHashTableSize" /t REG_DWORD /d "65536" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "DisableTaskOffload" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "WorldMaxTcpWindowsSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TCPAllowedPorts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "NTEContextList" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "DisableLargeMTU" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "IGMPVersion" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "IGMPLevel" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxConnectionsPerServer" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxFreeTcbs" /t REG_DWORD /d "65536" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "ArpTRSingleRoute" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "SynAttackProtect" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "ForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "NumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxNumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxUserPort" /t REG_DWORD /d "65534" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "TcpMaxSendFree" /t REG_DWORD /d "65535" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "DontAddDefaultGatewayDefault" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "MaxMpxCt" /t REG_DWORD /d "125" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "CacheHashTableBucketSize" /t REG_DWORD /d "4096" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "EnableDynamicBacklog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "EnableDHCP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "Version" /t REG_SZ /d "1.7.10" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "Path" /t REG_SZ /d "C:\Users\ibluecombo\AppData\Roaming\.minecraft\\" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TcpAckFrequency" /t REG_DWORD /d "19" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "NumTcbTablePartitions" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TCPNoDelay" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TcpWindowSize" /t REG_DWORD /d "365000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "SackOpts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TcpMaxDataRetransmissions" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "Tcp1323Opts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TCPTimedWaitDelay" /t REG_DWORD /d "30" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "IRPStackSize" /t REG_DWORD /d "18" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "DefaultTTL" /t REG_DWORD /d "64" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "KeepAliveTime" /t REG_DWORD /d "60000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "KeepAliveInterval" /t REG_DWORD /d "1000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TCPInitialRtt" /t REG_DWORD /d "300" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TcpRecSegmentSize" /t REG_DWORD /d "2446674" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "EnablePMTUBHDetect" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxHashTableSize" /t REG_DWORD /d "65536" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "DisableTaskOffload" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "WorldMaxTcpWindowsSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TCPAllowedPorts" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "NTEContextList" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "DisableLargeMTU" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "IGMPVersion" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "IGMPLevel" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxConnectionsPerServer" /t REG_DWORD /d "16" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxFreeTcbs" /t REG_DWORD /d "65536" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "ArpTRSingleRoute" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "SynAttackProtect" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "ForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "NumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxNumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxUserPort" /t REG_DWORD /d "65534" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "TcpMaxSendFree" /t REG_DWORD /d "65535" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "DontAddDefaultGatewayDefault" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "MaxMpxCt" /t REG_DWORD /d "125" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "CacheHashTableBucketSize" /t REG_DWORD /d "4096" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "EnableDynamicBacklog" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "EnableDHCP" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\ibluecombo\Minecraft" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TcpAckFrequency" /t REG_DWORD /d "19" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "NumTcbTablePartitions" /t REG_DWORD /d "8" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TCPNoDelay" /t REG_DWORD /d "16" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TcpWindowSize" /t REG_DWORD /d "365000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "SackOpts" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TcpMaxDataRetransmissions" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "Tcp1323Opts" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TCPTimedWaitDelay" /t REG_DWORD /d "30" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "IRPStackSize" /t REG_DWORD /d "18" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "DefaultTTL" /t REG_DWORD /d "64" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "KeepAliveTime" /t REG_DWORD /d "60000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "KeepAliveInterval" /t REG_DWORD /d "1000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TCPInitialRtt" /t REG_DWORD /d "300" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TcpRecSegmentSize" /t REG_DWORD /d "2446674" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "EnablePMTUBHDetect" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxHashTableSize" /t REG_DWORD /d "65536" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "DisableTaskOffload" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "WorldMaxTcpWindowsSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TCPAllowedPorts" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "NTEContextList" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "DisableLargeMTU" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "IGMPVersion" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "IGMPLevel" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d "16" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxConnectionsPerServer" /t REG_DWORD /d "16" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxFreeTcbs" /t REG_DWORD /d "65536" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "ArpTRSingleRoute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "SynAttackProtect" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "ForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "NumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxNumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxUserPort" /t REG_DWORD /d "65534" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "TcpMaxSendFree" /t REG_DWORD /d "65535" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "DontAddDefaultGatewayDefault" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "MaxMpxCt" /t REG_DWORD /d "125" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "CacheHashTableBucketSize" /t REG_DWORD /d "4096" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "EnableDynamicBacklog" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "EnableDHCP" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TcpAckFrequency" /t REG_DWORD /d "19" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "NumTcbTablePartitions" /t REG_DWORD /d "8" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TCPNoDelay" /t REG_DWORD /d "16" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TcpWindowSize" /t REG_DWORD /d "365000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "SackOpts" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TcpMaxDataRetransmissions" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "Tcp1323Opts" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TCPTimedWaitDelay" /t REG_DWORD /d "30" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "IRPStackSize" /t REG_DWORD /d "18" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "DefaultTTL" /t REG_DWORD /d "64" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "KeepAliveTime" /t REG_DWORD /d "60000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "KeepAliveInterval" /t REG_DWORD /d "1000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TCPInitialRtt" /t REG_DWORD /d "300" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TcpRecSegmentSize" /t REG_DWORD /d "2446674" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "EnablePMTUBHDetect" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxHashTableSize" /t REG_DWORD /d "65536" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "DisableTaskOffload" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "WorldMaxTcpWindowsSize" /t REG_DWORD /d "16777215" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TCPAllowedPorts" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "NTEContextList" /t REG_DWORD /d "3" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "DisableLargeMTU" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "IGMPVersion" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "IGMPLevel" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxConnectionsPer1_0Server" /t REG_DWORD /d "16" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxConnectionsPerServer" /t REG_DWORD /d "16" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxFreeTcbs" /t REG_DWORD /d "65536" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "ArpTRSingleRoute" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "SynAttackProtect" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "ForwardBufferMemory" /t REG_DWORD /d "150000" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "NumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxNumForwardPackets" /t REG_DWORD /d "585" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxUserPort" /t REG_DWORD /d "65534" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "TcpMaxSendFree" /t REG_DWORD /d "65535" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "DontAddDefaultGatewayDefault" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "MaxMpxCt" /t REG_DWORD /d "125" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "CacheHashTableBucketSize" /t REG_DWORD /d "4096" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "EnableDynamicBacklog" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "EnableDHCP" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft" /v "EnableWsd" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft Launcher" /v "upgrade_id" /t REG_DWORD /d "919817256" /f
Reg.exe add "HKCU\SOFTWARE\Mojang\Minecraft Launcher" /v "launcher_pos" /t REG_BINARY /d "bd01000073000000680200009202000000000000" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Games" /v "FpsAll" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\SOFTWARE\Microsoft\Games" /v "GameFluidity" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d "1298" /f
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "48" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "SfTracingState" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Video" /v "PerfLevelSrc" /t REG_BINARY /d "3322" /f
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Pshed" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "8" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "4" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "8" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
Reg.exe delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\Copy To" /f
Reg.exe delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\Move To" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "2" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1050" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "8" /f
Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "3400" /f
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "9" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d "69" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveSearch" /t REG_DWORD /d "255" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoResolveTrack" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInternetOpenWith" /t REG_DWORD /d "52" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "BcastNameQueryCount" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "BcastQueryTimeout" /t REG_DWORD /d "750" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "CacheTimeout" /t REG_DWORD /d "600000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "EnableLMHOSTS" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "NameServerPort" /t REG_DWORD /d "137" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "NameSrvQueryCount" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "NameSrvQueryTimeout" /t REG_DWORD /d "1500" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "NbProvider" /t REG_SZ /d "_tcp" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "SessionKeepAlive" /t REG_DWORD /d "3600000" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "Size/Small/Medium/Large" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "TransportBindName" /t REG_SZ /d "\Device\\" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "UseNewSmb" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "EnableProxy" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "EnableProxyRegCheck" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /v "EnableDns" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "True" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d "2" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "SFIO Priority" /t REG_SZ /d "Normal" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Background Only" /t REG_SZ /d "True" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Priority" /t REG_DWORD /d "5" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "SFIO Priority" /t REG_SZ /d "Normal" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Background Only" /t REG_SZ /d "True" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Priority" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "SFIO Priority" /t REG_SZ /d "Normal" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Priority" /t REG_DWORD /d "3" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "BackgroundPriority" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "SFIO Priority" /t REG_SZ /d "Normal" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Priority" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "SFIO Priority" /t REG_SZ /d "Normal" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Background Only" /t REG_SZ /d "True" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Priority" /t REG_DWORD /d "5" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters\OCMsetup" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters\Security" /v "SecureDSCommunication" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d "1" /f
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d "384" /f
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 & Exit
)
Cls
goto:eof