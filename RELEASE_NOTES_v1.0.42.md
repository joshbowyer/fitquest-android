# FitQuest Android v1.0.42

Tracks parent fitquest repo commits up to 2026-07-10.

## v1.0.42 — 2026-07-10

Version code 42. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): roll out pull-to-refresh to 28 remaining pages

### Bug fixes

- fix(scanner): surface error on empty decode instead of silently closing
- fix(nutrition): default log-meal unit to per-serving when OFF/USDA provide it
- fix(3d-avatar): hardcode light-blue canvas background for both themes
- fix(android): resolve ghost-block WebView compositing bug

### Other

- ci: retry arm64 image build once on transient QEMU crash
- docs(roadmap): reconcile outstanding items, remove 3D avatar shape/mesh scope

