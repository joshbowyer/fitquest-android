# FitQuest Android v1.0.8

Tracks parent fitquest repo commits up to 2026-07-06.

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

