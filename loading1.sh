# ◤
# ◢
cap="\xe2\x97\xa4"
pac="\xe2\x97\xa2"
body="\xe2\x96\xa0"
border="\xe2\x95\x91"
borderhook="\xe2\x95\xab"
borderhook1="\xe2\x95\x9f"
borderhook2="\xe2\x95\xa2"
borderhook1x2="\xe2\x95\xa0"
borderhook2x2="\xe2\x95\xa3"
borderknob1="\xe2\x95\xbe"
borderknob2="\xe2\x95\xbc"
dashes="\xe2\x94\x88"
horiz="\xe2\x94\x80"
horizx2="\xe2\x95\x90"

length=$1

echo -ne "\033[?25l"

for i in $(seq $length); do
  # echo -n " "
  echo -ne $horiz
done
echo -ne "$horiz$horiz$horiz$horiz$borderknob2\r$borderknob1$pac"

for t in $(seq $length); do
  echo -ne "$body$cap\b"
  sleep "$((RANDOM % 2)).$((RANDOM % 10))"
done

echo -ne "$body$cap"

echo -e "\033[?25h"
