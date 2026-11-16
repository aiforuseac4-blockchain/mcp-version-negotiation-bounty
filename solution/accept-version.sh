#!/bin/sh
set -eu

[ "$#" -eq 3 ] || exit 64

requested=$1
supported=$2
selected=$3

# Helper: check if a token appears as a whole entry in a comma‑separated list
contains_token() {
  token=$1
  list=$2
  # Pad the list with commas to simplify exact‑token matching
  case ",$list," in
    *",$token,"*) return 0 ;;
    *) return 1 ;;
  esac
}

if contains_token "$requested" "$supported" && contains_token "$selected" "$supported"; then
  printf '%s\n' "$selected"
  exit 0
else
  exit 1
fi
