# FitQuest Android v1.0.4

Tracks parent fitquest repo commits up to 2026-07-06.

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

