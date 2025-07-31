# PowerShell Configuration

This directory contains PowerShell equivalents of the bash functions from `.bashrc.arch`.

## Functions

### `fcd` - Fuzzy Change Directory
Searches through predefined directories and allows fuzzy selection:
- `~/.config` directories
- `~/.cache` directories  
- `~/ghq` repositories (2 levels deep)
- Home directories (excluding .git)

Usage:
```powershell
fcd           # Interactive fuzzy search
fcd dotfiles  # Quick filter and select best match
```

### `cl` - Clone Repository
Smart git clone that organizes repositories in `~/ghq` structure.

Usage:
```powershell
cl repo-name                    # Clones from github.com/juancwu/repo-name
cl hub repo-name               # Clones from github.com/juancwu/repo-name
cl lab repo-name               # Clones from gitlab.com/juancwu/repo-name
cl hub namespace repo-name     # Clones from github.com/namespace/repo-name
cl git@github.com:user/repo.git # Clones using full URL
```

### `cdf` - Change Directory Fuzzy
Searches all subdirectories from current location.

Usage:
```powershell
cdf          # Interactive fuzzy search
cdf src      # Quick filter for directories containing "src"
```

## Installation

### Automatic Setup
```powershell
cd ~/ghq/juancwu/dotfiles/powershell
./setup.ps1
```

### Manual Setup
1. Copy profile to PowerShell profile location:
   ```powershell
   cp Microsoft.PowerShell_profile.ps1 $PROFILE
   ```

2. Install dependencies:
   - **fzf** (required for fuzzy search):
     ```powershell
     # Using Scoop
     scoop install fzf
     
     # Using Chocolatey
     choco install fzf
     
     # Using PowerShell Gallery
     Install-Module -Name PSFzf -Scope CurrentUser
     ```

3. Reload profile:
   ```powershell
   . $PROFILE
   ```

## Notes

- The functions maintain compatibility with the bash versions
- Node version switching with nvm is supported in `fcd`
- Git aliases like `gs` for `git status` are included
- All paths use PowerShell's cross-platform `$env:HOME` variable