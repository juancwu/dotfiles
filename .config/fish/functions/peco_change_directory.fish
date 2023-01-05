function _peco_change_directory
  if [ (count $argv) ]
    peco --layout=bottom-up --query "$argv " | perl -pe 's/([ ()])/\\\\$1/g' | read foo
  else
    peco --layout=bottom-up | perl -pe 's/([ ()])/\\\\$1/g' | read foo
  end
  if [ $foo ]
    builtin cd $foo
    commandline -r ''
    commandline -f repaint
  else
    commandline ''
  end
end

function peco_change_directory
  begin
    echo $HOME/.config
    # ghq list -p # gh cli replaced this, so it is no longer needed
    # list local repositories 
    find $HOME/ghq -mindepth 2 -maxdepth 2 -type d 
    # home directory
    ls -ad $HOME/*/ | grep -v \.git
    # current directory
    ls -ad */ | perl -pe "s#^#$PWD/#" | grep -v \.git
  end | sed -e 's/\/$//' | awk '!a[$0]++' | _peco_change_directory $argv
end
