# Bubbo releases

Binary releases and the signed Sparkle feed for **Bubbo**'s local macOS alpha (formerly Bubble Chat).
The product's development repository is private.

## Quick Install (1-Line Terminal Command — Recommended)

Install **Bubbo 0.2.0 (build 286)** directly into `/Applications` with automatic SHA-256 & code-signature verification (no Gatekeeper prompt on first launch):

```bash
curl -fsSL https://raw.githubusercontent.com/anhtrantuan2708-beep/bubble-chat-releases/brian/install.sh | bash
```

## Manual Download (DMG / ZIP)

Current app: **Bubbo 0.2.0, build 286**.

Build 286 fixes Telegram missing avatars (migrating legacy Telegram avatars to on-demand `direct_media` and raising avatar cache protection), improves Telegram mute sync (global defaults, silent dialogs, Archive folder, and newly opened groups), enforces a unified muted-conversation orbit policy (muted chats and groups stay off floating sub-bubbles — including on initial network connect — until proactively searched and messaged), adds Messenger/Instagram Story Reply badges, Apple Messages-style right-click focus dimming, high-contrast Reply-Jump spotlighting, pasted-image crop/rotate studio, safe file attachment sanitization with click-to-open, and a clearer fresh-install Gatekeeper & Welcome experience.

[Download the macOS installer (DMG)](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/download/local-alpha-0.2.0-286/Bubbo-0.2.0-build286-arm64.dmg)

Open the DMG and drag **Bubbo 0.2.0** to Applications. Quit any existing copy of Bubble Chat or Bubbo before replacing it. The [release page](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/tag/local-alpha-0.2.0-286) also provides a ZIP and SHA256 checksums.

The Facebook/Instagram sign-in browser is downloaded automatically on demand with SHA-256 and code-signature verification when connecting Meta networks. Existing local account data, conversations, drafts, and settings (`local.bubblechat.native`) are preserved across the upgrade.

Requires an Apple Silicon Mac running macOS 14 or newer.
These alpha builds are signed for development and are not notarized.
If macOS blocks first launch after manual DMG installation, either run `xattr -cr "/Applications/Bubbo 0.2.0.app"` in Terminal or use **System Settings → Privacy & Security → Open Anyway**.

The chat runtime runs on the user's Mac; no hosted chat server or Docker is required.
Starting with build 143, Sparkle checks the signed HTTPS feed here for subsequent updates.
Older builds without a feed need one manual installation.

## Feed

https://raw.githubusercontent.com/anhtrantuan2708-beep/bubble-chat-releases/brian/appcast.xml

The feed and release archives are signed using Sparkle Ed25519.
The private signing key stays in the maintainer's macOS Keychain.
