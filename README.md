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
| `extras/jwm-autostart.sh` | `~/.local/bin/jwm-autostart.sh` |
| `extras/screenshot-tool.sh` | `~/.local/bin/screenshot-tool.sh` |
| `extras/rofi-config.rasi` | `~/.config/rofi/config.rasi` |
| `extras/volumeicon` | legacy reference (not installed by default) |

The applications menu uses `xdgmenumaker -n -i -f jwm` (available on both Arch and
Debian) instead of `xdg_menu`. If your `xdgmenumaker`/JWM combination produces
broken labels because of raw `&` characters, pipe the include through `sed` to
escape them before JWM parses the menu.

## Dependencies

Arch:

```sh
sudo pacman -S jwm rofi xterm thunar pasystray cbatticon network-manager-applet \
  scrot xclip libnotify tango-icon-theme liberation-fonts playerctl wireplumber
yay -S xdgmenumaker          # AUR
sudo pacman -S python-xdg gtk3   # xdgmenumaker needs pyxdg + GTK 3 introspection
```

Debian / Ubuntu:

```sh
sudo apt install jwm rofi xterm thunar pasystray cbatticon network-manager-gnome \
  scrot xclip libnotify-bin tango-icon-theme fonts-liberation xdgmenumaker \
  python3-xdg gir1.2-gtk-3.0 playerctl wireplumber
```

`wireplumber` provides `wpctl` for the volume/media key bindings; `playerctl`
is optional for play/pause/next/previous keys.

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
- Volume/mute/mic-mute media keys are bound in JWM via `wpctl` (PipeWire/
  WirePlumber), which works well with `pasystray`.
- Media play/pause/next/previous keys use `playerctl` (optional dependency).
- Brightness keys use `brightnessctl`; add your user to the `video` group if
  needed.
- Startup tray applets are launched through `~/.local/bin/jwm-autostart.sh`
  with `pgrep` guards to avoid duplicates on JWM restart.
- Global window options include `tiled` and `aerosnap`; adjust the `Group`
  section in `jwmrc` if specific apps need different behavior.
- To try another theme, add the XML file under `themes/` and change the single
  `<Include>` line in `jwmrc` (or in `~/.config/jwm/themes/` after install).
