# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __SingularisArt

__SingularisArt[ITALIC_ON]=$'\e[3m'
__SingularisArt[ITALIC_OFF]=$'\e[23m'

