#!/usr/bin/env bash
# Install this JWM configuration into $HOME. Safe to re-run after `git pull`.
set -euo pipefail

repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Keep a timestamped rollback copy; never clobber an existing backup.
if [[ -f "$HOME/.jwmrc" ]]; then
	backup="$HOME/.jwmrc.bak.$(date +%Y%m%d-%H%M%S)"
	cp -f -- "$HOME/.jwmrc" "$backup"
	echo "Backed up current config to $backup"
fi

mkdir -p -- \
	"$HOME/.config/jwm/themes" \
	"$HOME/.config/jwm/icons/xp" \
	"$HOME/.config/rofi" \
	"$HOME/.local/bin" \
	"$HOME/Pictures/Screenshots"

cp -f -- "$repo/jwmrc" "$HOME/.jwmrc"
cp -f -- "$repo/themes/"*.xml "$HOME/.config/jwm/themes/"
# Copy every icon set (one folder per theme) plus the shared SVG sources.
cp -Rf -- "$repo/icons/." "$HOME/.config/jwm/icons/"
cp -f -- "$repo/assets/wallpaper.jpg" "$HOME/.config/jwm/wallpaper.jpg"
install -m 755 -- "$repo/extras/jwm-autostart.sh" "$HOME/.local/bin/jwm-autostart.sh"
install -m 755 -- "$repo/extras/screenshot-tool.sh" "$HOME/.local/bin/screenshot-tool.sh"
cp -f -- "$repo/extras/rofi-config.rasi" "$HOME/.config/rofi/config.rasi"

echo "Validating configuration..."
jwm -p

echo "Installed."
if [[ -t 0 ]]; then
	read -r -p "Restart JWM now? [y/N] " answer || answer=""
	case "$answer" in
		[yY]|[yY][eE][sS])
			jwm -restart
			;;
		*)
			echo "Restart later with: jwm -restart"
			;;
	esac
else
	echo "Restart later with: jwm -restart"
fi
