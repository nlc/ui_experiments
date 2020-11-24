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

fs="\xe2\x95\xb1"
bs="\xe2\x95\xb2"

length=$1

echo -ne "\033[?25l"

for i in $(seq $length); do
  echo -n " "
done
echo -ne "  $vert\r$vert"
echo
for i in $(seq $length); do
  echo -n " "
done
echo -ne "  $vert\r$vert"
echo -ne "\033[A"

for t in $(seq $length); do
  echo -ne $bs
  echo -ne "\033[D\033[B"
  echo -ne $fs
  echo -ne "\033[A"
  sleep "$((RANDOM % 2)).$((RANDOM % 10))"
done

echo -ne $bs
echo -ne "\033[D\033[B"
echo -ne $fs

echo -e "\033[?25h"
