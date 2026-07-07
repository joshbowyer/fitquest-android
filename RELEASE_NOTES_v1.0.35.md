# FitQuest Android v1.0.35

One-shot TODO list + server-side vitals endpoint for the upcoming
Gadgetbridge auto-sync.

## What's new

### `/todos` — one-shot TODO list

A simple checkbox-with-XP list for finite tasks ("Schedule PT
appt", "Register for the marathon", "Buy new running shoes").
Distinct from Habits (recurring tick) and Dailies (scheduled
check-ins).

- **Server**: `POST/GET/PATCH/DELETE /todos`. `TodoItem` table with
  title, description, dueDate, priority (LOW/MED/HIGH), status
  (OPEN/DONE), completedAt.
- **XP reward**: marking complete grants XP scaled by priority —
  Low=10, Med=20, High=30. Flows through the centralized `awardXpGold`
  so the Hardcore heart multiplier applies. Re-saving an already-DONE
  todo doesn't re-award.
- **Web**: new page at `/todos` (nav icon ☐). Filter pills (Open/Done/All),
  inline editor modal, due-date badges (overdue / due today / in N
  days), XP toast on completion.

### `/vitals` — server endpoint for GB auto-sync

Batched ingestion of time-series health data (steps, body
battery, heart rate, stress, HRV, sleep, SpO2, respiration).
The primary consumer is the upcoming Gadgetbridge FitQuest
auto-sync (see `GB_FITQUEST_SYNC.md` in the FitQuest repo for
the full design).

- `POST /vitals` accepts `{ kind, unit?, source?, samples: [{ts, value}] }`,
  upserts into `Measurement` keyed on `(userId, metric, recordedAt)`.
  Idempotent — same-value skip avoids churn on re-syncs. Validates
  `kind` against the known `MetricType` enum values; 400 with
  `unknown_metric` if a typo. Up to 1000 samples per POST.
- `GET /vitals?since=ISO&kind=...&limit=...` returns existing
  samples for cursor reconciliation. Default window is the last
  7 days.

### Roadmap: GB auto-sync design doc

`docs/GB_FITQUEST_SYNC.md` in the FitQuest repo captures the
full architecture for the Gadgetbridge-side auto-sync that
will close the gap on body battery (currently in non-FIT memory
on Garmin watches, so the FitQuestBridge APK can't get it).
Tracker-agnostic interface mirrors the HealthConnect syncer
pattern; supports any of the existing trackers with ~50 lines
of impl each.

## Note on the GB PR (#6332)

The existing Gadgetbridge integration PR (manual upload from
workout details screen) is still open upstream awaiting
review. The new `/vitals` endpoint and this TODO page don't
block that PR — they're independent.