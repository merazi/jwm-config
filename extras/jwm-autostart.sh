#!/usr/bin/env bash
# Autostart tray applets for JWM. Guarded to avoid duplicates on restart.
set -euo pipefail

start_once() {
	local cmd="$1"
	shift
	pgrep -x "$cmd" >/dev/null 2>&1 || "$cmd" "$@" &
}

start_once nm-applet
start_once cbatticon
start_once pasystray
