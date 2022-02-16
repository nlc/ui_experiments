# Boot sequence
#   blink cursor
#   quick cascade of text (computer-level diagnostics)
#   first splash screen
#   login
#   physical system diagnostics
#   second splash screen
#   monitor screen (indefinite)

BOOT_ANIM_LOADING_BAR_MODE="edgeless"

progress_bar() {
  local numerator="$1"
  local denominator="$2"
  local bar_length="$3"

  # clamp
  if [[ "$numerator" -lt "0" ]]; then
    numerator="0"
  fi
  if [[ "$numerator" -gt "$denominator" ]]; then
    numerator="$denominator"
  fi

  percentage=$((100 * numerator / denominator))
  num_filled=$((bar_length * percentage / 100))
  num_unfilled=$((bar_length - num_filled))

  # hide cursor while writing so it doesn't "wobble"
  echo -ne "\033[?25l"

  if [[ "$BOOT_ANIM_LOADING_BAR_MODE" = "edgeless" ]]; then
    echo -ne "  "
    echo -ne "\033[7m"
    if [[ "$num_filled" -gt 0 ]]; then
      for i in $(seq $num_filled); do
        echo -ne " "
      done
    fi
    echo -ne "\033[27;40m"
    if [[ "$num_unfilled" -gt 0 ]]; then
      for i in $(seq $num_unfilled); do
        echo -ne " "
      done
    fi
    echo -ne "\033[0m"
    echo -ne " "
  else
    echo -ne " ["
    echo -ne "\033[7m"
    if [[ "$num_filled" -gt 0 ]]; then
      for i in $(seq $num_filled); do
        echo -ne " "
      done
    fi

    echo -ne "\033[27m"
    if [[ "$num_unfilled" -gt 0 ]]; then
      echo -ne "\033[$num_unfilled""C"
    fi
    echo -ne "]"
  fi

  # unhide cursor
  echo -ne "\033[?25h"

  echo -ne "\033[$((bar_length + 3))""D"
}

# flash some hex
flash_hex() {
  # clear screen
  echo -ne "\033[2J\033[H"

  for i in $(seq 8); do
    # head -c$((256 + RANDOM % 256)) /dev/urandom | xxd -u |\
    head -c$(( ($(tput lines) - 1) * 16 )) /dev/urandom | xxd -u |\
      awk -v seed=$RANDOM '
        BEGIN{srand(seed);}
        NF>=10{
          printf("%s ", $1);
          for(i=2;i<=9;i++){
            if(rand()<0.2){
              printf("\033[34m%s\033[0m ", $i);
            }else{
              printf("%s ", $i);
            }
          }
          printf("\n");
        }'
    sleep "0.$RANDOM"
    echo -ne "\033[H"
  done
}

# OS splash screen
os_splash() {
  echo -ne "\033[2J\033[H"
  echo -ne "\033[1m"
  if $(type figlet &>/dev/null); then
    figlet "CybOS v. 1.21.9" # | ruby ../code/sprinkle_cat/sprinkle_cat.rb
  fi
  echo -ne "\033[0m"
  echo
  sleep 0.5
}

# login
login_anim() {
  echo -ne "USER: "
  sleep 0.2
  echo -e "\033[2m[AUTO]\033[0m"
  sleep 0.5
  echo -ne "PASS: "
  sleep 0.2
  echo -e "\033[2m[AUTO]\033[0m"
  sleep 0.5
  echo
}

# login : system data
sysdata_anim() {
  echo -e "WELCOME \033[32mdefaultuser\033[0m\033[1m@\033[0m\033[32mM_unit13.local\033[0m"
  sleep 0.2
  echo
  echo -e "\033[1m        OS\033[0m: CybOS v. 1.21.9 \"\033[35mMetal Magenta\033[0m\" x86_64\033[0m"
  sleep 0.2
  echo -e "\033[1mLast login\033[0m: Wed Sep  9 17:54:14 CDT 20XX "
  sleep 0.2
  echo -e "\033[1m       CPU\033[0m: ARMv6-compatible processor rev 7 (v6.1)"
  sleep 0.2
  echo -e "\033[1m    Memory\033[0m: 111MiB / 481MiB"
  sleep 0.2
  echo
}

# subsystem "loading" animation
load_subsystem() {
  modulo=$((1 + RANDOM % 9))
  subsys_name="$1"
  echo -ne "\033[1m$subsys_name\033[0m"
  for i in $(seq 20); do
    progress_bar "$i" 20 30
    sleep "0.$((RANDOM % modulo))"
  done
  echo -e "\033[2K\r$subsys_name\033[32mOK\033[0m"
}

# physical system diagnostics
subsystem_boot_anim() {
  sleep 1
  echo -ne "Launching Control Program "
  for i in $(seq 20); do
    progress_bar "$i" 20 20
    sleep "0.$((RANDOM % 2))"
  done
  echo -ne "\033[2J\033[H"

  echo -e "\033[1;5m        SUBSYSTEM CONTROL BOOT        \033[0m"

  echo -ne "\033[2m"
  echo -e "MAINPWR:"
  echo -e "SERVOS :"
  echo -e "SENSORS:"
  echo -e "FIRECTL:"
  echo -e "COMMS  :"
  echo -e "CONNECT:"
  echo -e "NAVIGTN:"
  echo -e "EARLYWN:"
  echo -e "LIGHTS :"
  echo -e "CLIMATE:"
  echo -ne "\033[0m"

  echo -ne "\033[10A\r"

  load_subsystem "MAINPWR:"
  load_subsystem "SERVOS :"
  load_subsystem "SENSORS:"
  load_subsystem "FIRECTL:"
  load_subsystem "COMMS  :"
  load_subsystem "CONNECT:"
  load_subsystem "NAVIGTN:"
  load_subsystem "EARLYWN:"
  load_subsystem "LIGHTS :"
  load_subsystem "CLIMATE:"

  sleep 0.5
  echo -ne "\033[H"
  echo -ne "\033[1m        SUBSYSTEM CONTROL BOOT        \033[0m"

  echo -ne "\r\033[4B\033[14C"
  echo -ne "\033[7m    ALL    \033[0m"
  echo -ne "\r\033[B\033[14C"
  echo -ne "\033[7m    OK     \033[0m"
  echo -ne "\033[D"

  sleep 1
}

# control program ready splash screen
prog_splash() {
  echo -ne "\033[2J\033[H"
  echo -ne "\033[36m"
  echo -e "MOBCTL\n   Mk 3" | figlet -fbanner
  echo -ne "\033[0m"
  sleep 2

  echo -ne "\033[2J\033[H"
  sleep 1
}

draw_frame() {
  local in_width=40
  local in_height=20
  echo -ne "\033[7m"
  for i in $(seq $((in_width + 2))); do
    echo -n " "
  done
  echo -e "\033[27m"

  for i in $(seq $in_height); do
    echo -e "\033[7m \033[$in_width""C \033[27m"
  done

  echo -ne "\033[7m"
  for i in $(seq $((in_width + 2))); do
    echo -n " "
  done
  echo -ne "\033[27m"

  # return to top left internal corner
  echo -ne "\033[$((in_width + 1))""D\033[$in_height""A"
  echo -ne "\033[0m"
}

monitor_newline() {
  echo -ne "\r\033[B\033[2C"
}

monitor_power() {
  # power
  local status=0
  local power_level=$1
  local power_level_color=$(echo -ne "\033[35;7m")
  local digits_pattern='[0-9]+'
  if [[ "$power_level" =~ $digits_pattern ]]; then
    if [[ "$power_level" -ge "75" ]]; then
      # green
      power_level_color=$(echo -ne "\033[32m")
    elif [[ "$power_level" -ge "30" ]]; then
      # yellow
      power_level_color=$(echo -ne "\033[33m")
    elif [[ "$power_level" -gt "15" ]]; then
      # red
      power_level_color=$(echo -ne "\033[31m")
    elif [[ "$power_level" -gt "10" ]]; then
      # ultra red
      power_level_color=$(echo -ne "\033[31;7m")
    elif [[ "$power_level" -ge "0" ]]; then
      # ultra mega red
      power_level_color=$(echo -ne "\033[31;7;5m")
      status=1
    fi
    printf "\033[1mPWR\033[0m: %s%3s%%\033[0m " "$power_level_color" "$power_level"
  else
    printf "\033[1mPWR\033[0m: %s???%%\033[0m " "$power_level_color"
    status=1
  fi
  progress_bar "$power_level" 100 25

  monitor_newline

  return $status
}

monitor_cpuload() {
  # cpu load
  local status=0
  local cpu_load=$1
  local cpu_load_color=$(echo -ne "\033[35;7m")
  local digits_pattern='[0-9]+'
  if [[ "$cpu_load" =~ $digits_pattern ]]; then
    if [[ "$cpu_load" -le "50" ]]; then
      # green
      cpu_load_color=$(echo -ne "\033[32m")
    elif [[ "$cpu_load" -lt "90" ]]; then
      # yellow
      cpu_load_color=$(echo -ne "\033[33m")
    elif [[ "$cpu_load" -le "95" ]]; then
      # red
      cpu_load_color=$(echo -ne "\033[31m")
    elif [[ "$cpu_load" -le "99" ]]; then
      # ultra red
      cpu_load_color=$(echo -ne "\033[31;7m")
    elif [[ "$cpu_load" -le "100" ]]; then
      # ultra mega red
      cpu_load_color=$(echo -ne "\033[31;7;5m")
      status=1
    fi
    printf "\033[1mCPU\033[0m: %s%3s%%\033[0m " "$cpu_load_color" "$cpu_load"
  else
    printf "\033[1mCPU\033[0m: %s???%%\033[0m " "$cpu_load_color"
    status=1
  fi
  progress_bar "$cpu_load" 100 25

  monitor_newline

  return $status
}

monitor_temp() {
  # temperature
  local status=0
  local temperature=$1
  local temperature_color=$(echo -ne "\033[35;7m")
  local digits_pattern='[0-9]+'
  if [[ "$temperature" =~ $digits_pattern ]]; then
    if [[ "$temperature" -le "50" ]]; then
      # inverse blue--freezing up
      temperature_color=$(echo -ne "\033[34;7m")
      status=1
    elif [[ "$temperature" -le "90" ]]; then
      # blue--okay, maybe not warmed up
      temperature_color=$(echo -ne "\033[34m")
    elif [[ "$temperature" -le "120" ]]; then
      # magenta--between blue and red
      temperature_color=$(echo -ne "\033[35m")
    elif [[ "$temperature" -le "140" ]]; then
      # red
      temperature_color=$(echo -ne "\033[31m")
    else
      # ultra red
      temperature_color=$(echo -ne "\033[31;7m")
      status=1
    fi
    printf "\033[1mTMP\033[0m: %s%3sF\033[0m " "$temperature_color" "$temperature"
  else
    printf "\033[1mTMP\033[0m: %s???%%\033[0m " "$temperature_color"
    status=1
  fi
  progress_bar "$temperature" 140 25

  monitor_newline

  return $status
}

monitor_signal() {
  # carrier signal intensity
  local status=0
  local carrier_signal="$1"
  local carrier_signal_color=$(echo -ne "\033[35;7m")
  local digits_pattern='[0-9]+'
  if [[ "$carrier_signal" =~ $digits_pattern ]]; then
    local remapped_value=$((2 * carrier_signal + 240))
    if [[ "$remapped_value" -le "10" ]]; then
      # ultra mega red
      carrier_signal_color=$(echo -ne "\033[31;7;5m")
      status=1
    elif [[ "$remapped_value" -le "25" ]]; then
      # ultra red
      carrier_signal_color=$(echo -ne "\033[31;7m")
    elif [[ "$remapped_value" -le "50" ]]; then
      # red
      carrier_signal_color=$(echo -ne "\033[31m")
    elif [[ "$remapped_value" -le "75" ]]; then
      # yellow
      carrier_signal_color=$(echo -ne "\033[33m")
    elif [[ "$remapped_value" -le "100" ]]; then
      # green
      carrier_signal_color=$(echo -ne "\033[32m")
    fi
    printf "\033[1mSIG\033[0m:%s%3sdBm\033[0m" "$carrier_signal_color" "$carrier_signal"

    # slight hack since the string can be too long
    if [[ "$carrier_signal" -le "-100" ]]; then
      echo -ne "\033[D"
    fi
  else
    printf "\033[1mSIG\033[0m:%s???dBm\033[0m " "$carrier_signal_color"
    status=1
  fi
  progress_bar "$remapped_value" 100 25

  monitor_newline

  return $status
}

monitor_loc() {
  local grid_square="$1"
  local altitude="$2"
  local heading="$3"
  local velocity="$4"
  local heading_string=""
  local nn_string="N"
  local ne_string="NE"
  local ee_string="E"
  local se_string="SE"
  local ss_string="S"
  local sw_string="SW"
  local ww_string="W"
  local nw_string="NW"

  if [[ "$heading" -lt "23" ]]; then
    heading_string="$nn_string"
  elif [[ "$heading" -lt "68" ]]; then
    heading_string="$ne_string"
  elif [[ "$heading" -lt "113" ]]; then
    heading_string="$ee_string"
  elif [[ "$heading" -lt "158" ]]; then
    heading_string="$se_string"
  elif [[ "$heading" -lt "203" ]]; then
    heading_string="$ss_string"
  elif [[ "$heading" -lt "248" ]]; then
    heading_string="$sw_string"
  elif [[ "$heading" -lt "293" ]]; then
    heading_string="$ww_string"
  elif [[ "$heading" -lt "338" ]]; then
    heading_string="$nw_string"
  else
    heading_string="$nn_string"
  fi

  printf "\033[1mLOC\033[0m: Sector   %s" "$grid_square"
  monitor_newline
  printf "     Altitude %04d m" "$altitude"
  monitor_newline
  printf "     Heading  %03s (% 2s) @ %06.3f m/s ⣷⣼⣄⣼" "$heading" "$heading_string" "$velocity"
}

# monitor screen (indefinite)
monitor_screen() {
  echo -ne "\033[2J\033[H"

  draw_frame

  monitor_newline

  local cumulative_status=0
  local last_status=0

  # power
  monitor_power $((RANDOM % 100))
  last_status="$?"
  cumulative_status=$((cumulative_status | last_status))
  monitor_newline

  # internal temp
  monitor_temp $((RANDOM % 120 + 30))
  last_status="$?"
  cumulative_status=$((cumulative_status | last_status))
  monitor_newline

  # cpu load
  monitor_cpuload $((RANDOM % 15 + 86))
  last_status="$?"
  cumulative_status=$((cumulative_status | last_status))
  monitor_newline

  # carrier signal level
  monitor_signal $((RANDOM % 50 - 120))
  last_status="$?"
  cumulative_status=$((cumulative_status | last_status))
  monitor_newline

  # actuators on

  # location
  local alphabet=$(echo {A..Z} | tr -d ' ')
  local grid_char=${alphabet:$((RANDOM % 26)):1}
  local grid_coord=$(printf "%s:%02d" "$grid_char" "$((RANDOM % 26 + 1))")
  local altitude=$((60 + RANDOM % 600))
  local heading="$((RANDOM % 360))"
  local velocity="$((1 + RANDOM % 19)).$((RANDOM % 10000))"
  monitor_loc "$grid_coord" "$altitude" "$heading" "$velocity"

  # sensor contacts
  # lights on or off
  # other notifications (msgs?)

  # time and ambient temp


  if [[ "$cumulative_status" -ne "0" ]]; then
    echo -ne "\033[31m\033[H"
    draw_frame
    echo -ne "\033[0m"
  fi

  echo -ne "\033[H"
}

echo -ne "\033[0m"

monitor_screen
sleep 10

flash_hex

# quick interstitial OK
echo -ne "\033[2J\033[H"
echo -e "0x0000000100C5600D OK"
sleep 0.4

os_splash

login_anim

sysdata_anim

# quick fake prompt
echo -e "$"
echo

subsystem_boot_anim

prog_splash

draw_frame
sleep 1

for i in $(seq 3); do
  monitor_screen
  sleep 1
done

monitor_newline
echo -ne "\033[21B"
# sleep 5
