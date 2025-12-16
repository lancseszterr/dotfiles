#!/bin/bash

# Function to get current volume and mute status
get_volume() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{
        volume = $2
        muted = $3
        if (muted == "[MUTED]") {
            icon = "󰖁"
            class = "muted"
        } else {
            if (volume >= 0.5) {
                icon = "󰕾"
            } else if (volume > 0) {
                icon = "󰖀"
            } else {
                icon = "󰕿"
            }
            class = "unmuted"
        }
        # Convert to percentage
        volume_pct = int(volume * 100)
        printf "{\"text\": \"%s %d%%\", \"class\": \"%s\"}\n", icon, volume_pct, class
    }'
}

# Handle waybar events
case $1 in
--scroll-up)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  ;;
--scroll-down)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  ;;
--click)
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  ;;
*)
  get_volume
  ;;
esac
