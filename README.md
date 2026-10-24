# Bubbo releases

Binary releases and the signed Sparkle feed for **Bubbo**'s local macOS alpha (formerly Bubble Chat).
The product's development repository is private.

## Download

Current app: **Bubbo 0.2.0, build 258**.

Build 258 rebrands the app display identity and installer artifacts to **Bubbo**, adds Messenger multi-account support (up to 2 concurrent Facebook Messenger accounts with receiver-bound room routing, account filter, mute, and disconnect controls), and includes optional Bubbo Account sign-in with Pro Early Access, 30% default master audio balance, and larger deforming liquid drag droplets.

[Download the macOS installer (DMG)](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/download/local-alpha-0.2.0-258/Bubbo-0.2.0-build258-arm64.dmg)

Open the DMG and drag **Bubbo 0.2.0** to Applications. Quit any existing copy of Bubble Chat or Bubbo before replacing it. The [release page](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases/tag/local-alpha-0.2.0-258) also provides a ZIP and SHA256 checksums.

The Facebook/Instagram sign-in browser is included in the app; no separate helper installation or download is required. Existing local account data, conversations, drafts, and settings (`local.bubblechat.native`) are preserved across the upgrade to Bubbo.

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
