ll="\xe2\x97\x90"
uu="\xe2\x97\x93"
rr="\xe2\x97\x91"
dd="\xe2\x97\x92"

circs=($ll $uu $rr $dd)

length=$1

echo -ne "\033[?25l"

for t in $(seq $(($length * 4))); do
  echo -ne "\b${circs[$(($t % 4))]}"
  sleep "0.$((RANDOM % 10))"
done

echo -e "\033[?25h"
