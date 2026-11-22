# jwm-config

Portable JWM setup: window manager config, theme, custom title-button icons,
wallpaper, and the small helper configs that go with it. Uses `$HOME` paths, so
it works for any user without editing after cloning.

## What's inside

| Path | Installs to |
|---|---|
| `jwmrc` | `~/.jwmrc` |
| `themes/neutral-dark.xml` | `~/.config/jwm/themes/` |
| `icons/xp/` (PNG + SVG sources) | `~/.config/jwm/icons/xp/` |
| `assets/wallpaper.jpg` | `~/.config/jwm/wallpaper.jpg` |
| `extras/screenshot-tool.sh` | `~/.local/bin/screenshot-tool.sh` |
| `extras/volumeicon` | `~/.config/volumeicon/volumeicon` |
| `extras/rofi-config.rasi` | `~/.config/rofi/config.rasi` |

The applications menu uses `xdgmenumaker -i -f jwm` (available on both Arch and
Debian) instead of `xdg_menu`. `xdgmenumaker` leaves raw `&` characters in JWM
labels, so the include pipes through `sed` to escape them.

## Dependencies

Arch:

```sh
sudo pacman -S jwm rofi xterm thunar volumeicon cbatticon network-manager-applet \
  scrot xclip libnotify tango-icon-theme liberation-fonts
yay -S xdgmenumaker          # AUR
sudo pacman -S python-xdg gtk3   # xdgmenumaker needs pyxdg + GTK 3 introspection
```

Debian / Ubuntu:

```sh
sudo apt install jwm rofi xterm thunar volumeicon cbatticon network-manager-gnome \
  scrot xclip libnotify-bin tango-icon-theme fonts-liberation xdgmenumaker \
  python3-xdg gir1.2-gtk-3.0
```

## Install

```sh
git clone git@github.com:merazi/jwm-config.git ~/jwm-config
cd ~/jwm-config
chmod +x install.sh
./install.sh
jwm -restart
```

`install.sh` backs up the existing `~/.jwmrc` to `~/.jwmrc.bak`, copies
everything into place, and runs `jwm -p` to validate before you restart.

## Update

```sh
cd ~/jwm-config && git pull && ./install.sh && jwm -restart
```

## Notes

- Super/Windows key is the main modifier. `Super+1`/`Super+2` switch desktops,
  `Super+Left`/`Right` snap windows to screen halves, `Super+r` opens rofi.
- Volume/mute media keys are owned by volumeicon (see `extras/volumeicon`);
  JWM deliberately does not bind `XF86Audio*` keys.
- Brightness keys are commented out in `jwmrc`. To enable them, install
  `brightnessctl`, add your user to the `video` group, and uncomment them.
- To try another theme, add the XML file under `themes/` and change the single
  `<Include>` line in `jwmrc` (or in `~/.config/jwm/themes/` after install).
