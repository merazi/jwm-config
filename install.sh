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
	"$HOME/.config/volumeicon" \
	"$HOME/.config/rofi" \
	"$HOME/.local/bin" \
	"$HOME/Pictures/Screenshots"

cp -f -- "$repo/jwmrc" "$HOME/.jwmrc"
cp -f -- "$repo/themes/"*.xml "$HOME/.config/jwm/themes/"
cp -Rf -- "$repo/icons/xp/." "$HOME/.config/jwm/icons/xp/"
cp -f -- "$repo/assets/wallpaper.jpg" "$HOME/.config/jwm/wallpaper.jpg"
install -m 755 -- "$repo/extras/screenshot-tool.sh" "$HOME/.local/bin/screenshot-tool.sh"
cp -f -- "$repo/extras/volumeicon" "$HOME/.config/volumeicon/volumeicon"
cp -f -- "$repo/extras/rofi-config.rasi" "$HOME/.config/rofi/config.rasi"

echo "Validating configuration..."
jwm -p

echo "Installed. Apply with: jwm -restart"
