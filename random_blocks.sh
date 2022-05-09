random_blocks() {
  n=${1:-1024}
  for i in $(seq $n); do
    case $((RANDOM % 4)) in
      0)
        echo -ne " "
      ;;
      1)
        echo -ne "▄"
      ;;
      2)
      echo -ne "▀"
      ;;
      3)
        echo -ne "█"
      ;;
    esac
  done
}

# for i in $(seq 10240 10495); do echo -ne "$(printf '\\u%04x' $i)"; done
random_braille() {
  n=${1:-1024}
  for i in $(seq $n); do
    echo -ne "$(printf '\\u%04x' $((10240 + (RANDOM % 256))))"
  done
}
