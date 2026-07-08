# FitQuest Android v1.0.38

Tracks parent fitquest repo commits up to 2026-07-08.

## v1.0.38 — 2026-07-08

Version code 38. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

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
- feat(mobile): horizontal skill tree + long-press multi-select + pull-to-refresh + rest-timer haptic
- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills

### Bug fixes

- fix(fitness-bridge): correct FIT_MONITORING_B type to 16 (was 119)
- fix(fitness-bridge): monitoring FIT files now extract body battery + HRV
- fix(Coach): scroll messages panel to top on initial render, not bottom
- fix(ScrollToTop): target the <main> scrollable, not the window
- fix(auth): degrade gracefully if a /me field's column hasn't been migrated yet
- fix: 4 P1.5 follow-ups from the bug hunt (breach soulstones, unlock response, boss damage cap, DST)
- fix: bug-hunt round 2 — gameplay correctness, security gating, type-safety net
- fix: squash 22 pre-existing bugs found in tsc-triage + logic audit
- fix(ci): tag builds — per-arch suffix on ALL image tags, merge job owns shared tags
- fix(skills): constant icon Y — top-anchor chain nodes + fixed-height name box
- fix(skills): lock SkillNode width so all icon gaps are equal
- fix(skills): actually do the horizontal-tree layout (calitree-style)
- fix(api): re-check prereqs when reading pending-unlocks; expand roadmap
- fix(web): rename new PenanceTemplateRow to avoid clash with existing PenanceRow
- fix(profile+homebase): neck genetic-max regression test + penance panel split
- fix(web+roadmap): move food-panel action buttons below title + tidy roadmap
- fix(web): correct Capacitor plugin name for isPluginAvailable check
- fix(web): re-add @capacitor/barcode-scanner for vite dynamic-import resolution
- fix(web): re-add @zxing deps for web barcode scanner (Android plugin rolled back)
- fix(web): roll back Android-side barcode scanner deps
- fix(web): add @zxing/library peer dep + Workouts.tsx type fixes
- fix(class+skills+nano): tracer evolution fallback, berserker restructure, barcode scanner
- fix(admin): defensive Soulstone[] coercion in case api hasn't been rebuilt
- fix(activities): live workout prefill re-keys once template data loads
- fix(admin): soulstone relation → count, profile class-change uses T1 name
- fix(profile+dashboard): class-change modal uses class name, not evolution stage
- fix(profile+inventory): soulstone UX + class-change button states
- fix(skills): dead-hang icons + HSPU icon mapping
- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks

### Polish

- refactor(web): extract previewMax into shared @/lib/geneticMax
- chore: bump to v1.0.22 — connector-line icon-center alignment

### Other

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
- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped

