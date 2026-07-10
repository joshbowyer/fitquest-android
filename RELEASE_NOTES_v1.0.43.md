# FitQuest Android v1.0.43

Tracks parent fitquest repo commits up to 2026-07-10.

## v1.0.43 — 2026-07-10

Version code 43. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): roll out pull-to-refresh to 28 remaining pages

### Bug fixes

- fix(workouts): store Workout duration in seconds, not minutes
- fix(api): upsert instead of create on barcode lookup to avoid P2002 crash
- fix(scanner): surface error on empty decode instead of silently closing
- fix(nutrition): default log-meal unit to per-serving when OFF/USDA provide it
- fix(3d-avatar): hardcode light-blue canvas background for both themes
- fix(android): resolve ghost-block WebView compositing bug

### Other

- docs: fix stale README license section (MIT -> GPL-3.0-or-later)
- ci: retry arm64 image build once on transient QEMU crash
- docs(roadmap): reconcile outstanding items, remove 3D avatar shape/mesh scope

