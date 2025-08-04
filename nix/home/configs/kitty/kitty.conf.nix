{ config, pkgs, ... }:
{
  xdg.configFile."kitty/kitty.conf".text = ''
    # Font
    font_family      SpaceMono Nerd Font
    font_size 11.0

    # Window margins
    window_margin_width 21.75

    # Cursor shape
    cursor_shape beam

    # No stupid close confirmation
    confirm_os_window_close 0

    # Cursor trail
    cursor_trail_decay 0.1 0.4
    cursor_trail 2

    # Use fish shell
    shell fish

    # Copy for normies
    map ctrl+c       copy_or_interrupt

    # Zoom
    map ctrl+plus  change_font_size all +1
    map ctrl+equal  change_font_size all +1
    map ctrl+kp_add  change_font_size all +1

    map ctrl+minus       change_font_size all -1
    map ctrl+underscore  change_font_size all -1
    map ctrl+kp_subtract change_font_size all -1

    map ctrl+0 change_font_size all 0
    map ctrl+kp_0 change_font_size all 0

    # BEGIN_KITTY_THEME
    # Duskfox
    include current-theme.conf
    # END_KITTY_THEME
  '';
}
