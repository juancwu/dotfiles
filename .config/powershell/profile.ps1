# Prompt
oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_mocha.omp.json' | Invoke-Expression

# Terminal Icons
Import-Module -Name Terminal-Icons

# Set up autocompletion
Import-Module -Name PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf

# Simulate the peco change directory functionality from mac/linux setups
# function Fuzzy-Find {
#     param(
#         [boolean]$file = $false,
#         [boolean]$a    = $false, # shows only current working directory
#         [int]$depth    = 1
#         )
# 
#     $ghq = "$env:USERPROFILE\ghq"
#     $app_data = "$env:USERPROFILE\AppData\Local"
#     $cwd = (Get-Location).Path
# 
#     if ($file) {
#         if (!$a) {
#             $items = Get-ChildItem $cwd -Recurse -Attributes !Directory -Depth $depth
#         } else {
#             $f1 = Get-ChildItem $cwd, $app_data -Recurse -Attributes !Directory -Depth $depth
#             $f2 = Get-ChildItem $ghq -Recurse -Attributes !Directory -Depth 3
#             $items = @($f1 ; $f2)
#         }
#     } else {
#         if (!$a) {
#             $items = Get-ChildItem $cwd -Recurse -Attributes Directory -Depth $depth
#         } else {
#             $dir1 = Get-ChildItem $cwd, $app_data -Recurse -Attributes Directory -Depth $depth
#             $dir2 = Get-ChildItem $ghq -Recurse -Attributes Directory -Depth 3
#             $items = @($dir1 ; $dir2)
#         }
#     }
# 
#     $selected = $items | Invoke-Fzf
#     if ($selected -ne $null) {
#         if ($file) {
#             vim $selected
#         } else {
#             Set-Location $selected
#         } 
#     }
# }

# search file in current directory
function sf([int]$d=0) {
    # Fuzzy-Find -file $true -a $a -depth $d
    # This function should act like telescope inside nvim
    # Include files and directoies at the surface level (include hidden)
    $items = Get-ChildItem (Get-Location).Path -Attributes Directory,!Directory,Hidden -Depth $d
    $selected = $items | Invoke-Fzf
    if ($selected -ne $null) {
        if (Test-Path $selected -PathType Leaf) {
            # file so we open for edit
            vim $selected
        } else {
            # directory so we navigate to it
            Set-Location $selected
        }
    }
}

# Opens the directories that I often go to
# Fast Forward
function ff() {
    $ghq = Get-ChildItem $env:USERPROFILE\ghq -Attributes Directory -Depth 1
    $app_data = Get-ChildItem $env:USERPROFILE\AppData -Attributes Directory
    $unity_projects = Get-ChildItem "E:\Unity Projects" -Attributes Directory
    $directories = @($ghq ; $app_data ; $unity_projects)
    $selected = $directories | Invoke-Fzf
    if ($selected -ne $null) {
        Set-Location $selected
    }
}


# Set up an alias to clone repository using gh cli to a predefined location
# This helps organize the repositories
function Get-RepoName([string]$repo) {
	gh repo view $repo | Select-String "^name:" | ForEach-Object { $_ -replace "name:","" } | ForEach-Object { $_.Trim() }
}

function clone([string]$repo) {
	$name = Get-RepoName $repo
	gh repo clone "$name" "$env:USERPROFILE/ghq/$name"
}

function which($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function link($link, $target) {
	New-Item -ItemType SymbolicLink -Path "$link" -Target "$target"
}

Set-Alias ll ls
Set-Alias g git
Set-Alias cc clear
Set-Alias grep findstr
Set-Alias vim nvim
