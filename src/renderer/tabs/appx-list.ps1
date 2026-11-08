[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'SilentlyContinue'

function enc([string]$s) {
    if ([string]::IsNullOrEmpty($s)) { return '' }
    return 'B64:' + [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($s))
}

$result = New-Object System.Collections.ArrayList
$startApps = Get-StartApps

# Normal Appx (exclude Edge, exclude NonRemovable)
$apps = Get-AppxPackage | Where-Object {
    -not $_.NonRemovable -and
    -not $_.IsFramework -and
    $_.Name -notlike '*MicrosoftEdge*' -and
    $_.Name -notlike '*Edge.GameAssist*'
}

foreach ($app in $apps) {
    $startApp = $startApps | Where-Object { $_.AppID -like ('*' + $app.Name + '*') } | Select-Object -First 1
    $displayName = if ($startApp) { $startApp.Name } else { $app.Name }
    $displayName = $displayName -replace '^(MicrosoftWindows|Microsoft)[.\s]+', ''

    if ([string]::IsNullOrEmpty($displayName)) { continue }
    if ($displayName -match '^[0-9a-f]{8}-[0-9a-f]{4}-') { continue }

    [void]$result.Add([PSCustomObject]@{
        name            = $app.Name
        displayName     = enc $displayName
        packageFullName = $app.PackageFullName
        kind            = 'appx'
    })
}

# Edge
$edge = Get-AppxPackage -Name '*MicrosoftEdge*' | Select-Object -First 1
if ($edge) {
    [void]$result.Add([PSCustomObject]@{
        name            = $edge.Name
        displayName     = enc 'Microsoft Edge'
        packageFullName = $edge.PackageFullName
        kind            = 'edge'
    })
}
elseif (Test-Path (Join-Path $env:ProgramFiles 'Microsoft\Edge\Application\msedge.exe')) {
    [void]$result.Add([PSCustomObject]@{
        name            = 'MicrosoftEdge'
        displayName     = enc 'Microsoft Edge'
        packageFullName = $null
        kind            = 'edge'
    })
}

# OneDrive
if (Test-Path (Join-Path $env:SystemRoot 'System32\OneDriveSetup.exe')) {
    [void]$result.Add([PSCustomObject]@{
        name            = 'OneDrive'
        displayName     = enc 'OneDrive'
        packageFullName = $null
        kind            = 'onedrive'
    })
}

# Remote Desktop
if (Test-Path (Join-Path $env:SystemRoot 'System32\mstsc.exe')) {
    [void]$result.Add([PSCustomObject]@{
        name            = 'RemoteDesktop'
        displayName     = enc 'Podklyuchenie k udalennomu rabochemu stolu'
        packageFullName = $null
        kind            = 'rdp'
    })
}

$json = $result | ConvertTo-Json -Compress -Depth 3
if ([string]::IsNullOrEmpty($json)) { $json = '[]' }
[Console]::Out.Write($json)