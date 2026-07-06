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

`scripts/sync-android.sh` keeps the Android release artefacts in
sync with the parent `joshbowyer/fitquest` repo so the wrapper
doesn't go stale. Run it from the parent repo's working tree:

```bash
# Refresh the CHANGELOG.md + RELEASE_NOTES_vX.Y.Z.md for the
# CURRENT version (does not bump). Use this when the parent repo
# shipped commits since the last sync but you want to keep the
# target Android version the same.
cd /path/to/fitquest
./scripts/sync-android.sh

# Auto-bump patch (X.Y.Z → X.Y.(Z+1)) and refresh notes.
BUMP=1 ./scripts/sync-android.sh

# Explicit target version.
NEXT_VERSION=1.0.4 ./scripts/sync-android.sh
```

The script:

1. Reads the current `versionCode` + `versionName` from
   `app/build.gradle`.
2. Walks the parent repo's git log since the last bump (uses the
   author date of the most recent commit that touched
   `app/build.gradle`; override with `SINCE=YYYY-MM-DD`).
3. Categorises commits by conventional-commit prefix
   (`feat:` / `fix:` / `polish:` / etc) and writes a fresh
   `CHANGELOG.md` + `RELEASE_NOTES_vX.Y.Z.md` draft.
4. Bumps `app/build.gradle` in place (unless invoked without
   `BUMP=1` / `NEXT_VERSION`, in which case it just refreshes the
   notes for the current version).

It does NOT run gradle, sign, or publish. The release process
still tags `vX.Y.Z` and uploads the APK as a release asset via
`gh release create`. The release-notes draft is passed as the
release body so the GitHub release gets the same content as
`CHANGELOG.md`:

```bash
gh release create v1.0.3 RELEASE_NOTES_v1.0.3.md \
  app/build/outputs/apk/release/app-release.apk
```