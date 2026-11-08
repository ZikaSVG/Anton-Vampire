# Convert .ico to .png in assets/papirus
# Run: powershell -ExecutionPolicy Bypass -File tools\convert-icons.ps1

Add-Type -AssemblyName System.Drawing

$Root    = Resolve-Path (Join-Path $PSScriptRoot '..')
$Papirus = Join-Path $Root 'assets\papirus'

if (-not (Test-Path $Papirus)) {
    Write-Host "ERROR: folder not found: $Papirus" -ForegroundColor Red
    exit 1
}

$Size      = 64
$OkCount   = 0
$SkipCount = 0
$FailCount = 0

Write-Host "Source: $Papirus"
Write-Host "Size:   $Size px"
Write-Host ""

Get-ChildItem -Path $Papirus -Filter *.ico -Recurse | ForEach-Object {
    $ico = $_
    $png = [System.IO.Path]::ChangeExtension($ico.FullName, '.png')

    if (Test-Path $png) {
        $pngTime = (Get-Item $png).LastWriteTimeUtc
        if ($pngTime -ge $ico.LastWriteTimeUtc) {
            Write-Host "[SKIP] $($ico.FullName.Replace($Root, ''))"
            $SkipCount++
            return
        }
    }

    try {
        $icon    = New-Object System.Drawing.Icon($ico.FullName)
        $bmp     = $icon.ToBitmap()
        $resized = New-Object System.Drawing.Bitmap($Size, $Size)
        $g       = [System.Drawing.Graphics]::FromImage($resized)

        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $g.DrawImage($bmp, 0, 0, $Size, $Size)
        $g.Dispose()

        $resized.Save($png, [System.Drawing.Imaging.ImageFormat]::Png)

        $bmp.Dispose()
        $resized.Dispose()
        $icon.Dispose()

        Write-Host "[OK]   $($png.Replace($Root, ''))" -ForegroundColor Green
        $OkCount++
    }
    catch {
        Write-Host "[FAIL] $($ico.FullName.Replace($Root, '')) : $($_.Exception.Message)" -ForegroundColor Red
        $FailCount++
    }
}

Write-Host ""
Write-Host "Done. OK: $OkCount  SKIP: $SkipCount  FAIL: $FailCount"