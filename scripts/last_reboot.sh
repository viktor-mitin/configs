last | awk '/ttyp|crash|reboot/ {if($1 !~ "user") printf("\033[01;31m"$0"\033[00m\n" ); else print $0 }'|head
