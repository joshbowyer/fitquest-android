# FitQuest Android v1.0.27

New feature: AI Coach.

## What's new

A new `/coach` page (nav icon ✺) with a personality selector and
chat interface. The system prompt is composed from a shared
preamble + a per-personality voice block + FitQuest world context.
Uses the system default LLM (`minimax-m3`).

### 5 personality presets

- **Priest Bodybuilder** — Catholic/monastic imagery + hypertrophy.
  The default FitQuest voice. New users get this until they pick.
- **Drill Sergeant** — direct, no-nonsense, discipline-focused.
- **Bob Ross** — soft, affirming, never negative. "Happy little sets."
- **Zoomer (Zyzz bro)** — gym-bro subculture, aesthetic, memes.
- **Generic** — polite neutral AI health assistant. Safe default.

### Notes

- Schema: new `CoachPersonality` enum + `User.coachPersonality`
  nullable column. Migration applied automatically on api startup.
- Conversation is local-state (no server history yet — resets on
  page reload; future iteration will persist).
- Admin-side per-personality prompt overrides deferred to a
  follow-up roadmap item (`LlmConfig.coachSystemPromptOverrides`).
- If the admin hasn't configured the LLM yet, the page renders a
  disabled input — `GET /coach` returns the meta fine, `POST
  /coach` returns 422 until the admin enables the LLM.