# FitQuest Android v1.0.39

Tracks parent fitquest repo commits up to 2026-07-09.

## v1.0.39 — 2026-07-09

Version code 39. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

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
- feat(notifications): inbox page + top-bar unread badge (frontend)
- feat(notifications): persistent notification feed (backend)
- feat(nutrition): nutrition trend chart is now a multi-toggle (all-on)
- feat(skills): remove the T3 tier cap — full per-branch tier rebalance
- feat(nutrition): nutrition + substance trend charts on /nutrition
- feat(nutrition): /meals/trend + /substances/trend per-day rollup endpoints
- feat(server): one-shot TODO list at /todos + /vitals ingestion endpoint for GB auto-sync
- feat(coach): persist conversations, sliding window, rate limits, LLM compaction
- feat(coach): rich context (workouts/sleep/substances/habits/dailies/nutrition/measurements/PRs/skills) + ScrollToTop
- feat(ai-coach): scaffold /coach page + 5 personality presets + system-prompt seeding

### Bug fixes

- fix(theme): make all chart/gauge colors theme-aware (P0 light-theme item)
- fix(theme): light-mode overhaul (white+neon palette, opaque chrome, readable text) + modal Close on every modal
- fix(team-workout): correct no-show timeout + finalize; fix abandon; bodyfat decimals
- fix(admin): LLM panel subtitle no longer references a non-existent 'quest narrator'
- fix(calendar): weigh-in displays in user's unit system + 'no meals' empty state
- fix(nutrition): plot water on the right axis (same scale as protein)
- fix(morning-popup): weigh-in recap now checks for any WEIGHT on the target day
- fix(fitness-bridge): correct FIT_MONITORING_B type to 16 (was 119)
- fix(fitness-bridge): monitoring FIT files now extract body battery + HRV
- fix(Coach): scroll messages panel to top on initial render, not bottom
- fix(ScrollToTop): target the <main> scrollable, not the window
- fix(auth): degrade gracefully if a /me field's column hasn't been migrated yet
- fix: 4 P1.5 follow-ups from the bug hunt (breach soulstones, unlock response, boss damage cap, DST)
- fix: bug-hunt round 2 — gameplay correctness, security gating, type-safety net
- fix: squash 22 pre-existing bugs found in tsc-triage + logic audit

### Polish

- refactor(coach): move personality picker to /settings + first-time setup flow
- refactor(coach): drop the per-personality admin override concept
- refactor(web): extract previewMax into shared @/lib/geneticMax

### Other

- docs(roadmap): credit shipped set-bonus system (v1: raid damage only, v2 deferred items documented)
- docs(roadmap): credit shipped chart/gauge theming + slate-remap (closes P0 light-theme follow-up)
- docs(roadmap): credit shipped dark/light theme toggle (was stale in backlog)
- docs(roadmap): add Stopped Short / Partial Implementations section
- docs(roadmap): v1.0.38 — morning popup + notification expansion changelog
- docs(roadmap): v1.0.37 — notification feed, chart toggle, geneticMax refactor, sync-android fix
- docs(roadmap): v1.0.36 changelog — nutrition trends + skill tier rebalance
- docs(roadmap): v1.0.34 changelog — FIT type 16 fix + unique constraint + body battery note
- docs(roadmap): v1.0.33 changelog — body battery + HRV fix
- docs(roadmap): v1.0.32 changelog — coach messages panel scroll-to-top on entry
- docs(roadmap): v1.0.31 changelog — scroll-to-top hotfix
- docs(roadmap): v1.0.30 changelog — coach persistence + sliding window + rate limits + LLM compaction
- docs(roadmap): v1.0.29 changelog — scroll-to-top + richer coach context
- docs(roadmap): v1.0.28 /me resilience + prisma migrate deploy runbook
- docs(roadmap): v1.0.27 changelog + close AI coach P2 entry
- docs(roadmap): v1.0.26 changelog + close out the 4 P1.5 follow-ups
- docs(roadmap): 2026-07-07 bug-hunt session — changelog, ops refresh, stale-item cleanup

