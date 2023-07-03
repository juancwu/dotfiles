#x-server
#set -g DISPLAY $(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
#
#if test -x (command -v npiperelay.exe)
#  source (dirname (status --current-file))/config-npiperelay.fish
#end
