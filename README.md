# FitQuest Android

Capacitor 6 Android wrapper for the FitQuest web app. Bundles the
web build output into a signed Android APK that loads the web app
inside a `https://localhost` WebView.

## What this repo is

This is just the native Android shell — the web app source lives
in the separate [`joshbowyer/fitquest`](https://github.com/joshbowyer/fitquest)
repo (under `web/`). The build flow is:

1. From `joshbowyer/fitquest/web/`:
   - `npm run build` → produces `web/dist/`
   - `npx cap sync android` → copies `dist/` into this repo's
     `app/src/main/assets/public/` (the `android.path` in
     `web/capacitor.config.ts` points here)
2. From this repo:
   - `./gradlew assembleRelease` → produces
     `app/build/outputs/apk/release/app-release-unsigned.apk`
   - sign with `apksigner` using the debug keystore
     (`~/.android/debug.keystore`) — or a real release keystore
     once you have one configured

## Build it

```bash
# 1. Build + sync the web bundle (run from the fitquest repo)
cd /path/to/fitquest/web
npm run build
npx cap sync android

# 2. Build the release APK (run from this repo)
cd /path/to/fitquest-android
./gradlew assembleRelease

# 3. Sign + zipalign
APK=app/build/outputs/apk/release/app-release-unsigned.apk
$ANDROID_HOME/build-tools/34.0.0/zipalign -v -p 4 "$APK" "${APK%.apk}-aligned.apk"
$ANDROID_HOME/build-tools/34.0.0/apksigner sign \
  --ks ~/.android/debug.keystore \
  --ks-key-alias androiddebugkey \
  --ks-pass pass:android \
  --key-pass pass:android \
  --out app/build/outputs/apk/release/app-release.apk \
  "${APK%.apk}-aligned.apk"

# 4. Install
adb install -r app/build/outputs/apk/release/app-release.apk
```

Override the android path with `CAPACITOR_ANDROID_PATH` env var
when running `cap sync` from a different checkout root.

## Triangle launcher icon

Generated from `../fitquest/web/public/favicon.svg` (the
cyan→magenta-gradient triangle on dark navy). See
`../fitquest/scripts/render-app-icons.py`. Re-run from the
fitquest repo whenever the SVG changes:

```bash
python3 /path/to/fitquest/scripts/render-app-icons.py
```

The script writes into both this repo's `app/src/main/res/`
and `../fitquest-bridge/app/src/main/res/`.

## Versioning

Edit `app/build.gradle` — `versionCode` + `versionName`. The
release process tags `vX.Y.Z` and uploads the APK as a release
asset via `gh release create`.