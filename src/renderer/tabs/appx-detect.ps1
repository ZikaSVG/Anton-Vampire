# appx-detect.ps1
# Определяет присутствие компонентов: OneDrive, Edge, WebView2, Defender.
# Возвращает JSON:
# {
#   "onedrive":  { "present": true, "reasons": ["process", "folder:...", "reg:..."] },
#   "edge":      { ... },
#   "webview2":  { ... },
#   "defender":  { ... }
# }

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'SilentlyContinue'

function New-Report { param([bool]$present, [string[]]$reasons)
    [PSCustomObject]@{ present = $present; reasons = @($reasons) }
}

# ============================================================
# ONEDRIVE
# ============================================================
$odReasons = New-Object System.Collections.ArrayList

if (Get-Process -Name OneDrive -ErrorAction SilentlyContinue)             { [void]$odReasons.Add('process:OneDrive.exe') }
if (Get-Process -Name FileCoAuth -ErrorAction SilentlyContinue)            { [void]$odReasons.Add('process:FileCoAuth.exe') }

foreach ($p in @(
    "$env:SystemRoot\System32\OneDriveSetup.exe",
    "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
)) { if (Test-Path $p) { [void]$odReasons.Add("file:$p") } }

foreach ($d in @(
    "$env:LOCALAPPDATA\Microsoft\OneDrive",
    "$env:PROGRAMDATA\Microsoft OneDrive",
    "$env:USERPROFILE\OneDrive",
    "C:\OneDriveTemp"
)) { if (Test-Path $d) { [void]$odReasons.Add("folder:$d") } }

if (Test-Path 'HKLM:\SOFTWARE\Microsoft\OneDrive')        { [void]$odReasons.Add('reg:HKLM\SOFTWARE\Microsoft\OneDrive') }
if (Test-Path 'HKCU:\Software\Microsoft\OneDrive')        { [void]$odReasons.Add('reg:HKCU\Software\Microsoft\OneDrive') }

$oneDriveReport = New-Report ($odReasons.Count -gt 0) $odReasons

# ============================================================
# EDGE
# ============================================================
$edgeReasons = New-Object System.Collections.ArrayList

foreach ($n in @('msedge','MicrosoftEdgeUpdate','msedgewebview2','identity_helper','MicrosoftEdgeCP')) {
    if (Get-Process -Name $n -ErrorAction SilentlyContinue) { [void]$edgeReasons.Add("process:$n.exe") }
}

foreach ($p in @(
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe"
)) { if (Test-Path $p) { [void]$edgeReasons.Add("file:$p") } }

foreach ($d in @(
    "$env:ProgramFiles\Microsoft\Edge",
    "${env:ProgramFiles(x86)}\Microsoft\Edge",
    "$env:LOCALAPPDATA\Microsoft\Edge"
)) { if (Test-Path $d) { [void]$edgeReasons.Add("folder:$d") } }

$edgeAppx = Get-AppxPackage -Name '*MicrosoftEdge*' -ErrorAction SilentlyContinue
if ($edgeAppx) { [void]$edgeReasons.Add('appx:MicrosoftEdge') }

if (Test-Path 'HKLM:\SOFTWARE\Microsoft\Edge')              { [void]$edgeReasons.Add('reg:HKLM\SOFTWARE\Microsoft\Edge') }
if (Test-Path 'HKLM:\SOFTWARE\Microsoft\EdgeUpdate')        { [void]$edgeReasons.Add('reg:HKLM\SOFTWARE\Microsoft\EdgeUpdate') }
if (Test-Path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Edge')  { [void]$edgeReasons.Add('reg:WOW6432Node\Edge') }

$edgeReport = New-Report ($edgeReasons.Count -gt 0) $edgeReasons

# ============================================================
# WEBVIEW2
# ============================================================
$wvReasons = New-Object System.Collections.ArrayList

if (Get-Process -Name msedgewebview2 -ErrorAction SilentlyContinue) { [void]$wvReasons.Add('process:msedgewebview2.exe') }

foreach ($p in @(
    "$env:ProgramFiles\Microsoft\EdgeWebView\Application\msedgewebview2.exe",
    "${env:ProgramFiles(x86)}\Microsoft\EdgeWebView\Application\msedgewebview2.exe"
)) { if (Test-Path $p) { [void]$wvReasons.Add("file:$p") } }

foreach ($d in @(
    "$env:ProgramFiles\Microsoft\EdgeWebView",
    "${env:ProgramFiles(x86)}\Microsoft\EdgeWebView"
)) { if (Test-Path $d) { [void]$wvReasons.Add("folder:$d") } }

# WebView2 через EdgeUpdate\Clients\{F1E7E9CD-...}
$wvClient = 'HKLM:\SOFTWARE\Microsoft\EdgeUpdate\Clients\{F1E7E9CD-BA48-4B1F-9E1A-3F5F7E5CF8F3}'
if (Test-Path $wvClient) { [void]$wvReasons.Add('reg:EdgeUpdate\Clients\{F1E7E9CD...}') }
$wvClient2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F1E7E9CD-BA48-4B1F-9E1A-3F5F7E5CF8F3}'
if (Test-Path $wvClient2) { [void]$wvReasons.Add('reg:WOW6432Node\EdgeUpdate\Clients') }

$webviewReport = New-Report ($wvReasons.Count -gt 0) $wvReasons

# ============================================================
# DEFENDER
# ============================================================
$defReasons = New-Object System.Collections.ArrayList

foreach ($n in @('MsMpEng','NisSrv','SecurityHealthService','SecurityHealthSystray','SecurityHealthHost','smartscreen','MpCmdRun')) {
    if (Get-Process -Name $n -ErrorAction SilentlyContinue) { [void]$defReasons.Add("process:$n.exe") }
}

foreach ($p in @(
    "$env:SystemRoot\System32\MsMpEng.exe",
    "$env:SystemRoot\System32\SecurityHealthService.exe",
    "$env:SystemRoot\System32\SecurityHealthSystray.exe",
    "$env:SystemRoot\System32\smartscreen.exe",
    "$env:SystemRoot\System32\drivers\WdFilter.sys",
    "$env:SystemRoot\System32\drivers\WdBoot.sys",
    "$env:SystemRoot\System32\drivers\WdNisDrv.sys"
)) { if (Test-Path $p) { [void]$defReasons.Add("file:$p") } }

foreach ($d in @(
    "$env:ProgramData\Microsoft\Windows Defender",
    "$env:ProgramFiles\Windows Defender",
    "${env:ProgramFiles(x86)}\Windows Defender"
)) { if (Test-Path $d) { [void]$defReasons.Add("folder:$d") } }

# Службы через sc query (быстрее, чем Get-Service)
foreach ($svc in @('WinDefend','WdNisSvc','Sense','wscsvc','WdFilter','WdBoot','SecurityHealthService')) {
    $null = sc.exe query $svc 2>$null
    if ($LASTEXITCODE -eq 0) { [void]$defReasons.Add("service:$svc") }
}

# AppX Defender
$defAppx = Get-AppxPackage -Name '*SecHealthUI*' -ErrorAction SilentlyContinue
if ($defAppx) { [void]$defReasons.Add('appx:SecHealthUI') }

$defReport = New-Report ($defReasons.Count -gt 0) $defReasons

# ============================================================
# OUTPUT
# ============================================================
$result = [PSCustomObject]@{
    onedrive  = $oneDriveReport
    edge      = $edgeReport
    webview2  = $webviewReport
    defender  = $defReport
}

$json = $result | ConvertTo-Json -Compress -Depth 5
if ([string]::IsNullOrEmpty($json)) { $json = '{}' }
[Console]::Out.Write($json)