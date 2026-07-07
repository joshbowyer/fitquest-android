# FitQuest Android v1.0.26

Four P1.5 follow-ups from the bug-hunt session — none UI-reshaping, all correctness.

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