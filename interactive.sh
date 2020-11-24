restore_cursor_and_quit() {
  echo -e "\033[?25h"
}

loadinteractive() {
  echo -ne "\033[?25l"
  trap restore_cursor_and_quit SIGINT

  local cap="\xe2\x97\xa4"
  local pac="\xe2\x97\xa2"
  local body="\xe2\x96\xa0"
  local borderknob1="\xe2\x95\xbe"
  local borderknob2="\xe2\x95\xbc"
  local horiz="\xe2\x94\x80"
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
    echo -ne "$horiz$horiz$horiz$horiz$borderknob2\r$borderknob1$pac"

    # turns out that "seq 0" => 1\n0
    for i in $(seq 0 $cover); do
      echo -ne "$body$cap\b"
    done
  done

  echo -ne "\b$body$cap"
  echo -e "\033[?25h"
}

testgen() {
  for i in $(seq 120); do
    echo $i
    sleep "0.$(($RANDOM % 3))"
  done
}
