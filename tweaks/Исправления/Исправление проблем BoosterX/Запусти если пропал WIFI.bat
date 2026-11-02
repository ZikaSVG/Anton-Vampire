echo Настройка и запуск сетевых служб...
REM 1. Настройка службы Wcmsvc (Служба управления подключением к Windows).
REM Устанавливает службу Wcmsvc (Wireless Connectivity Management Service) для автоматического запуска при загрузке системы.
REM Это позволяет системе автоматически управлять беспроводными подключениями.
sc config Wcmsvc start= auto
echo Служба управления беспроводным подключением настроена на автоматический старт.
REM Запускает службу Wcmsvc, чтобы она начала обрабатывать запросы.
sc start Wcmsvc
echo Служба управления беспроводным подключением запущена.
REM 2. Настройка службы WlanSvc (Служба управления беспроводной локальной сетью).
REM Настраивает службу WlanSvc (WLAN AutoConfig) для автоматического запуска.
REM Эта служба отвечает за автоматическую настройку и управление беспроводными сетями.
sc config WlanSvc start= auto
echo Служба управления беспроводной локальной сетью настроена на автоматический старт.
REM Запускает службу WlanSvc, чтобы она могла начать работать и управлять беспроводными соединениями.
sc start WlanSvc
echo Служба управления беспроводной локальной сетью запущена.
REM 3. Настройка службы NativeWifiP (Служба поддержки нативного Wi-Fi).
REM Устанавливает службу NativeWifiP для запуска по требованию (demand), что позволяет ей запускаться только тогда,
REM когда это необходимо, вместо автоматического запуска при загрузке.
sc config NativeWifiP start= demand
echo Служба поддержки нативного Wi-Fi настроена на запуск по требованию.
REM Запускает службу NativeWifiP, чтобы она могла обслуживать запросы на подключение к Wi-Fi.
sc start NativeWifiP
REM Установка значений для запуска различных служб в системе. Значение 3 означает, что служба будет запущена автоматически при загрузке системы.
REM Устанавливает значение для службы WlanSvc (служба беспроводной сети) на 3 (автоматический запуск).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d "3" /f 
REM Устанавливает значение для службы icssvc (интернет-сервис связи) на 3 (автоматический запуск).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v "Start" /t REG_DWORD /d "3" /f 
REM Устанавливает значение для службы netprofm (служба профиля сети) на 3 (автоматический запуск).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\netprofm" /v "Start" /t REG_DWORD /d "3" /f 
REM Устанавливает значение для службы Netman (менеджер сетевых подключений) на 3 (автоматический запуск).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Netman" /v "Start" /t REG_DWORD /d "3" /f 
REM Устанавливает значение для службы WFDSConMgrSvc (менеджер соединений для WFDS) на 3 (автоматический запуск).
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\WFDSConMgrSvc" /v "Start" /t REG_DWORD /d "3" /f 
REM Запускает службу WlanSvc (служба беспроводной сети) немедленно, если она еще не запущена.
net start WlanSvc
echo Служба поддержки нативного Wi-Fi запущена.
echo Все сетевые службы успешно настроены и запущены.
REM Настройка параметров для просмотра изображений в Windows Photo Viewer
REM Устанавливает значение MuiVerb для команды "Open" (Открыть) в Photo Viewer с указанием его идентификатора интерфейса.
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f 
REM Устанавливает команду для выполнения при выборе "Открыть" с использованием rundll32 для запуска Photo Viewer в полноэкранном режиме.
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f 
REM Устанавливает CLSID для целевой области перетаскивания (Drag and Drop) для команды "Открыть".
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f 
REM Устанавливает команду для печати изображений через Photo Viewer.
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\print\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f 
REM Устанавливает CLSID для целевой области перетаскивания (Drag and Drop) для команды "Печать".
Reg.exe add "HKCR\Applications\photoviewer.dll\shell\print\DropTarget" /v "Clsid" /t REG_SZ /d "{60fd46de-f830-4894-a628-6fa81bc0190d}" /f 
REM Установка ассоциаций файлов для Windows Photo Viewer
REM Устанавливает ассоциации файлов для формата .bmp с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 
REM Устанавливает ассоциации файлов для формата .dib с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 
REM Устанавливает ассоциации файлов для формата .gif с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
REM Устанавливает ассоциации файлов для формата .jfif с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 
REM Устанавливает ассоциации файлов для формата .jpe с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 
REM Устанавливает ассоциации файлов для формата .jpeg с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 
REM Устанавливает ассоциации файлов для формата .jpg с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 
REM Устанавливает ассоциации файлов для формата .jxr с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 
REM Устанавливает ассоциации файлов для формата .png с Photo Viewer.
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f 