#!/bin/bash
# Colour configuration
dark_base03="#002b36"
#dark_base02="#073642"
dark_base01="#586e75"
#dark_base00="#657b83"
#dark_base_0="#839496"
dark_base_1="#93a1a1"
dark_base_2="#eee8d5"
#dark_base_3="#fdf6e3"
#accent_yellow="#b58900"
#accent_orange="#cb4b16"
#accent_red="#dc322f"
#accent_magenta="#d33682"
#accent_violet="#6c71c4"
#accent_blue="#268bd2"
#accent_cyan="#2aa198"
#accent_green="#859900"
dmenu_run -p "\$" -b -fn "Inconsolata:size=10" \
    -nb $dark_base03 -nf $dark_base_1 -sb $dark_base_2 -sf $dark_base01
