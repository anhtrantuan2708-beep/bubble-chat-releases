# Bubbo releases

Binary releases and the signed Sparkle feed for **Bubbo**'s local macOS alpha (formerly Bubble Chat).
The product's development repository is private.

## Quick Install (1-Line Terminal Command — Recommended)

Install **Bubbo 0.2.0 (build 285)** directly into `/Applications` with automatic SHA-256 & code-signature verification (no Gatekeeper prompt on first launch):

```bash
curl -fsSL https://raw.githubusercontent.com/anhtrantuan2708-beep/bubble-chat-releases/brian/install.sh | bash
```

## Manual Download (DMG / ZIP)

Current app: **Bubbo 0.2.0, build 285**.

Build 285 introduces the detached Liquid Glass Quick Switcher (`⌘K` / `⌃⌥K`) with borderless Recessed Track network/scope filters, translucent Rising Horizon gradient, and `Actions ⌘K` quick menu; an interactive 1-to-1 Media Photo Carousel with live neighbor peeking, rubber-band boundaries, velocity momentum handoff, and smooth spring keyboard navigation; plus ChatWindow & Timeline polish (full-bleed Liquid Glass GIF tray, compact native connection status pill, borderless selected bubbles, full-width header pill spread fix, eliminated open-chat bounce and hover-selection wipe) — all in a lightweight ~188.5 MiB DMG using a verified on-demand sign-in helper.

[Download the macOS installer (DMG)](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/download/local-alpha-0.2.0-285/Bubbo-0.2.0-build285-arm64.dmg)

Open the DMG and drag **Bubbo 0.2.0** to Applications. Quit any existing copy of Bubble Chat or Bubbo before replacing it. The [release page](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/tag/local-alpha-0.2.0-285) also provides a ZIP and SHA256 checksums.

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
