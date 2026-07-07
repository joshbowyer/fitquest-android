# FitQuest Android v1.0.25

The bug-squash release: a full tsc-triage + logic audit of the codebase
(642 accumulated type errors triaged, ~30 real bugs fixed in two
rounds).

### Crash fixes

- Dashboard tab no longer white-screens (missing hook import)
- Achievements page no longer crashes once data loads
- Nutrition "Add item" modal no longer crashes on open
- Cardio logging no longer crashes when typing a distance
- Insights/correlations + nightly snapshot cron un-broken (out-of-scope
  variable), workout bulk-delete 404s cleanly, USCCB readings fallback
  no longer 500s, quest auto-completion + world-boss first-defeat
  rewards + calisthenics-progress endpoint un-broken (Prisma
  validation crashes)

### Dead features revived

- Weekly Examen modal opens again; Breach "Claim victory" actually
  claims; Android 8 AM morning reminder actually schedules; Casual-mode
  hearts drop + regen again (1/day, visual-only)

### Gameplay correctness

- Heart regen is truly Sunday-anchored (lose Wednesday → back Sunday),
  correct for UTC+ timezones, DST-proof
- No more wrongful "missed all dailies" heart/shield loss when you
  actually logged a workout; morning espresso can't cost yesterday's
  heart
- Levels: levelFromXp factor-4 error fixed (XP bar no longer pinned at
  100%); EVERY reward source now levels you up + respects the Hardcore
  heart multiplier (dailies/habits/quests/bosses/raids/skills)
- Weekly goal + streaks use YOUR local week, not UTC
- Raid HP updates are atomic; victory pays out exactly once; legendary
  loot rolls actually drop legendaries; imperial lb entries no longer
  stored as kg from the Today quick-logger
- Backups now include the full food diary (was silently dropped)

### Security

- /inventory/grant is admin-only; team-workout cleanup + readings
  reseed require auth; stale team sessions now auto-clean via cron
