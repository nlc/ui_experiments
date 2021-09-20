ll="\xe2\x97\x90"
uu="\xe2\x97\x93"
rr="\xe2\x97\x91"
dd="\xe2\x97\x92"
pose1='🯅'
pose2='🯆'
pose3='🯇'
pose4='🯈'

poses=(🯅 🯆 🯇 🯈)

pattern=(0 1 0 1 0 2 0 3)
patternlen=${#pattern[@]}

numcycles=$1

echo -ne "\033[?25l"

for t in $(seq $(($numcycles * $patternlen))); do
  patternindex=${pattern[$(($t % $patternlen))]}
  echo -ne "\b${poses[$patternindex]}"
  sleep 0.5
done

echo -e "\033[?25h"
