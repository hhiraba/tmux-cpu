#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

# script global variables
gpu_low_icon=""
gpu_medium_icon=""
gpu_high_icon=""
gpu_error_icon=""

gpu_low_default_icon="="
gpu_medium_default_icon="≡"
gpu_high_default_icon="≣"
gpu_error_default_icon="≣"

# icons are set as script global variables
get_icon_settings() {
  gpu_low_icon=$(get_tmux_option "@gpu_low_icon" "$gpu_low_default_icon")
  gpu_medium_icon=$(get_tmux_option "@gpu_medium_icon" "$gpu_medium_default_icon")
  gpu_high_icon=$(get_tmux_option "@gpu_high_icon" "$gpu_high_default_icon")
  gpu_error_icon=$(get_tmux_option "@gpu_error_icon" "$gpu_error_default_icon")
}

print_icon() {
  local gpu_percentage=$($CURRENT_DIR/gpu_percentage.sh | sed -e 's/%//')
  local gpu_load_status=$(load_status $gpu_percentage)
  if [ $gpu_load_status == "low" ]; then
    echo "$gpu_low_icon"
  elif [ $gpu_load_status == "medium" ]; then
    echo "$gpu_medium_icon"
  elif [ $gpu_load_status == "high" ]; then
    echo "$gpu_high_icon"
  elif [ $gpu_load_status == "error" ]; then
    echo "$gpu_error_icon"
  fi
}

main() {
  get_icon_settings
  local gpu_icon=$(print_icon "$1")
  echo "$gpu_icon"
}
main
