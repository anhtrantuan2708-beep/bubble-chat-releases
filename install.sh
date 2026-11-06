#!/usr/bin/env bash
set -euo pipefail

VERSION="0.2.0"
BUILD="281"
APP_NAME="Bubbo 0.2.0.app"
ZIP_URL="https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/download/local-alpha-${VERSION}-${BUILD}/Bubbo-${VERSION}-build${BUILD}-arm64.zip"
EXPECTED_SHA256="02e9d17d301715187e696f310fced8c2203ca84b387ad0d98e956521d1a0ba0c"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Bubbo requires macOS 14.0 (Sonoma) or newer." >&2
  exit 1
fi

TMP_DIR="$(mktemp -d /tmp/bubbo-install.XXXXXX)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

ZIP_PATH="$TMP_DIR/Bubbo-${VERSION}-build${BUILD}-arm64.zip"

printf '\n\033[1;36m🫧 Bubbo %s (build %s) Quick Installer\033[0m\n' "$VERSION" "$BUILD"
printf '==> Downloading Bubbo from GitHub Releases...\n'
curl -fL --progress-bar "$ZIP_URL" -o "$ZIP_PATH"

printf '==> Verifying SHA-256 checksum...\n'
ACTUAL_SHA256="$(shasum -a 256 "$ZIP_PATH" | awk '{print $1}')"
if [[ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]]; then
  echo "Error: SHA-256 mismatch (expected $EXPECTED_SHA256, got $ACTUAL_SHA256)." >&2
  exit 1
fi

printf '==> Installing %s to /Applications...\n' "$APP_NAME"
rm -rf "/Applications/$APP_NAME"
ditto -x -k "$ZIP_PATH" /Applications

printf '\033[1;32m✓ Installed /Applications/%s successfully!\033[0m\n' "$APP_NAME"
printf '==> Launching %s...\n\n' "$APP_NAME"
open "/Applications/$APP_NAME"
