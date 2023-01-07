function nvm
    set nvm_prefix (brew --prefix nvm)
    bass source "$nvm_prefix/nvm.sh" --no-use ';' nvm $argv
end
