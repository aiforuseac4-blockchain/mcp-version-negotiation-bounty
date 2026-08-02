#!/bin/sh
set -eu

[ "$#" -eq 3 ] || exit 64

requested=$1
supported=$2
selected=$3

# Exact whole-token membership only (comma-separated supported list).
# Rejects substring matches such as 2025-06-18 inside 2025-06-18-preview.
member() {
  needle=$1
  list=$2
  old_ifs=$IFS
  IFS=,
  # shellcheck disable=SC2086
  set -- $list
  IFS=$old_ifs
  for tok in "$@"; do
    [ "$tok" = "$needle" ] && return 0
  done
  return 1
}

member "$requested" "$supported" || exit 1
member "$selected" "$supported" || exit 1

printf '%s\n' "$selected"
