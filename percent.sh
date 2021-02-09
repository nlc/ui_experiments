print_percent() {
  percent=$(echo "$1" | sed 's/^0*\([0-9]*\)\(\..*\)*/\1/g')
  ndigits=$()

  percent=${percent:-0}

  printf "%03d" $percent | sed 's/^\(0*\)/'"[2m"'\1'"[22m"'/'
}

echo -ne "\033[33m"
for percent in $(seq 0 100); do
  echo -ne "\r"
  print_percent $percent
  echo -ne "% "
  sleep 0.2
done
echo -ne "\033[0m"
