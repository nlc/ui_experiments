for i in $(seq 10000); do
  if ((RANDOM % 2)); then
    echo -ne "▄"
  else
    echo -ne "▀"
  fi
done

# █
