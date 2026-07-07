# Changelog

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

