@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Заблокировать телеметрию через hosts

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Заблокировать телеметрию через hosts
echo.

set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"
set "BACKUP=%SystemRoot%\System32\drivers\etc\hosts.vainos.bak"

if not exist "%BACKUP%" copy /y "%HOSTS%" "%BACKUP%" >nul 2>&1

(
echo 
echo # === VainOS telemetry block BEGIN ===
echo 0.0.0.0 browser.pipe.aria.microsoft.com
echo 0.0.0.0 dmd.metaservices.microsoft.com
echo 0.0.0.0 ris.api.iris.microsoft.com
echo 0.0.0.0 teams.events.data.microsoft.com
echo 0.0.0.0 telecommand.telemetry.microsoft.com
echo 0.0.0.0 telemetry.microsoft.com
echo 0.0.0.0 vortex-win.data.microsoft.com
echo 0.0.0.0 watson.events.data.microsoft.com
echo 0.0.0.0 activity.windows.com
echo 0.0.0.0 browser.events.data.microsoft.com
echo 0.0.0.0 outlookads.live.com
echo 0.0.0.0 vortex.data.microsoft.com
echo 0.0.0.0 dc.services.visualstudio.com
echo 0.0.0.0 visualstudio-devdiv-c2s.msedge.net
echo 0.0.0.0 az667904.vo.msecnd.net
echo 0.0.0.0 scus-breeziest-in.cloudapp.net
echo 0.0.0.0 nw-umwatson.events.data.microsoft.com
echo 0.0.0.0 mobile.events.data.microsoft.com
echo 0.0.0.0 watson.microsoft.com
echo 0.0.0.0 watson.telemetry.microsoft.com
echo 0.0.0.0 umwatsonc.events.data.microsoft.com
echo 0.0.0.0 ceuswatcab01.blob.core.windows.net
echo 0.0.0.0 ceuswatcab02.blob.core.windows.net
echo 0.0.0.0 eaus2watcab01.blob.core.windows.net
echo 0.0.0.0 eaus2watcab02.blob.core.windows.net
echo 0.0.0.0 weus2watcab01.blob.core.windows.net
echo 0.0.0.0 weus2watcab02.blob.core.windows.net
echo 0.0.0.0 p3a.brave.com
echo 0.0.0.0 p2a.brave.com
echo 0.0.0.0 p3a-json.brave.com
echo 0.0.0.0 p2a-json.brave.com
echo 0.0.0.0 variations.brave.com
echo 0.0.0.0 cr.brave.com
echo 0.0.0.0 config.edge.skype.com
echo 0.0.0.0 edge.activity.windows.com
echo 0.0.0.0 edge.microsoft.com
echo 0.0.0.0 edge-enterprise.activity.windows.com
echo 0.0.0.0 web.vortex.data.microsoft.com
echo 0.0.0.0 telemetry.mozilla.org
echo 0.0.0.0 crash-stats.mozilla.org
echo 0.0.0.0 incoming.telemetry.mozilla.org
echo 0.0.0.0 firefox.settings.services.mozilla.com
echo 0.0.0.0 content-signature-2.cdn.mozilla.net
echo 0.0.0.0 ssl.google-analytics.com
echo 0.0.0.0 www.google-analytics.com
echo 0.0.0.0 pagead2.googlesyndication.com
echo 0.0.0.0 adservice.google.com
echo 0.0.0.0 adservice.google.pl
echo 0.0.0.0 stats.g.doubleclick.net
echo 0.0.0.0 *.dl.delivery.mp.microsoft.com
echo # === VainOS telemetry block END ===
) >> "%HOSTS%"

ipconfig /flushdns >nul 2>&1

echo.
echo [OK] Готово: Заблокировать телеметрию через hosts
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
