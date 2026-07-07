# FitQuest Android v1.0.19

Tracks parent fitquest repo commits up to 2026-07-07.

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

