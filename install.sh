#!/usr/bin/env bash
set -euo pipefail

VERSION="0.2.0"
BUILD="282"
APP_NAME="Bubbo 0.2.0.app"
ZIP_URL="https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/download/local-alpha-${VERSION}-${BUILD}/Bubbo-${VERSION}-build${BUILD}-arm64.zip"
EXPECTED_SHA256="37708af29829eac78850806c85404c5032bcdcae240c9f09b64c4fc3050167e6"
TRACK_URL="https://bubbo-cms.pages.dev/api/track"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Bubbo requires macOS 14.0 (Sonoma) or newer." >&2
  exit 1
fi

ARCH="$(uname -m 2>/dev/null || echo unknown)"
OS_VER="$(sw_vers -productVersion 2>/dev/null || echo unknown)"
HARDWARE_UUID="$(ioreg -rd1 -c IOPlatformExpertDevice 2>/dev/null | awk -F\" '/IOPlatformUUID/{print $4; exit}' || true)"
ANON_HASH="$(printf '%s|%s' "${HARDWARE_UUID:-unknown}" "$(hostname 2>/dev/null || echo mac)" | shasum -a 256 | cut -c1-20)"
ANON_ID="inst_${ANON_HASH}"
INSTALL_STEP="init"
INSTALL_DONE=0

bubbo_track() {
  local event_name="$1"
  local meta_json="${2:-"{}"}"
  local sync_mode="${3:-0}"
  if [[ "${BUBBO_SKIP_TELEMETRY:-0}" == "1" || "${BUBBO_DRY_RUN:-0}" == "1" ]]; then
    return 0
  fi
  local payload
  payload=$(printf '{"anonId":"%s","event":"%s","source":"installer","referrerSource":"direct","appVersion":"%s","osVersion":"%s","arch":"%s","meta":%s}' \
    "$ANON_ID" "$event_name" "$VERSION" "$OS_VER" "$ARCH" "$meta_json")
  if [[ "$sync_mode" == "1" ]]; then
    curl -fsS -m 2 -X POST "$TRACK_URL" -H "Content-Type: application/json" -d "$payload" >/dev/null 2>&1 || true
  else
    (curl -fsS -m 2 -X POST "$TRACK_URL" -H "Content-Type: application/json" -d "$payload" >/dev/null 2>&1 || true) &
  fi
}

bubbo_track "install_started" "{}" 0

if [[ "$ARCH" != "arm64" ]]; then
  bubbo_track "install_failed" '{"reason":"unsupported_arch"}' 1
  echo "Bubbo ${VERSION} currently requires an Apple Silicon Mac (M1/M2/M3/M4)." >&2
  exit 1
fi

TMP_DIR="$(mktemp -d /tmp/bubbo-install.XXXXXX)"
cleanup() {
  local exit_code=$?
  rm -rf "$TMP_DIR"
  if [[ "$exit_code" -ne 0 && "$INSTALL_DONE" -eq 0 ]]; then
    bubbo_track "install_failed" "{\"step\":\"${INSTALL_STEP}\"}" 1
  fi
}
trap cleanup EXIT INT TERM

ZIP_PATH="$TMP_DIR/Bubbo-${VERSION}-build${BUILD}-arm64.zip"

printf '\n\033[1;36m🫧 Bubbo %s (build %s) Quick Installer\033[0m\n' "$VERSION" "$BUILD"
printf '==> Downloading Bubbo from GitHub Releases...\n'
INSTALL_STEP="download"
curl -fL --progress-bar "$ZIP_URL" -o "$ZIP_PATH"

printf '==> Verifying SHA-256 checksum...\n'
INSTALL_STEP="checksum"
ACTUAL_SHA256="$(shasum -a 256 "$ZIP_PATH" | awk '{print $1}')"
if [[ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]]; then
  echo "Error: SHA-256 mismatch (expected $EXPECTED_SHA256, got $ACTUAL_SHA256)." >&2
  exit 1
fi

printf '==> Installing %s to /Applications...\n' "$APP_NAME"
INSTALL_STEP="extract"
rm -rf "/Applications/$APP_NAME"
ditto -x -k "$ZIP_PATH" /Applications
xattr -dr com.apple.quarantine "/Applications/$APP_NAME" 2>/dev/null || true

INSTALL_DONE=1
bubbo_track "install_succeeded" "{}" 1

printf '\033[1;32m✓ Installed /Applications/%s successfully!\033[0m\n' "$APP_NAME"
printf '==> Launching %s...\n\n' "$APP_NAME"
open "/Applications/$APP_NAME"
