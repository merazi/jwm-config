# jwm-config

Portable JWM setup: window manager config, theme, custom title-button icons,
wallpaper, and the small helper configs that go with it. Uses `$HOME` paths, so
it works for any user without editing after cloning.

## What's inside

| Path | Installs to |
|---|---|
| `jwmrc` | `~/.jwmrc` |
| `themes/*.xml` | `~/.config/jwm/themes/` |
| `icons/monolith/`, `icons/xp/`, `icons/win9x/` (PNG + SVG sources) | `~/.config/jwm/icons/` |
| `assets/wallpaper.jpg` | `~/.config/jwm/wallpaper.jpg` |
| `extras/jwm-autostart.sh` | `~/.local/bin/jwm-autostart.sh` |
| `extras/screenshot-tool.sh` | `~/.local/bin/screenshot-tool.sh` |
| `extras/rofi-config.rasi` | `~/.config/rofi/config.rasi` |
| `extras/volumeicon` | legacy reference (not installed by default) |

The applications menu uses `xdgmenumaker -n -i -f jwm` (available on both Arch and
Debian) instead of `xdg_menu`. Its output can contain a raw `&` (for example in
`2>&1`), which JWM reports as `invalid entity`. The include in `jwmrc` already
pipes the output through `sed` to escape ampersands into XML entities; the `&`
is written as `\x26` in the config so JWM doesn't trip over it while parsing
`jwmrc` itself.

## Dependencies

Arch:

```sh
sudo pacman -S jwm rofi xterm thunar pasystray cbatticon network-manager-applet \
  scrot xclip libnotify tango-icon-theme liberation-fonts playerctl wireplumber \
  i3lock imagemagick xorg-xrandr
yay -S xdgmenumaker          # AUR
sudo pacman -S python-xdg gtk3   # xdgmenumaker needs pyxdg + GTK 3 introspection
```

Debian / Ubuntu:

```sh
sudo apt install jwm rofi xterm thunar pasystray cbatticon network-manager-gnome \
  scrot xclip libnotify-bin tango-icon-theme fonts-liberation xdgmenumaker \
  python3-xdg gir1.2-gtk-3.0 playerctl wireplumber \
  i3lock imagemagick x11-xserver-utils
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

## Themes

Three themes ship with this config:

- `win9x.xml` (default): Windows 9x look — silver `#c0c0c0` chrome, beveled
  "motif" edges, a navy-to-blue active title bar, gray inactive title bars,
  pale-yellow tooltips, and 16px pixel-style buttons (`icons/win9x/`). The task
  bar sits at the bottom with a Start button, a Programs menu, and a Run...
  entry. For the solid Windows 95 title bar, change the active `Background` in
  `themes/win9x.xml` from `#000080:#1084d0` to `#000080`.
- `monolith.xml`: pure grayscale, flat surfaces, hairline borders, a compact
  title bar, and transparent thin-line buttons (`icons/monolith/`).
- `neutral-dark.xml`: slightly warmer blue-gray neutrals with shaded,
  glass-like buttons (`icons/xp/`).

All three include the same style blocks, so swapping themes only needs two lines
in `jwmrc`: the `<Include>` path and the first `<IconPath>` (point it at the
matching icon folder). Then run `./install.sh && jwm -restart`. The Win9x theme
shares one icon file per button for focused and unfocused windows, since Win9x
buttons look the same in both states. To edit the icons, change the SVGs in the
theme's `src/` folder and re-render, for example from `icons/win9x/`:

```sh
rsvg-convert -w 18 -h 18 src/<name>.svg -o <name>.png
```

The Start button flag is rendered at 16x16 instead. The theme uses Liberation
Sans 8 as a stand-in for MS Sans Serif; if you have the real MS fonts installed,
replace `Liberation Sans-8` with `MS Sans Serif-8` in the theme file.

## Notes

- Super/Windows key is the main modifier. `Super+1`/`Super+2` switch desktops,
  `Super+Left`/`Right` snap windows to screen halves, `Super+r` opens rofi,
  `Super+l` locks the screen (same action is in the JWM root menu). Locking
  needs `~/.local/bin/lock-screen.sh` plus `i3lock`, ImageMagick, and `xrandr`.
- Volume/mute/mic-mute media keys are bound in JWM via `wpctl` (PipeWire/
  WirePlumber), which works well with `pasystray`.
- Media play/pause/next/previous keys use `playerctl` (optional dependency).
- Brightness keys use `brightnessctl`; add your user to the `video` group if
  needed.
- Startup tray applets are launched through `~/.local/bin/jwm-autostart.sh`
  with `pgrep` guards to avoid duplicates on JWM restart.
- Global window options include `tiled` and `aerosnap`; adjust the `Group`
  section in `jwmrc` if specific apps need different behavior.
- To try another theme, see the Themes section above; `install.sh` copies every
  theme and icon folder, so no manual file placement is needed.
