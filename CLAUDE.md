# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Is

GestAge is a **Trusted Web Activity (TWA)** Android app — a thin native shell that wraps the PWA hosted at `https://creative-pasca-ce6c82.netlify.app`. There is **no custom Java or Kotlin source code**. All application logic lives in the hosted web app. The Android project exists solely to provide a Play Store-installable package with a native splash screen, app icon, themed status/navigation bars, and deep-link URL association.

## Build Commands

```bash
# Build release APK
./gradlew assembleRelease

# Build release AAB (for Play Store)
./gradlew bundleRelease

# Clean build artifacts
./gradlew clean
```

Outputs land in `app/build/outputs/apk/release/` and `app/build/outputs/bundle/release/`.

The CI workflow (`.github/workflows/main.yml`) runs both on every push to `main` and uploads both artifacts. It requires JDK 17.

## Architecture

The entire app is configured through `app/src/main/AndroidManifest.xml` — there are no Activities to write. The manifest delegates directly to `com.google.androidbrowserhelper.trusted.LauncherActivity` from the `androidbrowserhelper` library, which handles launching the TWA.

Key manifest `<meta-data>` entries control runtime behaviour:
- `DEFAULT_URL` — the PWA entry point (`https://creative-pasca-ce6c82.netlify.app`)
- `STATUS_BAR_COLOR` / `NAVIGATION_BAR_COLOR` — pulled from `@color/colorPrimary`
- `SPLASH_IMAGE_DRAWABLE` / `SPLASH_SCREEN_BACKGROUND_COLOR` — splash screen assets
- `FILE_PROVIDER_AUTHORITY` — wired to `androidx.core.content.FileProvider` for file sharing

The `android:autoVerify="true"` intent filter on the `https://creative-pasca-ce6c82.netlify.app` host is what makes the browser launch the native app instead of Chrome. For TWA verification to work in production the hosted site must serve a valid `/.well-known/assetlinks.json` referencing the app's signing certificate.

## Signing

Release builds are signed with `gestage.keystore` at the repo root. The keystore password, key alias, and key password are hardcoded in `app/build.gradle` (`signingConfigs.release`). Do not rotate or replace this keystore without updating Play Store's signing configuration simultaneously.

## Changing the Hosted URL

To point the app at a different PWA URL, update **both** of these in `AndroidManifest.xml`:
1. `android:support.customtabs.trusted.DEFAULT_URL` meta-data value
2. The `<data android:host="...">` attribute in the `autoVerify` intent filter
