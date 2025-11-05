<#
.SYNOPSIS
  Copy a Rust build output into the .NET runtimes/ layout.
  Usage: ./move-native-libs.ps1 -RustOutputFile <path> -DestPath <path>
#>

param(
    [Parameter(Mandatory = $true)][string]$RustOutputFile,
    [Parameter(Mandatory = $true)][string]$DestPath
)

function Ensure-Dir {
    param([string]$Path)
    $dir = Split-Path -Parent $Path
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
}

if (-not (Test-Path $RustOutputFile)) {
    $dir = Split-Path $RustOutputFile -Parent

    Write-Host "Skipping missing file: $RustOutputFile" -ForegroundColor Yellow
    Write-Host "Listing contents of $dir"

    if (Test-Path $dir) {
        Get-ChildItem -Path $dir | ForEach-Object {
            Write-Host "   - $($_.Name)"
        }
    }
    else {
        Write-Host "Directory does not exist: $dir" -ForegroundColor Red
    }

    exit 0
}

Ensure-Dir $DestPath
Copy-Item -Path $RustOutputFile -Destination $DestPath -Force
Write-Host "✅ Copied $RustOutputFile -> $DestPath" -ForegroundColor Green