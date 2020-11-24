# ◤
# ◢
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

echo -ne $nw$horiz
for i in $(seq $length); do
  echo -ne $horiz
done
echo -ne $horiz$horiz$ne
echo
echo -ne $sw$horiz
for i in $(seq $length); do
  echo -ne $horiz
done
echo -ne $horiz$horiz$se

echo -ne "\r"
echo -ne "\033[A\033[C\033[C"
echo -ne $fs
echo -ne "\033[B\033[D\033[D"
echo -ne $fs

for t in $(seq $length); do
  echo -ne "\033[A"
  echo -ne $horiz$fs
  echo -ne "\033[B\033[D\033[D\033[D"
  echo -ne $horiz$fs

  sleep "$((RANDOM % 2)).$((RANDOM % 10))"
done

echo -ne "\033[A"
echo -ne $horiz$fs
echo -ne "\033[B\033[D\033[D\033[D"
echo -ne $horiz$fs

echo -ne "\033[?25h"
echo
