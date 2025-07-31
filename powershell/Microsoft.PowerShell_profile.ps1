# PowerShell equivalents of bash functions from .bashrc.arch

# Fuzzy cd into specific folders
function fcd {
    param(
        [string]$Filter = ""
    )
    
    $dirs = @()
    
    # Add .config directories
    $dirs += Get-ChildItem "$env:HOME/.config" -Directory -Force | Select-Object -ExpandProperty FullName
    $dirs += Get-ChildItem "$env:HOME/.config" -Force | Where-Object { $_.Attributes -band [System.IO.FileAttributes]::ReparsePoint } | Select-Object -ExpandProperty FullName
    
    # Add .cache directories
    $dirs += Get-ChildItem "$env:HOME/.cache" -Directory -Force | Select-Object -ExpandProperty FullName
    
    # Add ghq directories (depth 2)
    if (Test-Path "$env:HOME/ghq") {
        $dirs += Get-ChildItem "$env:HOME/ghq" -Directory | ForEach-Object {
            Get-ChildItem $_.FullName -Directory | Select-Object -ExpandProperty FullName
        }
    }
    
    # Add home directories (excluding .git)
    $dirs += Get-ChildItem "$env:HOME" -Directory | Where-Object { $_.Name -notmatch '^\.git$' } | Select-Object -ExpandProperty FullName
    
    if ($Filter) {
        $selected = $dirs | fzf --filter="$Filter" --select-1 --exit-0 | Select-Object -First 1
    } else {
        $selected = $dirs | fzf
    }
    
    if ($selected) {
        Set-Location $selected
        
        # Check for .nvmrc and switch Node version if needed
        if (Test-Path ".nvmrc") {
            $nvmrcVersion = Get-Content ".nvmrc"
            $currentVersion = nvm current
            if ($nvmrcVersion -ne $currentVersion) {
                nvm use
            }
        }
    } else {
        Write-Host "ERROR: No selection made." -ForegroundColor Red
    }
}

# Clone repository function
function cl {
    param(
        [Parameter(Position=0)]
        [string]$Arg1,
        [Parameter(Position=1)]
        [string]$Arg2,
        [Parameter(Position=2)]
        [string]$Arg3
    )
    
    if (-not $Arg1) {
        # Show help text
        Write-Host "Usage: cl REPOSITORY_NAME"
        Write-Host "Usage: cl REPOSITORY_URL"
        Write-Host "Usage: cl (hub|lab) REPOSITORY_NAME"
        Write-Host "Usage: cl (hub|lab) NAMESPACE REPOSITORY_NAME"
        return
    }
    
    $url = $Arg1
    $ghqDir = "$env:HOME/ghq"
    $namespace = ""
    $repositoryName = ""
    
    # Check if it's a full Git URL
    if ($url -match 'git@git(lab|hub)\.com:([^/]+)/([^/]+)\.git') {
        $namespace = $Matches[2]
        $repositoryName = $Matches[3]
    }
    elseif ($url -match 'https://git(lab|hub)\.com/([^/]+)/([^/]+)(\.git)?') {
        $namespace = $Matches[2]
        $repositoryName = $Matches[3]
    }
    else {
        # Handle shorthand formats
        $repositoryName = $Arg1
        $namespace = "juancwu"
        $domain = "hub"  # Default to GitHub
        
        # Check if domain was provided
        if ($Arg2) {
            if ($Arg1 -eq "hub" -or $Arg1 -eq "lab") {
                $domain = $Arg1
                $repositoryName = $Arg2
            } else {
                $repositoryName = $Arg1
            }
        }
        
        # Check if namespace was also provided
        if ($Arg3) {
            $domain = $Arg1
            $namespace = $Arg2
            $repositoryName = $Arg3
        }
        
        $url = "git@git$domain.com:$namespace/$repositoryName.git"
    }
    
    # Create directory if it doesn't exist
    $repositoryDir = Join-Path $ghqDir $namespace $repositoryName
    if (-not (Test-Path $repositoryDir)) {
        New-Item -ItemType Directory -Path $repositoryDir -Force | Out-Null
    }
    
    # Clone the repository
    git clone $url $repositoryDir
}

# Additional helper function: fuzzy find all directories from current directory
function cdf {
    param(
        [string]$Filter = ""
    )
    
    if ($Filter) {
        $selected = Get-ChildItem . -Recurse -Directory | Select-Object -ExpandProperty FullName | fzf --filter="$Filter" --select-1 --exit-0 | Select-Object -First 1
    } else {
        $selected = Get-ChildItem . -Recurse -Directory | Select-Object -ExpandProperty FullName | fzf
    }
    
    if ($selected) {
        Set-Location $selected
    }
}

# Set aliases similar to bash
Set-Alias -Name gs -Value "git status"

# Note: For Windows, you'll need to install fzf separately:
# Install-Module -Name PSFzf -Scope CurrentUser -Force
# Or use scoop: scoop install fzf