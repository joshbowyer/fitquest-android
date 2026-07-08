# FitQuest Android v1.0.36

Tracks parent fitquest repo commits up to 2026-07-08.

## v1.0.36 — 2026-07-08

Version code 36. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): remove the T3 tier cap — full per-branch tier rebalance
- feat(nutrition): nutrition + substance trend charts on /nutrition
- feat(nutrition): /meals/trend + /substances/trend per-day rollup endpoints
- feat(server): one-shot TODO list at /todos + /vitals ingestion endpoint for GB auto-sync
- feat(coach): persist conversations, sliding window, rate limits, LLM compaction
- feat(coach): rich context (workouts/sleep/substances/habits/dailies/nutrition/measurements/PRs/skills) + ScrollToTop
- feat(ai-coach): scaffold /coach page + 5 personality presets + system-prompt seeding

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

### Polish

- chore: bump to v1.0.22 — connector-line icon-center alignment

### Other

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

