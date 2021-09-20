pose1="\xf0\x9f\xaf\x85"
pose2="\xf0\x9f\xaf\x86"
pose3="\xf0\x9f\xaf\x87"
pose4="\xf0\x9f\xaf\x88"

poses=("$pose1" "$pose2" "$pose3" "$pose4")

pattern=(0 1 0 1 0 2 0 3)
patternlen=${#pattern[@]}

numcycles=$1

moveforward=1

echo -ne "\033[?25l"

for t in $(seq $(($numcycles * $patternlen))); do
  patternindex=${pattern[$(($t % $patternlen))]}
  echo -ne "\b${poses[$patternindex]}"
  sleep 0.2

  if [[ "$moveforward" -eq 1 ]] && (($t % $patternlen == 0)); then
    echo -ne "\b  "
  fi
done

echo -e "\033[?25h"
