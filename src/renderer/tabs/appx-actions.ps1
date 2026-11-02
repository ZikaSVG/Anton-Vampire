# appx-actions.ps1
# Специальные действия: OneDrive / Remote Desktop / Edge / всё-удаляемое.

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('onedrive','rdp','edge','all-removable')]
    [string]$Action
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'SilentlyContinue'

$nsudo  = Join-Path $PSScriptRoot 'NSudoLG.exe'
$helper = Join-Path $PSScriptRoot 'Helper.exe'

switch ($Action) {

    'onedrive' {
        Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue
        $setup = Join-Path $env:SystemRoot 'System32\OneDriveSetup.exe'
        if (Test-Path $setup) {
            Start-Process -FilePath $setup -ArgumentList '/uninstall' -WindowStyle Hidden -Wait
        }
        Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

        foreach ($path in @(
            (Join-Path $env:LocalAppData 'OneDrive'),
            (Join-Path $env:ProgramData 'Microsoft OneDrive'),
            (Join-Path $env:UserProfile 'OneDrive'),
            (Join-Path $env:LocalAppData 'Microsoft\OneDrive')
        )) {
            if (Test-Path $path) {
                if (Test-Path $nsudo) {
                    Start-Process -FilePath $nsudo -ArgumentList "-U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c rd /s /q `"$path`"" -Wait
                } else {
                    Remove-Item -LiteralPath $path -Recurse -Force -ErrorAction SilentlyContinue
                }
            }
        }
        Get-ChildItem "$env:SystemRoot\WinSxS" -Filter 'amd64_microsoft-windows-onedrive-setup*' -Directory -ErrorAction SilentlyContinue |
            ForEach-Object {
                if (Test-Path $nsudo) {
                    Start-Process -FilePath $nsudo -ArgumentList "-U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c rd /s /q `"$($_.FullName)`"" -Wait
                } else {
                    Remove-Item -LiteralPath $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                }
            }
        foreach ($f in @('OneDriveSetup.exe','OneDrive.ico')) {
            $fp = Join-Path $env:SystemRoot "System32\$f"
            if (Test-Path $fp) {
                if (Test-Path $nsudo) {
                    Start-Process -FilePath $nsudo -ArgumentList "-U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c del /q `"$fp`"" -Wait
                } else {
                    Remove-Item -LiteralPath $fp -Force -ErrorAction SilentlyContinue
                }
            }
        }
        Remove-ItemProperty 'HKCU:\Software\Microsoft\OneDrive' -Name * -ErrorAction SilentlyContinue
        Remove-ItemProperty 'HKCU:\Software\Microsoft\OneDrive\Accounts' -Name * -ErrorAction SilentlyContinue

        Start-Process explorer.exe -ArgumentList '/root,' -WindowStyle Hidden
        [Console]::Out.Write('OK')
    }

    'rdp' {
        Stop-Process -Name mstsc -Force -ErrorAction SilentlyContinue
        $mstsc = Join-Path $env:SystemRoot 'System32\mstsc.exe'
        if (Test-Path $mstsc) {
            $p = Start-Process -FilePath $mstsc -ArgumentList '/uninstall' -WindowStyle Hidden -PassThru
            if ($p -and -not $p.HasExited) { Stop-Process -Id $p.Id -Force -ErrorAction SilentlyContinue }
        }
        Start-Sleep 2
        if (Test-Path $mstsc) {
            if (Test-Path $nsudo) {
                Start-Process -FilePath $nsudo -ArgumentList "-U:T -P:E -ShowWindowMode:Hide -Wait cmd.exe /c del /q `"$mstsc`"" -Wait
            } else {
                Remove-Item -LiteralPath $mstsc -Force -ErrorAction SilentlyContinue
            }
        }
        Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall' -ErrorAction SilentlyContinue |
            Where-Object { $_.PSChildName -like 'mstsc-*' } |
            ForEach-Object { Remove-Item $_.PsPath -Recurse -Force -ErrorAction SilentlyContinue }
        [Console]::Out.Write('OK')
    }

    'edge' {
        Get-AppxPackage -Name '*MicrosoftEdge*' -ErrorAction SilentlyContinue |
            ForEach-Object {
                Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue
            }
        $bases = @(
            (Join-Path $env:ProgramFiles 'Microsoft\Edge\Application'),
            (Join-Path ${env:ProgramFiles(x86)} 'Microsoft\Edge\Application')
        )
        foreach ($base in $bases) {
            if (Test-Path $base) {
                Get-ChildItem $base -Directory -ErrorAction SilentlyContinue | ForEach-Object {
                    $s = Join-Path $_.FullName 'Installer\setup.exe'
                    if (Test-Path $s) {
                        Start-Process -FilePath $s -ArgumentList '--uninstall','--system-level','--force-uninstall' -WindowStyle Hidden -Wait
                    }
                }
            }
        }
        [Console]::Out.Write('OK')
    }

    'all-removable' {
        Get-AppxPackage -ErrorAction SilentlyContinue |
            Where-Object { $_.NonRemovable -eq $false } |
            ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }
        [Console]::Out.Write('OK')
    }
}