# PowerShell Profile Setup Script

# Determine the PowerShell profile directory
$profileDir = Split-Path $PROFILE -Parent

# Create profile directory if it doesn't exist
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "Created PowerShell profile directory: $profileDir" -ForegroundColor Green
}

# Copy the profile file
$sourceProfile = Join-Path $PSScriptRoot "Microsoft.PowerShell_profile.ps1"
$targetProfile = $PROFILE

if (Test-Path $sourceProfile) {
    Copy-Item $sourceProfile $targetProfile -Force
    Write-Host "PowerShell profile installed to: $targetProfile" -ForegroundColor Green
} else {
    Write-Host "ERROR: Source profile not found at $sourceProfile" -ForegroundColor Red
    exit 1
}

# Check if fzf is installed
try {
    $null = Get-Command fzf -ErrorAction Stop
    Write-Host "fzf is already installed" -ForegroundColor Green
} catch {
    Write-Host "WARNING: fzf is not installed. The fcd and cdf functions require fzf." -ForegroundColor Yellow
    Write-Host "Install fzf using one of these methods:" -ForegroundColor Yellow
    Write-Host "  - Windows: scoop install fzf" -ForegroundColor Cyan
    Write-Host "  - Windows: choco install fzf" -ForegroundColor Cyan
    Write-Host "  - Cross-platform: Install-Module -Name PSFzf -Scope CurrentUser" -ForegroundColor Cyan
}

# Check if git is installed
try {
    $null = Get-Command git -ErrorAction Stop
    Write-Host "git is already installed" -ForegroundColor Green
} catch {
    Write-Host "WARNING: git is not installed. The cl function requires git." -ForegroundColor Yellow
}

Write-Host "`nSetup complete! Reload your PowerShell profile with:" -ForegroundColor Green
Write-Host "  . `$PROFILE" -ForegroundColor Cyan