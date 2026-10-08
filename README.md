# Bubble Chat releases

Binary releases and the signed Sparkle feed for Bubble Chat's local macOS alpha.
The product's development repository is private.

## Download

Open [Releases](https://github.com/anhtrantuan2708-beep/bubble-chat-releases/releases)
and download the versioned ARM64 ZIP. Extract it and copy **Bubble Chat 0.2.0.app**
to Applications. Quit an existing copy before replacing it.

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
