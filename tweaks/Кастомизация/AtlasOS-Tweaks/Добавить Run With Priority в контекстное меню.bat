@echo off
reg add "HKCR\exefile\Shell\Priority\shell\001flyout" /d "Realtime" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\001flyout\command" /d "powershell start -file 'cmd' -args '/c start \"\"\"Realtime App\"\"\" /Realtime \"\"%1\"\"\"' -verb runas" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\002flyout" /d "High" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\002flyout\command" /d "cmd /c start \"\" /High \"%1\"" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\003flyout" /d "Above normal" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\003flyout\command" /d "cmd /c start \"\" /AboveNormal \"%1\"" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\004flyout" /d "Normal" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\004flyout\command" /d "cmd /c start \"\" /Normal \"%1\"" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\005flyout" /d "Below normal" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\005flyout\command" /d "cmd /c start \"\" /BelowNormal \"%1\"" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\006flyout" /d "Low" /f >nul
reg add "HKCR\exefile\Shell\Priority\shell\006flyout\command" /d "cmd /c start \"\" /Low \"%1\"" /f >nul
