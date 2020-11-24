anim="-\\|/"

restore_cursor_and_quit() {
  echo -e "\033[?25h"
  exit
}

echo -ne "\033[?25l"
trap restore_cursor_and_quit SIGINT

while true; do
  for i in $(seq $(echo -n $anim | wc -c)); do
    echo -ne "\b$(echo -n $anim | cut -b $i)"
    sleep 0.1
  done
done
