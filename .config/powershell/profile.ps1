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
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf

# Simulate the peco change directory functionality from mac/linux setups
function Fuzzy-Find {
    param(
        [boolean]$file = $false,
        [boolean]$a  = $false, # shows only current working directory
        [int]$depth   = 2
        )

    $ghq = "$env:USERPROFILE\ghq"
    $app_data = "$env:USERPROFILE\AppData\Local"
    $cwd_ = (Get-Location).Path


    if ($file) {
        if (!$a) {
            $items = Get-ChildItem $cwd_ -Recurse -Attributes !Directory -Depth $depth
        } else {
            $f1 = Get-ChildItem $cwd_, $app_data -Recurse -Attributes !Directory -Depth $depth
            $f2 = Get-ChildItem $ghq -Recurse -Attributes !Directory -Depth 3
            $items = @($f1 ; $f2)
        }
    } else {
        if (!$a) {
            $items = Get-ChildItem $cwd_ -Recurse -Attributes Directory -Depth $depth
        } else {
            $dir1 = Get-ChildItem $cwd_, $app_data -Recurse -Attributes Directory -Depth $depth
            $dir2 = Get-ChildItem $ghq -Recurse -Attributes Directory -Depth 3
            $items = @($dir1 ; $dir2)
        }
    }

    $selected = $items | Invoke-Fzf
    if ($selected -ne $null) {
        if ($file) {
            vim $selected
        } else {
            Set-Location $selected
        } 
    }
}

# Alias to run the peco-like function
function sf([switch]$a, [int]$d=2) {
    Fuzzy-Find -file $true -a $a -depth $d
}
function sd([switch]$a, [int]$d=2) {
    Fuzzy-Find -file $false -a $a -depth $d
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
