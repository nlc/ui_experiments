# ◤
# ◢
# curs="\xe2\x95\x89"
curs="\xe2\x94\xbd"
borderknob1="\xe2\x95\xbe"
borderknob2="\xe2\x95\xbc"
horiz="\xe2\x94\x80"
body="\xe2\x94\x81"

length=$1

echo -ne "\033[?25l"

for i in $(seq $length); do
  # echo -n " "
  echo -ne $horiz
done
echo -ne "$horiz$horiz$horiz$borderknob2\r$borderknob1"

for t in $(seq $length); do
  echo -ne "$body$curs\b"
  sleep "$((RANDOM % 2)).$((RANDOM % 10))"
done

echo -ne "$body$curs"

echo -e "\033[?25h"
