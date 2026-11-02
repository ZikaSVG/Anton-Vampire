@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Очистить контекстное меню

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Очистить контекстное меню
echo.

:: --- Восстановить контекстные ключи (пустые)
reg add "HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f >nul 2>&1
reg add "HKCR\CompressedFolder\ShellEx\ContextMenuHandlers\{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.zip\ShellEx\ContextMenuHandlers\{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}" /f >nul 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg add "HKCR\Directory\Background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg add "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg add "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg add "HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg add "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg add "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f >nul 2>&1
reg add "HKCR\.rtf\ShellNew" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.3mf\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.bmp\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.fbx\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.gif\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.jfif\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.jpe\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.jpeg\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.jpg\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.png\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.tif\Shell\3D Edit" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\.tiff\Shell\3D Edit" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\*\shell\pintohomefile" /f >nul 2>&1
reg add "HKCR\Folder\shell\pintohome" /f >nul 2>&1
reg add "HKCR\Folder\shellex\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg add "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg add "HKCR\Microsoft.Website\ShellEx\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg add "HKCR\mscfile\shellex\ContextMenuHandlers\PintoStartScreen" /f >nul 2>&1
reg add "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
reg add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing" /f >nul 2>&1
reg add "HKCR\SystemFileAssociations\image\shell\print" /f >nul 2>&1
reg add "HKCR\batfile\shell\print" /f >nul 2>&1
reg add "HKCR\fonfile\shell\print" /f >nul 2>&1
reg add "HKCR\cmdfile\shell\print" /f >nul 2>&1
reg add "HKCR\htmlfile\shell\print" /f >nul 2>&1
reg add "HKCR\JSEFile\Shell\Print" /f >nul 2>&1
reg add "HKCR\otffile\shell\print" /f >nul 2>&1
reg add "HKCR\pfmfile\shell\print" /f >nul 2>&1
reg add "HKCR\regfile\shell\print" /f >nul 2>&1
reg add "HKCR\ttcfile\shell\print" /f >nul 2>&1
reg add "HKCR\ttffile\shell\print" /f >nul 2>&1
reg add "HKCR\VBEFile\Shell\Print" /f >nul 2>&1
reg add "HKCR\VBSFile\Shell\Print" /f >nul 2>&1
reg add "HKCR\WSFFile\Shell\Print" /f >nul 2>&1

:: --- Снять блокировку CLSID
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{1d27f844-3a1f-4410-85ac-14651078412d}" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть контекстное меню
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
