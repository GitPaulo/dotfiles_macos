#!/usr/bin/env bash
#
# toggle_keys_scroll.sh
# Toggles Command⇄Option swap (via hidutil) and natural scroll direction.

toggle_keyswap() {
  # Query current mapping
  local mapping
  mapping=$(hidutil property --get "UserKeyMapping" 2>/dev/null)

  if echo "$mapping" | grep -q "0x7000000E3"; then
    # If our swap is present, clear all modifier mappings
    hidutil property --set '{"UserKeyMapping":[]}' \
      && echo "🔄 Command/Option: restored to default"
  else
    # Otherwise apply swap for both left and right modifiers
    hidutil property --set '{
      "UserKeyMapping": [
        {"HIDKeyboardModifierMappingSrc":0x7000000E3,"HIDKeyboardModifierMappingDst":0x7000000E2},
        {"HIDKeyboardModifierMappingSrc":0x7000000E2,"HIDKeyboardModifierMappingDst":0x7000000E3},
        {"HIDKeyboardModifierMappingSrc":0x7000000E7,"HIDKeyboardModifierMappingDst":0x7000000E6},
        {"HIDKeyboardModifierMappingSrc":0x7000000E6,"HIDKeyboardModifierMappingDst":0x7000000E7}
      ]
    }' && echo "🔄 Command/Option: swapped"
  fi
}

toggle_scroll_direction() {
  # Read current setting (1 = natural, 0 = traditional)
  local current
  current=$(defaults read -g com.apple.swipescrolldirection 2>/dev/null || echo 1)

  if [[ "$current" -eq 1 ]]; then
    defaults write -g com.apple.swipescrolldirection -bool true
    echo "🔄 Scroll: set to unnatural"
  else
    defaults write -g com.apple.swipescrolldirection -bool false
    echo "🔄 Scroll: set to natural"
  fi

  # Flush the preference daemon so change takes effect immediately
  killall cfprefsd 2>/dev/null
}

toggle_keyswap
toggle_scroll_direction

