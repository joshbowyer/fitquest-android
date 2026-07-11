# FitQuest Android v1.0.44

Tracks parent fitquest repo commits up to 2026-07-11.

## v1.0.44 — 2026-07-11

Version code 44. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): PHANTOM deluxe expansion + shared-canvas skill tree rendering

### Bug fixes

- fix(workouts): store Workout duration in seconds, not minutes
- fix(api): upsert instead of create on barcode lookup to avoid P2002 crash
- fix(scanner): surface error on empty decode instead of silently closing
- fix(nutrition): default log-meal unit to per-serving when OFF/USDA provide it

### Other

- docs: fix stale README license section (MIT -> GPL-3.0-or-later)

