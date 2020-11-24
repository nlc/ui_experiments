# ├─┬─ SyxOs 1.0.7 on temple2.host
# │ ├─── username[35m:[0m [7m│Brown   │[0m
# │ └─┬─ password[35m:[0m [7m│********│[0m
# │   └─── verifying.......[32mOK[0m
# │

baton() {
  local nreps="$1"
  local anim="-\\|/"

  echo -ne ' '
  for i in $(seq "$nreps"); do
    for j in $(seq $(echo -n $anim | wc -c)); do
      echo -ne "\b$(echo -n $anim | cut -b $j)"
      sleep 0.1
    done
  done
  echo -ne "\b "
}

trickle() {
  local trickleword="$1"
  local wrapper1="$2"
  local wrapper2="$3"
  for j in $(seq $(echo -n "$trickleword" | wc -c)); do
    echo -ne "$wrapper1$(echo -n "$trickleword" | cut -b $j)$wrapper2"
    sleep "0.$((($RANDOM % 4) + 1))"
  done
}

echo -ne "[2H[2J"
sleep 0.5
echo -ne "[?25l"
echo -ne "[5m◯[0m"
sleep 3
echo -ne "[D◯"
echo -ne "\n"
echo -ne "└─── [34mSyxOs[0m 1.0.7 on temple2.host "
baton 3
echo -ne "[32D┬"
echo -ne "\n  └─── "
echo -ne "username[35m:[0m [7m│        │[0m"
echo -ne "[9D [D"
echo -ne "[?25h"
sleep 2
trickle Brown "[7m" "[0m"
sleep 1
echo -ne "[?25l"
echo -ne "[21D├"
echo -ne "\n  └─── "
echo -ne "password[35m:[0m [7m│        │[0m"
echo -ne "[9D [D"
echo -ne "[?25h"
sleep 1
trickle '******' "[7m" "[0m"
sleep 1
echo -ne "[?25l"
echo -ne "[20D┬"
echo -ne "\n    └─── "
echo -ne "verifying"
trickle '.......'
echo -ne '[32mOK[0m'
echo -ne '[32m[12D[A:[A[D:[2B[12C[0m'
sleep 0.5
echo -ne "\r[3A├"
sleep 0.1
for i in $(seq 4); do
  echo -ne "\r[B│"
  sleep 0.1
done
echo -ne "\n└─── Welcome, [1mBrown[0m [2m[[0m FrBr@temple2.host [2m][0m"
sleep 0.2
echo -ne "[39D┬"
echo -ne "\n  └─── id: 0x0840"
sleep 0.2
echo -ne "[15D├"
echo -ne "\n  └─── uflags: ADMIN PRIEST WHEEL HYPERVIS"
sleep 0.2
echo -ne "[40D├"
echo -ne "\n  └─── last login: [2m[[0m 20XX-10-03 14:51 EST (1 days ago) [2m][0m"
sleep 0.2
echo -ne "[54D├"
echo -ne "\n  └─── no. of logins: 86"
sleep 0.2
echo -ne "\r[4A├"
for i in $(seq 5); do
  echo -ne "\r[B│"
  sleep 0.1
done
echo -ne "\n└───[35m?[0m "
echo -ne "[?25h"
sleep 3
trickle "msgs"
echo -ne " "
echo -ne "[?25l"
sleep 0.2
echo -ne "[7D[32m?[0m[6C"
baton 4
sleep 0.1
echo -ne "[10D┬"
echo -ne "\n  └─── Message Queue ([37m2[0m)"
sleep 0.2
echo -ne "[20D┬"
echo -ne "\n    └─── [1m165: "Budget Meeting"[0m"
sleep 0.2
echo -ne "[22D┬"
echo -ne "\n      └─── from: FrWh@temple1.host (0x0001)"
sleep 0.2
echo -ne "[37D├"
echo -ne "\n      └─── sent: [2m[[0m 20XX-10-04 12:13 EST (1 hours ago) [2m][0m"
echo -ne "\r[2A    ├"
for i in $(seq 2); do
  echo -ne "\r    [B│"
  sleep 0.1
done
echo -ne "\n    └─── [1m161: "RE: Supply Chain"[0m"
sleep 0.2
echo -ne "[24D┬"
echo -ne "\n      └─── from: FrGr@temple6.host (0x711E)"
sleep 0.2
echo -ne "[37D├"
echo -ne "\n      └─── sent: [2m[[0m 20XX-10-04 10:21 EST (3 hours ago) [2m][0m"
sleep 0.2
echo -ne "\r[5A  [7m"
echo -ne "  ├─┬─ [1m165: "Budget Meeting"[22m                                  [0m"
echo -ne "\r[6B"


sleep 5
echo -ne "[?25h"
echo 
