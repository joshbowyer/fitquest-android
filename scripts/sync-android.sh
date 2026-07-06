#!/usr/bin/env bash
#
# sync-android.sh — bumps fitquest-android's version + writes a
# CHANGELOG entry + release-notes draft from the parent fitquest
# repo's recent web/api git log.
#
# Run from this repo (fitquest-android). The script:
#   1. Reads the current versionCode + versionName from app/build.gradle.
#   2. Reads the parent fitquest repo's git log since the last bump.
#      (Default: since the most recent commit that touched
#      app/build.gradle. Override with `SINCE=<ref>`.)
#   3. Bumps versionCode by 1 and versionName to next SemVer patch
#      (or whatever is passed as NEXT_VERSION env var).
#   4. Writes a CHANGELOG.md section + a RELEASE_NOTES_<v>.md draft
#      so `gh release create vX.Y.Z RELEASE_NOTES_X.Y.Z.md
#      app-release.apk` is a one-liner.
#
# DOES NOT run gradle, sign, or publish — that's still manual (the
# user said don't build the apk yet). The script just makes sure
# fitquest-android doesn't get stale when the parent repo ships
# changes.
#
# Usage:
#   scripts/sync-android.sh                  # auto-bump patch, auto-detect parent repo
#   NEXT_VERSION=1.0.4 scripts/sync-android.sh
#   PARENT_REPO=/path/to/fitquest scripts/sync-android.sh

set -euo pipefail

# Locate parent repo (default: ../fitquest, but our checkout is
# actually /home/josh/claw-code/FitnessStats). Allow override.
PARENT_REPO="${PARENT_REPO:-$(cd ../FitnessStats 2>/dev/null && pwd || cd ../fitquest 2>/dev/null && pwd || echo "")}"
if [[ -z "$PARENT_REPO" || ! -d "$PARENT_REPO" ]]; then
  echo "ERROR: Could not find parent fitquest repo. Set PARENT_REPO=/path/to/fitquest." >&2
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_GRADLE="$REPO_ROOT/app/build.gradle"
CHANGELOG="$REPO_ROOT/CHANGELOG.md"

if [[ ! -f "$BUILD_GRADLE" ]]; then
  echo "ERROR: $BUILD_GRADLE not found." >&2
  exit 1
fi

# Read current version from app/build.gradle. Format is:
#   versionCode 3
#   versionName "1.0.3"
CUR_CODE=$(grep -E '^\s*versionCode\s+' "$BUILD_GRADLE" | head -1 | awk '{print $NF}')
CUR_NAME=$(grep -E '^\s*versionName\s+' "$BUILD_GRADLE" | head -1 | sed -E 's/.*"([^"]+)".*/\1/')

if [[ -z "$CUR_CODE" || -z "$CUR_NAME" ]]; then
  echo "ERROR: could not parse versionCode/versionName from $BUILD_GRADLE" >&2
  exit 1
fi

# Compute next version. Two modes:
#   1. NEXT_VERSION=X.Y.Z given → use that, with explicit code bump.
#   2. BUMP=1 → auto-bump patch (X.Y.Z → X.Y.(Z+1)) and code by 1.
#   3. Neither → regenerate notes for the CURRENT version (the user
#      already set the target version in app/build.gradle, they just
#      want fresh CHANGELOG + release-notes). NEXT_CODE stays put.
NEXT_CODE="$CUR_CODE"
NEXT_NAME="${NEXT_VERSION:-}"
if [[ -z "$NEXT_NAME" ]]; then
  if [[ "${BUMP:-0}" == "1" ]]; then
    # Bump the patch component of CUR_NAME (X.Y.Z → X.Y.(Z+1)).
    # Use shell parameter expansion rather than awk — awk treats
    # "." as a field separator and broke SemVer strings into
    # ("1" "0" "4") so the bumped output was "1 0 4" (with
    # spaces). Truncate on the first '.' from the right, then
    # replace the prefix with `${prefix}.${bumped_patch}`.
    prefix="${CUR_NAME%.*}"
    patch="${CUR_NAME##*.}"
    NEXT_NAME="${prefix}.$((patch + 1))"
    NEXT_CODE=$((CUR_CODE + 1))
  else
    NEXT_NAME="$CUR_NAME"
  fi
fi

# Date for the changelog entry
DATE_ISO=$(date -u +"%Y-%m-%d")

# Discover the "since" date for git log range. Strategy:
#   1. If SINCE_DATE is given (or SINCE is a YYYY-MM-DD string), use it.
#   2. Otherwise use the commit date of the most recent change to
#      app/build.gradle in THIS repo. That's "when we last bumped",
#      so anything in the parent repo after that date is fair game.
#   3. Fallback: last 14 days.
SINCE_DATE="${SINCE_DATE:-${SINCE:-}}"
if [[ -z "$SINCE_DATE" ]]; then
  SINCE_DATE=$(cd "$REPO_ROOT" && git log -1 --format="%cs" -- app/build.gradle 2>/dev/null || echo "")
fi
if [[ -z "$SINCE_DATE" ]]; then
  SINCE_DATE=$(date -u -d '14 days ago' +"%Y-%m-%d" 2>/dev/null || date -u -v-14d +"%Y-%m-%d" 2>/dev/null || echo "")
fi

# git log --since uses STRICT GREATER THAN semantics. To include
# commits dated ON the bump day (which is what users expect when
# they say "everything since the last bump"), back off by one day.
if [[ -n "$SINCE_DATE" ]]; then
  SINCE_DATE_BUFFERED=$(date -u -d "$SINCE_DATE - 1 day" +"%Y-%m-%d" 2>/dev/null || date -u -v-1d -j -f "%Y-%m-%d" "$SINCE_DATE" +"%Y-%m-%d" 2>/dev/null || echo "$SINCE_DATE")
else
  SINCE_DATE_BUFFERED=""
fi

# Get parent-repo log since SINCE_DATE_BUFFERED. We use a date
# range, not a ref range, because the parent repo's history doesn't
# share refs with this repo's commits.
if [[ -n "$SINCE_DATE_BUFFERED" ]]; then
  LOG_RANGE="--since=$SINCE_DATE_BUFFERED"
  LOG_SECTION_TITLE="Changes since $SINCE_DATE (last Android bump)"
else
  LOG_RANGE="-n 30"
  LOG_SECTION_TITLE="Last 30 parent-repo commits"
fi

# Pull the log lines. Group by conventional-commit scope (feat/fix/etc).
# If the commit msg has no conventional-commit prefix, it goes in "other".
LOG=$(cd "$PARENT_REPO" && git log $LOG_RANGE --pretty=format:'%h %s' 2>/dev/null | head -100 || echo "")

# Categorise. Very rough — just buckets lines whose first word after the
# hash matches a conventional prefix. Anything else goes into "other".
FEAT_LINES=()
FIX_LINES=()
POLISH_LINES=()
OTHER_LINES=()
while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  msg=$(echo "$line" | sed -E 's/^[0-9a-f]+ //')
  case "$msg" in
    feat*)   FEAT_LINES+=("$msg") ;;
    fix*)    FIX_LINES+=("$msg") ;;
    polish*|refactor*|chore*) POLISH_LINES+=("$msg") ;;
    *)       OTHER_LINES+=("$msg") ;;
  esac
done <<< "$LOG"

# Build the CHANGELOG entry.
ENTRY="## v$NEXT_NAME — $DATE_ISO\n\nVersion code $NEXT_CODE. Tracks the parent\nfitquest repo (web + api). Run from fitquest-android after the parent\nrepo has shipped changes.\n\n"
if (( ${#FEAT_LINES[@]} > 0 )); then
  ENTRY+="### Features\n\n"
  for l in "${FEAT_LINES[@]}"; do ENTRY+="- $l\n"; done
  ENTRY+="\n"
fi
if (( ${#FIX_LINES[@]} > 0 )); then
  ENTRY+="### Bug fixes\n\n"
  for l in "${FIX_LINES[@]}"; do ENTRY+="- $l\n"; done
  ENTRY+="\n"
fi
if (( ${#POLISH_LINES[@]} > 0 )); then
  ENTRY+="### Polish\n\n"
  for l in "${POLISH_LINES[@]}"; do ENTRY+="- $l\n"; done
  ENTRY+="\n"
fi
if (( ${#OTHER_LINES[@]} > 0 )); then
  ENTRY+="### Other\n\n"
  for l in "${OTHER_LINES[@]}"; do ENTRY+="- $l\n"; done
  ENTRY+="\n"
fi

# Write CHANGELOG.md (prepend — keep older entries below).
TMPFILE=$(mktemp)
{
  printf "# Changelog\n\n"
  printf "%b" "$ENTRY"
  if [[ -f "$CHANGELOG" ]]; then
    # Skip the old "## v..." blocks (they're at the top of the
    # current CHANGELOG already; we just want to preserve them).
    # If no existing CHANGELOG, we just wrote the entry.
    tail -n +3 "$CHANGELOG" 2>/dev/null || true
  fi
} > "$TMPFILE"
mv "$TMPFILE" "$CHANGELOG"

# Write the release-notes draft (consumed by `gh release create`).
NOTES_FILE="$REPO_ROOT/RELEASE_NOTES_v$NEXT_NAME.md"
{
  printf "# FitQuest Android v$NEXT_NAME\n\n"
  printf "Tracks parent fitquest repo commits up to %s.\n\n" "$DATE_ISO"
  printf "%b" "$ENTRY"
} > "$NOTES_FILE"

# Bump app/build.gradle in-place.
sed -i.bak -E "s/^([[:space:]]*versionCode[[:space:]]+)[0-9]+/\1$NEXT_CODE/" "$BUILD_GRADLE"
sed -i.bak -E "s/^([[:space:]]*versionName[[:space:]]+\")[^\"]+(\")/\1$NEXT_NAME\2/" "$BUILD_GRADLE"
rm -f "$BUILD_GRADLE.bak"

echo
echo "✓ Bumped $CUR_NAME (code $CUR_CODE) → $NEXT_NAME (code $NEXT_CODE)"
echo "  CHANGELOG.md updated."
echo "  Release notes draft: $NOTES_FILE"
echo
echo "Next steps (manual):"
echo "  1. From the parent fitquest repo:"
echo "       cd $PARENT_REPO/web && npm run build && npx cap sync android"
echo "  2. From this repo:"
echo "       ./gradlew assembleRelease"
echo "       zipalign + apksigner (see README.md)"
echo "  3. Commit + tag + push:"
echo "       git add -A && git commit -m \"chore: bump to v$NEXT_NAME\""
echo "       git tag v$NEXT_NAME && git push && git push --tags"
echo "  4. Publish to GitHub Releases:"
echo "       gh release create v$NEXT_NAME $NOTES_FILE app/build/outputs/apk/release/app-release.apk"