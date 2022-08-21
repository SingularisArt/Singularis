#!/usr/bin/bash

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/apps.rasi"

# Links
terminal=""
files=""
editor=""
browser=""
music=""
settings=""

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "$1"
}

# Variable passed to rofi
options="$terminal\n$files\n$editor\n$browser\n$music\n$settings"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
  $terminal)
    if [[ -f /usr/bin/xfce4-terminal ]]; then
      xfce4-terminal &
    elif [[ -f /usr/bin/alacritty ]]; then
      alacritty &
    else
      msg "No suitable terminal found!"
    fi
    ;;
  $files)
    if [[ -f /usr/bin/pcmanfm ]]; then
      pcmanfm &
    elif [[ -f /usr/bin/nautilus ]]; then
      nautilus &
    elif [[ -f /usr/bin/thunar ]]; then
      thunar &
    else
      msg "No suitable file manager found!"
    fi
    ;;
  $editor)
    if [[ -f /usr/bin/nvim ]]; then
      xfce4-terminal -e "nvim" &
    elif [[ -f /usr/bin/atom ]]; then
      atom &
    else
      msg "No suitable text editor found!"
    fi
    ;;
  $browser)
    if [[ -f /usr/bin/google-chrome-stable ]]; then
      google-chrome-stable &
    elif [[ -f /usr/bin/firefox ]]; then
      firefox &
    else
      msg "No suitable web browser found!"
    fi
    ;;
  $music)
    if [[ -f /usr/bin/ncmpcpp ]]; then
      xfce4-terminal -e "ncmpcpp" &
    elif [[ -f /usr/bin/spotify ]]; then
      spotify &
    else
      msg "No suitable music player found!"
    fi
    ;;
  $settings)
    if [[ -f /usr/bin/xfce4-settings-manager ]]; then
      xfce4-settings-manager &
    else
      msg "No suitable settings manager found!"
    fi
    ;;
esac
