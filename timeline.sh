# ┌
# ─
# ┐
# ╱
# ╲
# └
# ┘
# ┬
# ┴
toup="\xe2\x94\x8c"
across="\xe2\x94\x80"
todown="\xe2\x94\x90"
rise="\xe2\x95\xb1"
fall="\xe2\x95\xb2"
levelout="\xe2\x94\x94"
pullup="\xe2\x94\x98"
linkdown="\xe2\x94\xac"
linkup="\xe2\x94\xb4"
uld="\xe2\x94\xa4"
urd="\xe2\x94\x9c"

# prepare
echo
echo
echo
echo -ne "\033[A\033[A\033[A"

for x in $(seq 2); do
  echo -ne $across
  for i in $(seq 9); do
    echo -ne "$linkdown$across"
  done

  echo -ne $uld
  echo -ne "\033[B\033[D"
  echo -ne $levelout

  echo -ne $across
  for i in $(seq 9); do
    echo -ne "$linkup$across"
  done

  echo -ne $pullup
  echo -ne "\033[A\033[D"
  echo -ne $urd
done

echo
echo
