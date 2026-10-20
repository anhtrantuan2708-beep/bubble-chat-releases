# Bubble Chat releases

Binary releases and the signed Sparkle feed for Bubble Chat's local macOS alpha.
The product's development repository is private.

## Download

Current app: **Bubble Chat 0.2.0, build248**.

Build248 adds file attachments, drag-to-expand recipient bubbles, edge unread counts,
Instagram conversation links and a soft suction sound when the mascot tucks into an edge.
The current textured mascot is included.

[Download the macOS installer (DMG)](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/download/local-alpha-0.2.0-248/Bubble-Chat-0.2.0-build248-arm64.dmg)

Open the DMG and drag **Bubble Chat 0.2.0** to Applications. Quit an existing copy
before replacing it. The [release page](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/tag/local-alpha-0.2.0-248)
also provides a ZIP and SHA256 checksums.

The Facebook/Instagram sign-in browser is included in the app; no separate helper
installation or download is required. Builds149–232 that used an on-demand browser
should update to the current build before first sign-in. Existing local account data is preserved.

Requires an Apple Silicon Mac running macOS 14 or newer.
These alpha builds are signed for development and are not notarized.
If macOS blocks first launch, use System Settings → Privacy & Security → Open Anyway.

The chat runtime runs on the user's Mac; no hosted chat server or Docker is required.
Starting with build 143, Sparkle checks the signed HTTPS feed here for subsequent updates.
Older builds without a feed need one manual installation.

## Feed

https://raw.githubusercontent.com/anhtrantuan2708-beep/bubble-chat-releases/brian/appcast.xml

The feed and release archives are signed using Sparkle Ed25519.
The private signing key stays in the maintainer's macOS Keychain.
