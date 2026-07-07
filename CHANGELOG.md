# Changelog

## v1.0.31 — 2026-07-07

Version code 31. Tracks the parent fitquest repo (web + api).

### Hotfix

- **ScrollToTop actually scrolls now.** v1.0.29's version called
  `window.scrollTo(0, 0)`, but Layout's scrollable surface is
  `<main className="... overflow-y-auto">` — the window isn't
  scrollable. This version targets `<main>` via querySelector
  (window fallback only for the rare pre-mount case). Also fires
  on initial mount with a requestAnimationFrame defer so the
  scroll wins the race against the browser's scroll restoration
  on back/forward and hard reload.

## v1.0.30 — 2026-07-07

Version code 30. Tracks the parent fitquest repo (web + api).

### Improvements: AI Coach persistence + limits + compaction

Closes the v1.1 scope from the design discussion. The Coach
now remembers you between visits, throttles abuse, and stays
bounded as the conversation grows.

- **Conversation persistence.** One rolling conversation per
  user, persisted in `CoachConversation` + `CoachMessage`. Close
  the browser, come back tomorrow — the chat is still there.
  GET /coach/messages hydrates on page load; new sends invalidate
  the query. Clear button in the panel header wipes the convo
  but preserves the personality choice.
- **Rate limits.** 5 messages / 1 min (burst, anti-spam) +
  50 messages / 24h (cost cap). In-memory per-user token bucket,
  same pattern as the existing auth rate limiter. Returns 429
  with Retry-After; UI shows a friendly retry hint.
- **Sliding window (last 20).** The LLM only sees the most
  recent 20 messages per request; older turns are either folded
  into a summary or dropped, so the prompt stays bounded.
- **LLM summary compaction.** When messageCount crosses 30, a
  fire-and-forget LLM call summarizes the oldest 10 turns and
  stores the result on the conversation. Future prompts
  prepend a "Summary of earlier conversation" block so the
  coach remembers your goals / programs / PRs past the sliding
  window.
- **Page header chips.** Message count + "summarized" badge so
  the user can see the conversation state at a glance.
- **Better LLM error UX.** "thinking…" bubble during the call;
  friendly messages for 429 / 502 / 422 instead of raw errors.

## v1.0.29 — 2026-07-07

Version code 29. Tracks the parent fitquest repo (web + api).

### Improvements

- **Scroll-to-top on every sidebar nav.** Long pages used to
  load scrolled to the bottom (the previous page's scroll
  position persisted); now every route change scrolls to top.
  Hash deep-links (`#class`, `#anchor`) still work.
- **AI Coach context expanded ~3-4×.** Was: hearts / streak /
  7d workout count / avg sleep / today recovery (~500 tokens).
  Now: last 5 workouts with exercise names + top sets + total
  sets + duration; per-night sleep for 7 local days; substance
  counts broken down (caffeine today, caffeine/alcohol/nicotine/
  electrolyte this week); latest weight + body fat + 14-day
  weight trend; last 5 habit logs + 7d pos/neg counts; yesterday's
  dailies + 7d completion rate; today's nutrition totals
  (cal/protein/carb/fat/meal count) + yesterday's calories; last
  5 PRs; pending skill unlocks. The Coach page sidebar now
  shows a "Coach also sees" section so you can sanity-check
  what data is available.

## v1.0.28 — 2026-07-07

Version code 28. Tracks the parent fitquest repo (web + api).

### Bug fix

- **/me endpoint now degrades gracefully on a missing-column
  migration mismatch.** When the v1.0.27 /coach migration was
  applied to schema + types but not yet to the live database,
  every `/auth/me` call threw `PrismaClient P2022` and the web
  treated it as a session failure — every user was kicked to
  /login for ~25 minutes. `publicUser()` now wraps new
  field-reads in `safeReadField()` so a missing column
  degrades to `null` instead of 500-ing the whole endpoint.

## v1.0.27 — 2026-07-07

Version code 27. Tracks the parent fitquest repo (web + api).

### New feature: AI Coach

A new `/coach` page (nav icon ✺) with a personality selector and
chat interface. The system prompt is composed from a shared
preamble + a per-personality voice block + FitQuest world context.
Uses the system default LLM (`minimax-m3`).

**5 personality presets:**

- **Priest Bodybuilder** — Catholic/monastic imagery + hypertrophy.
  The default FitQuest voice. New users get this until they pick.
- **Drill Sergeant** — direct, no-nonsense, discipline-focused.
- **Bob Ross** — soft, affirming, never negative. "Happy little sets."
- **Zoomer (Zyzz bro)** — gym-bro subculture, aesthetic, memes.
- **Generic** — polite neutral AI health assistant. Safe default.

**Other notes:**

- Schema: new `CoachPersonality` enum + `User.coachPersonality`
  nullable column. Migration applied automatically on api startup.
- Conversation is local-state (no server history yet — resets on
  page reload; future iteration will persist).
- Admin-side per-personality prompt overrides deferred to a
  follow-up roadmap item (`LlmConfig.coachSystemPromptOverrides`).
- If the admin hasn't configured the LLM yet, the page renders a
  disabled input — `GET /coach` returns the meta fine, `POST
  /coach` returns 422 until the admin enables the LLM.

## v1.0.26 — 2026-07-07

Version code 26. Tracks the parent fitquest repo (web + api).

Four P1.5 follow-ups from the bug-hunt session — none UI-reshaping,
all correctness.

### Bug fixes

- **Breach kills now actually drop Soulstones.** The victory modal
  advertised 1–12 stones per kill (per tier) but the old
  UserBreachProgress counter column was dropped in 021082d, so
  the writes were throwing PrismaClientValidationError on every
  claim. Now rolled Soulstones create real 24h-TTL rows in a
  transaction with the gold/xp increment.
- **Skill unlock toast no longer lies.** Previously it showed
  the raw bonus ("+50 XP") even when the 0-heart Hardcore
  multiplier paid out ×0. The response now reports the actual
  granted amount; bonus/multiplier are included for any UI that
  wants both.
- **World-boss manual damage capped at 25%/request.** A malicious
  client could one-shot a boss by sending the schema max with a
  1.3× class mult. Authoritative damage still flows through the
  workout-commit hook.
- **DST micro-issues fixed** (one night/year each): sleep onset
  at 00:30 on spring-forward day no longer buckets a day too
  far back; weigh-in + metric streaks no longer drop to 0 on
  the 25h fall-back day.

## v1.0.25 — 2026-07-07

Version code 25. Tracks the parent fitquest repo (web + api).

Bug-squash release: a full tsc-triage + logic audit of the codebase
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
## v1.0.24 — 2026-07-07

Version code 24. Tracks the parent fitquest repo (web + api).

### Bug fixes

- fix(skills): skill-tree icons finally share one Y — root cause was
  1-line vs 2-line skill names making button heights differ, so the
  `items-center` chain wrapper pushed short buttons ~4px down inside the
  stretched row. Nodes are now top-anchored, the name label is a fixed
  2-line box (every button exactly 100px), and the connector is pinned
  at the icon center (y=44) measured from the top.
- fix(skills): hand-coded SVG icons now render at 28px like the calitree
  PNG masks (were 24px — icons looked different sizes between branches)
- fix(ci): parent-repo v* tag image builds no longer fail at the
  manifest-merge step; :main and :latest are now proper multi-arch tags

## v1.0.23 — 2026-07-07

Version code 23. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): horizontal skill tree + long-press multi-select + pull-to-refresh + rest-timer haptic
- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend

### Polish

- chore: bump to v1.0.22 — connector-line icon-center alignment

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2

## v1.0.22 — 2026-07-07

Version code 22. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): horizontal skill tree + long-press multi-select + pull-to-refresh + rest-timer haptic
- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note

## v1.0.21 — 2026-07-07

Version code 21. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): horizontal skill tree + long-press multi-select + pull-to-refresh + rest-timer haptic
- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note

## v1.0.20 — 2026-07-07

Version code 20. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): horizontal skill tree + long-press multi-select + pull-to-refresh + rest-timer haptic
- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.19 — 2026-07-07

Version code 19. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): horizontal skill tree + long-press multi-select + pull-to-refresh + rest-timer haptic
- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.18 — 2026-07-06

Version code 18. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(mobile): horizontal skill tree + long-press multi-select + pull-to-refresh + rest-timer haptic
- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.17 — 2026-07-06

Version code 17. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.16 — 2026-07-06

Version code 16. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): add explicit per-skill prereqs to JUGGERNAUT, TRACER, ORACLE
- feat(skills): add explicit per-skill prereqs to BERSERKER (7 branches × 45 skills)
- feat(skills): add explicit per-skill prereqs to SCOUT (3 branches × 20 skills)
- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal

### Other

- docs(roadmap): skill tree prereq treatment — all 6 classes done
- docs(roadmap): mark SCOUT + BERSERKER as having explicit per-skill prereqs
- docs(roadmap): mark 4 of 5 P0 quick wins as shipped
- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.15 — 2026-07-06

Version code 15. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.14 — 2026-07-06

Version code 14. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.13 — 2026-07-06

Version code 13. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary

### Bug fixes

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
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.12 — 2026-07-06

Version code 12. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages

### Bug fixes

- fix(admin): defensive Soulstone[] coercion in case api hasn't been rebuilt
- fix(activities): live workout prefill re-keys once template data loads
- fix(admin): soulstone relation → count, profile class-change uses T1 name
- fix(profile+dashboard): class-change modal uses class name, not evolution stage
- fix(profile+inventory): soulstone UX + class-change button states
- fix(skills): dead-hang icons + HSPU icon mapping
- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.11 — 2026-07-06

Version code 11. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(admin): soulstone relation → count, profile class-change uses T1 name
- fix(profile+dashboard): class-change modal uses class name, not evolution stage
- fix(profile+inventory): soulstone UX + class-change button states
- fix(skills): dead-hang icons + HSPU icon mapping
- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.10 — 2026-07-06

Version code 10. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(profile+dashboard): class-change modal uses class name, not evolution stage
- fix(profile+inventory): soulstone UX + class-change button states
- fix(skills): dead-hang icons + HSPU icon mapping
- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.9 — 2026-07-06

Version code 9. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(profile+inventory): soulstone UX + class-change button states
- fix(skills): dead-hang icons + HSPU icon mapping
- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.8 — 2026-07-06

Version code 8. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.7 — 2026-07-06

Version code 7. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): per-skill calitree icon overrides + bulk-download full icon set
- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.6 — 2026-07-06

Version code 6. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(skills): reorder Pull topology + hand-code icons for new skills
- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.5 — 2026-07-06

Version code 5. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(skills): remove SP economy + PHANTOM linear prereqs + missing skills
- feat(admin): reset-skills button + galaxy map mobile + roadmap cleanup
- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(skills): drop SP gate for test-based unlocks
- fix(admin): allow reset-skills on own user
- fix(galaxy-map): drop redundant below-SVG legend
- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): galaxy map mobile shipped in 7d21db2
- docs(roadmap): v1.0.4 published + sync script awk-bug note
- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged

## v1.0.4 — 2026-07-06

Version code 4. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat: bodyfat methods + BICEP split + HeartsCard HP bar + Modal fix + Android sync
- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites
- feat(hearts): full hearts are red, lost hearts are dark gray
- feat(avatar): scale hologram to user measurements + more contoured humanoid shapes
- feat(api+web): /calendar — month grid + per-day recap
- feat(web): opt-in browser notifications for game events
- feat(api): auto-link substances from food name (coffee→caffeine, etc.)

### Bug fixes

- fix: RHR gauge + /measurements category cards + habit tile visual state
- fix(perf): Web Audio node leak + portal-leak cap (max 3, never expires)
- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries
- fix(avatar): revert broken contoured shapes, keep measurement-based scaling
- fix(calendar): today's undone dailies render as empty gray box, not red X
- fix(api+web): add workouts[] to /dailies/morning-popup so Calendar can list them
- fix(calendar): dailies strikethrough removal, color-coded X/Y boxes, future-date empty state, workouts list
- fix(login): 'Change API server' link on login screen so user can recover
- fix(nutrition): unify /today food modal (add recent foods) + yellow capsule chrome
- fix(forecast+status): forecast cleanup, mobile forecast stack, recommend→status
- fix(api+web): measurements cleanup — v-taper sidebar, RHR IdealGauge, X% OVER gate, RHR formula
- fix(web): Profile.tsx previewMax drifted from api geneticMax formulas

### Polish

- refactor: flat-grid /measurements + full log/history/override in MetricDetailModal
- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

### Other

- docs(roadmap): note /measurements refinement in b6316e7
- docs(roadmap): fill in ff107df commit refs for the 3 backlog items
- docs(roadmap): log portal-leak cap + Web Audio leak fix as recently shipped
- docs(roadmap): HeartsCard→HP swap is shipped (moved out of backlog)
- docs(roadmap): v1.0.3 shipped + sex picker change logged
- docs(roadmap): tighten the genetic-max-consistency entry with the actual bug
- docs(roadmap): add 5 new measurement-related items + restate neck concern
- docs(roadmap): incorporate user session notes, prune stale items

## v1.0.3 — 2026-07-06

Version code 3. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

## v1.0.3 — 2026-07-06

Version code 3. Tracks the parent
fitquest repo (web + api). Run from fitquest-android after the parent
repo has shipped changes.

### Features

- feat(admin): skill reset endpoint + pet primary UX + goggled sprites
- feat(pets): isPrimary + set-primary endpoint + skill unlock error UI + buy confirm
- feat(pets): re-add 6-pet cap + /pet/release endpoint
- feat(pets): drop 6-pet cap + pet card on dashboard + raid/leak row
- feat(pets): multi-pet support (up to 6 per user)
- feat(pets): swap economy — food primary, combat secondary
- feat(pets): 3 breeds available + pet food ShopItems
- feat(pets): 6 endpoints + workout XP hook + /shop + /pet pages
- feat(pets): add PetBreed, PetInstance, PetFeedLog schema + 3 breed sprites

### Bug fixes

- fix(homebase): mobile layout — better label readability
- fix(dashboard+mobile-nav): remove settings dup + reorder in mobile overlay
- fix(pet): rewrite set-primary to bypass useMutation + auto-select non-primary
- fix(pets): primary on leftmost + setQueryData instant update + modal ghosting fix
- fix(apiUrl): remove duplicate getApiBaseUrlSource export
- fix: shop reference error + API URL runonce flag
- fix: shop always shows breed picker + forecast snow/range bug
- fix(pets): User.pet PetInstance? -> User.pets PetInstance[] (1-to-many)
- fix(pets): gold refresh + 'Owned' count after food purchase
- fix(sidebar): add Pet Shop + Pet nav entries

### Polish

- polish: user hearts → green HP bar + pet card in combat UIs
- polish(pet): drop SPRITE label, gate attack to Lv15, better cooldown text, green HP

