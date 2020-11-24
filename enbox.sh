# # single line
# hz=$(echo -ne "\xe2\x94\x80")
# vt=$(echo -ne "\xe2\x94\x82")
# tl=$(echo -ne "\xe2\x94\x8c")
# tr=$(echo -ne "\xe2\x94\x90")
# bl=$(echo -ne "\xe2\x94\x94")
# br=$(echo -ne "\xe2\x94\x98")

# double vertical
hz=$(echo -ne "\xe2\x94\x80")
hh=$(echo -ne "\xe2\x95\x90")
vt=$(echo -ne "\xe2\x94\x82")
vv=$(echo -ne "\xe2\x95\x91")
tl=$(echo -ne "\xe2\x95\x93")
tr=$(echo -ne "\xe2\x95\x96")
bl=$(echo -ne "\xe2\x95\x99")
br=$(echo -ne "\xe2\x95\x9c")

kl=$(echo -ne "\xe2\x95\xbc")
kr=$(echo -ne "\xe2\x95\xbe")

cc=$(echo -ne "\xe2\x95\xb0")
cq=$(echo -ne "\xe2\x95\xae")

xx=$(echo -ne "\xe2\x95\xb3")
dt=$(echo -ne "\xe2\x96\x9a")

iv=$(echo -ne "\033[7m")
rs=$(echo -ne "\033[0m")

bs=$(echo -ne "\xe2\x95\xb2")

# echo "$tl$hz$hz$hz$cq       $kr$tr"
# echo "$iv$vt   output   $vt$rs"
# echo "$bl$kl       $cc$hz$hz$hz$br"

echo "  $tl$hz$hz$hz$hz$hz$bs      $bs$hz$hz"
echo "  $vv      $bs      $bs"
echo "          $bs asdf $bs "
echo "           $bs      $bs      $vv"
echo "          $hz$hz$bs      $bs$hz$hz$hz$hz$hz$br"
