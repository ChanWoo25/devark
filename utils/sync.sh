#!/bin/bash

PrintHelpMessage() {
  echo "Usage: sync.sh [in|out]"
}

script_path="$(realpath "${BASH_SOURCE[0]}")"
root_dir="$(dirname "$script_path")"
in_or_out="$1"

# 현재 날짜와 시간
datetime=$(date '+%Y%m%d_%H%M%S')

SyncTerminatorIn() {
  echo "Syncing terminator config ..."
  src_config="$HOME/.config/terminator/config"
  dest_dir="$root_dir/.config/terminator"

  if [ ! -f "$src_config" ]; then
    echo "[SyncTerminatorIn] Source config not found: $src_config"
    return
  fi

  if [ -f "$dest_dir/config" ]; then
    cp "$dest_dir/config" "$dest_dir/config.bkup.${datetime}"
  fi

  mkdir -p "$dest_dir"
  cp "$src_config" "$dest_dir/"
}

SyncTerminatorOut() {
  echo "Syncing from project directory to HOME..."
  src_config="$root_dir/.config/terminator/config"
  dest_dir="$HOME/.config/terminator"

  if [ ! -f "$src_config" ]; then
    echo "Error: Source config not found: $src_config"
    exit 1
  fi

  mkdir -p "$dest_dir"
  cp "$src_config" "$dest_dir/"
  echo "Terminator config synced OUT."
}

case "$in_or_out" in
  in)
    SyncTerminatorIn
    ;;
  out)
    SyncTerminatorOut
    ;;
  *)
    PrintHelpMessage
    exit 1
    ;;
esac

exit 0
