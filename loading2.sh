# ◤
# ◢
cap="\xe2\x97\xa4"
body="\xe2\x96\xa0"
horiz="\xe2\x94\x80"
nw="\xe2\x94\x8c"
ne="\xe2\x94\x90"
sw="\xe2\x94\x94"
se="\xe2\x94\x98"
vert="\xe2\x94\x82"
# slice="\xe2\x95\xb1"

length=$1

echo -ne "\033[?25l"

echo -ne $nw$horiz
for i in $(seq $length); do
  # echo -n " "
  echo -ne $horiz
done
echo -ne $ne
echo
echo
echo -ne $sw$horiz
for i in $(seq $length); do
  # echo -n " "
  echo -ne $horiz
done
echo -ne $se

echo -ne "\r\033[A"
for i in $(seq $length); do
  echo -n " "
done
echo -ne "  $vert\r$vert"

for t in $(seq $length); do
  # echo -ne "\033[A\033[C\033[C$slice""\033[D\033[D\033[D\033[B"

  echo -ne "$body$cap\b"
  sleep "$((RANDOM % 2)).$((RANDOM % 10))"
done
echo -ne $body

echo -e "\033[?25h"
echo
