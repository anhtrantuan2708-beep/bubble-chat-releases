#!/usr/bin/env bash
# Bubbo macOS 1-line installer (Apple Silicon / macOS 14+)
# Downloads the latest signed Bubbo release archive, verifies its SHA-256
# checksum and macOS code signature, removes browser quarantine attributes,
# and installs Bubbo into /Applications.
set -euo pipefail

REPO="anhtrantuan2708-beep/bubble-chat-releases"
BRANCH="brian"
INSTALL_DIR="${BUBBO_INSTALL_DIR:-/Applications}"
DRY_RUN=0

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    *)
      echo "Usage: install.sh [--dry-run]" >&2
      exit 2
      ;;
  esac
done

if [[ "$(uname -s)" != "Darwin" || "$(uname -m)" != "arm64" ]]; then
  echo "Error: Bubbo requires an Apple Silicon Mac (arm64) running macOS 14.0 or newer." >&2
  exit 1
fi

macos_major=$(sw_vers -productVersion | cut -d. -f1)
if [[ "$macos_major" -lt 14 ]]; then
  echo "Error: Bubbo requires macOS 14.0 or newer (found $(sw_vers -productVersion))." >&2
  exit 1
fi

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/bubbo-install.XXXXXX")
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT INT TERM

echo "==> Checking latest Bubbo release from $REPO..."
appcast_url="https://raw.githubusercontent.com/$REPO/$BRANCH/appcast.xml"
sums_url="https://raw.githubusercontent.com/$REPO/$BRANCH/SHA256SUMS.txt"

curl -fsSL "$appcast_url" -o "$tmp_dir/appcast.xml"
curl -fsSL "$sums_url" -o "$tmp_dir/SHA256SUMS.txt"

download_url=$(python3 - "$tmp_dir/appcast.xml" <<'PY'
import sys, xml.etree.ElementTree as ET
root = ET.parse(sys.argv[1]).getroot()
enclosure = root.find("./channel/item/enclosure")
if enclosure is None or not enclosure.get("url"):
    raise SystemExit("Could not find release download URL in appcast.xml")
print(enclosure.get("url"))
PY
)

archive_name=$(basename "$download_url")
expected_sha=$(awk -v name="$archive_name" '$2 == name { print $1; exit }' "$tmp_dir/SHA256SUMS.txt")
if [[ -z "$expected_sha" ]]; then
  echo "Error: Checksum for $archive_name not found in SHA256SUMS.txt." >&2
  exit 1
fi

echo "    Latest package: $archive_name"
echo "    Expected SHA256: $expected_sha"

if [[ "$DRY_RUN" == "1" ]]; then
  echo "==> Dry run complete: resolved $download_url"
  exit 0
fi

echo "==> Downloading $archive_name..."
curl -fL --progress-bar "$download_url" -o "$tmp_dir/$archive_name"

actual_sha=$(shasum -a 256 "$tmp_dir/$archive_name" | awk '{print $1}')
if [[ "$actual_sha" != "$expected_sha" ]]; then
  echo "Error: SHA-256 mismatch for $archive_name!" >&2
  echo "  Expected: $expected_sha" >&2
  echo "  Actual:   $actual_sha" >&2
  exit 1
fi
echo "    SHA-256 checksum verified."

echo "==> Extracting application..."
mkdir -p "$tmp_dir/extracted"
ditto -x -k "$tmp_dir/$archive_name" "$tmp_dir/extracted"

app_bundle=$(find "$tmp_dir/extracted" -maxdepth 1 -name "*.app" | head -n 1)
if [[ -z "$app_bundle" || ! -d "$app_bundle" ]]; then
  echo "Error: No .app bundle found inside $archive_name." >&2
  exit 1
fi

app_name=$(basename "$app_bundle")
xattr -cr "$app_bundle" 2>/dev/null || true
codesign --verify --deep --strict "$app_bundle"
echo "    Code signature verified ($app_name)."

echo "==> Installing $app_name to $INSTALL_DIR..."
osascript -e 'tell application id "local.bubblechat.native" to quit' 2>/dev/null || true
sleep 1

rm -rf "$INSTALL_DIR/Bubble Chat 0.2.0.app" "$INSTALL_DIR/$app_name"
ditto "$app_bundle" "$INSTALL_DIR/$app_name"
xattr -cr "$INSTALL_DIR/$app_name" 2>/dev/null || true

echo "==> Launching $app_name..."
open "$INSTALL_DIR/$app_name"
echo "Done! $app_name is installed at $INSTALL_DIR/$app_name."
