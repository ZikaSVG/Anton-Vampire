@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить контекстное меню

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Очистить контекстное меню
echo.

:: --- Удаление контекстных ключей
reg delete "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg delete "HKCR\CompressedFolder\ShellEx\ContextMenuHandlers\{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.zip\ShellEx\ContextMenuHandlers\{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /f >nul 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\Background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f >nul 2>&1
reg delete "HKCR\.rtf\ShellNew" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.fbx\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.gif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jfif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpe\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpeg\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\.tiff\Shell\3D Edit" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\*\shell\pintohomefile" /f >nul 2>&1
reg delete "HKCR\Folder\shell\pintohome" /f >nul 2>&1
reg delete "HKCR\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg delete "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg delete "HKCR\Microsoft.Website\ShellEx\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg delete "HKCR\mscfile\shellex\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
reg delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
reg delete "HKCR\SystemFileAssociations\image\shell\print" /f >nul 2>&1
reg delete "HKCR\batfile\shell\print" /f >nul 2>&1
reg delete "HKCR\fonfile\shell\print" /f >nul 2>&1
reg delete "HKCR\cmdfile\shell\print" /f >nul 2>&1
reg delete "HKCR\htmlfile\shell\print" /f >nul 2>&1
reg delete "HKCR\JSEFile\Shell\Print" /f >nul 2>&1
reg delete "HKCR\otffile\shell\print" /f >nul 2>&1
reg delete "HKCR\pfmfile\shell\print" /f >nul 2>&1
reg delete "HKCR\regfile\shell\print" /f >nul 2>&1
reg delete "HKCR\ttcfile\shell\print" /f >nul 2>&1
reg delete "HKCR\ttffile\shell\print" /f >nul 2>&1
reg delete "HKCR\VBEFile\Shell\Print" /f >nul 2>&1
reg delete "HKCR\VBSFile\Shell\Print" /f >nul 2>&1
reg delete "HKCR\WSFFile\Shell\Print" /f >nul 2>&1

:: --- Блокировка отдельных CLSID
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /t REG_SZ /d "" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{1d27f844-3a1f-4410-85ac-14651078412d}" /t REG_SZ /d "" /f >nul 2>&1

echo.
echo [OK] Готово: Очистить контекстное меню
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
