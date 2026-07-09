# FitQuest Android v1.0.40

Tracks parent fitquest repo commits up to 2026-07-09.

## v1.0.40 — 2026-07-09

Version code 40. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): roll out pull-to-refresh to 28 remaining pages
- feat(equipment): wire equipped-item stats + set bonuses into raid damage
- feat(ui): team Live-mode toggle, global modal Close button, notifications bell flyout

### Bug fixes

- fix(3d-avatar): hardcode light-blue canvas background for both themes
- fix(android): resolve ghost-block WebView compositing bug
- fix(theme): make all chart/gauge colors theme-aware (P0 light-theme item)
- fix(theme): light-mode overhaul (white+neon palette, opaque chrome, readable text) + modal Close on every modal
- fix(team-workout): correct no-show timeout + finalize; fix abandon; bodyfat decimals

### Other

- docs(roadmap): reconcile outstanding items, remove 3D avatar shape/mesh scope
- docs(roadmap): credit shipped set-bonus system (v1: raid damage only, v2 deferred items documented)
- docs(roadmap): credit shipped chart/gauge theming + slate-remap (closes P0 light-theme follow-up)
- docs(roadmap): credit shipped dark/light theme toggle (was stale in backlog)

