@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Оптимизация Input HKLM

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Оптимизация Input HKLM
echo.

reg add "HKLM\SOFTWARE\Microsoft\Input" /v IsInputAppPreloadEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v BluebirdDTWMultiplier /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v DisableExpressiveInputShellHotkey /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v DisablePersonalizationGTKM /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v DynamicAutocorrectionAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v INLINEPREDICTIONMINPREDICTIONLENGTH /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v INLINEPREDICTIONMINPREFIXLENGTH /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v ClosestInteractiveBoundsUpdateIntervalInMilliseconds /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v SearchHeightInDIPS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism" /v SearchWidthInDIPS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1" /v BluebirdDTWMultiplier /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1" /v DynamicAutocorrectionAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v AUTOCORRECTIONTRIGGERS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v AUTOCORRECTSUPPRESSPREVCHARS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v BluebirdDTWMultiplier /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v DisableExpressiveInputShellHotkey /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v DynamicAutocorrectionAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v PERIODSHORTCUTCHARS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v PERIODSHORTCUTDELAY /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409" /v PERIODSHORTCUTDELAYCANDSELECTION /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v AUTOCORRECTIONTRIGGERS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v AUTOCORRECTSUPPRESSPREVCHARS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v BluebirdDTWMultiplier /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v COMMONEMOJIPRETERMINATORS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v COMMONEMOJITERMINATORS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v DisableExpressiveInputShellHotkey /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v DynamicAutocorrectionAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v PERIODSHORTCUTCHARS /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v PERIODSHORTCUTDELAY /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings\proc_1\loc_0409\im_1" /v PERIODSHORTCUTDELAYCANDSELECTION /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Оптимизация Input HKLM
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
