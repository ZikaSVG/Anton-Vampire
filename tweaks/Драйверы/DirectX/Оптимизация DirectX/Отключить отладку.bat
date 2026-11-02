@echo off
@echo.
@echo t.me/DE3NAKE
@echo.

::Отключить отладку
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "EnableDebugging" /t reg_DWORD /d "0" /f

::Отключить полную отладку
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FullDebug" /t reg_DWORD /d "0" /f

::Отключить отладочное наблюдение (Debug Monitoring)
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDM" /t reg_DWORD /d "1" /f

::Отключить отладку для многомониторного режима
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "EnableMultimonDebugging" /t reg_DWORD /d "0" /f

::Отключить загрузку файлов D3D8D.dll, D3D9D.dll для отладки
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "LoadDebugRuntime" /t reg_DWORD /d "0" /f

pause
exit