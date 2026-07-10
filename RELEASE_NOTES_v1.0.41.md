# FitQuest Android v1.0.41

Tracks parent fitquest repo commits up to 2026-07-10.

## v1.0.41 — 2026-07-10

Version code 41. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): roll out pull-to-refresh to 28 remaining pages
- feat(equipment): wire equipped-item stats + set bonuses into raid damage
- feat(ui): team Live-mode toggle, global modal Close button, notifications bell flyout
- feat(theme): dark/light theme picker + v1.0.39 polish & bug-hunt round 3
- feat(settings): add AI Coach personality picker panel
- feat(calendar): add calories + protein to the day-block BLUF
- feat(notifications): inbox kind glyphs + subtitle
- feat(notifications): inbox expansion — achievements, leaks, bosses, raids, parties
- feat(notifications): shield daily digest at midnight (replaces per-event repair spam)
- feat(today): weigh-in tile in quick-action grid + focused log modal
- feat(morning-popup): mount in Layout + first-interaction trigger + cross-device dismissal

### Bug fixes

- fix(nutrition): default log-meal unit to per-serving when OFF/USDA provide it
- fix(3d-avatar): hardcode light-blue canvas background for both themes
- fix(android): resolve ghost-block WebView compositing bug
- fix(theme): make all chart/gauge colors theme-aware (P0 light-theme item)
- fix(theme): light-mode overhaul (white+neon palette, opaque chrome, readable text) + modal Close on every modal
- fix(team-workout): correct no-show timeout + finalize; fix abandon; bodyfat decimals
- fix(admin): LLM panel subtitle no longer references a non-existent 'quest narrator'
- fix(calendar): weigh-in displays in user's unit system + 'no meals' empty state
- fix(nutrition): plot water on the right axis (same scale as protein)
- fix(morning-popup): weigh-in recap now checks for any WEIGHT on the target day

### Polish

- refactor(coach): move personality picker to /settings + first-time setup flow
- refactor(coach): drop the per-personality admin override concept

### Other

- ci: retry arm64 image build once on transient QEMU crash
- docs(roadmap): reconcile outstanding items, remove 3D avatar shape/mesh scope
- docs(roadmap): credit shipped set-bonus system (v1: raid damage only, v2 deferred items documented)
- docs(roadmap): credit shipped chart/gauge theming + slate-remap (closes P0 light-theme follow-up)
- docs(roadmap): credit shipped dark/light theme toggle (was stale in backlog)
- docs(roadmap): add Stopped Short / Partial Implementations section
- docs(roadmap): v1.0.38 — morning popup + notification expansion changelog

