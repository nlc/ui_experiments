# Four passes:
# 1. Draw ends and filler
# 2. Draw bar components
# 3. Draw percentage number
# 4. 

restore_cursor_and_quit() {
  echo -e "\033[?25h"
}

loadinteractive() {
  echo -ne "\033[?25l"
  trap restore_cursor_and_quit SIGINT

  local cap="[0m"
  local pac="[33m"
  local body="."
  local beginner="[ "
  local ender=" ]"
  local horiz=" "
  local cover=""

  local length=$1
  if [ -z "$length" ]; then
    length=$(($COLUMNS - 10))
  fi

  echo -ne "\033[?25l"

  while read -r line; do
    cover=$(($line * $length / 100))
    if [[ $cover -gt $length ]]; then
      cover=$length
    fi

    echo -ne "\r"
    for i in $(seq $length); do
      echo -ne $horiz
    done
    echo -ne "$horiz$ender\r$beginner$pac"

    # turns out that "seq 0" => 1\n0
    if [[ "$cover" -ne "0" ]]; then
      for i in $(seq 0 $cover); do
        echo -ne "$body$cap\b"
      done
    fi
  done

  echo -ne "\b$body$cap"
  echo -e "\033[?25h"
}

testgen() {
  for i in $(seq 100); do
    echo $i
    sleep "0.$(($RANDOM % 3))"
  done
}
