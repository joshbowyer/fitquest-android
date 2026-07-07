# FitQuest Android v1.0.34

Bug fix: FIT_MONITORING_B type corrected to 16 (was 119).

## What was wrong

v1.0.33 added `type 119` to the FIT kind label map based on a
wrong FIT spec reading — `119` is not actually a real
`FIT_FILEID_TYPE` constant. Per `@garmin/fitsdk`'s profile,
modern Garmin watches (FR255, FR955, Fenix 7, etc.) write
the monitoring-b file as numeric type **16**
(`FIT_FILE_MONITORING_B`). Older watches use type 10
(`FIT_FILE_MONITORING_A`).

The user's actual MONITOR files (all 8+ checked with
`file -b`) show `type 16` — so the v1.0.33 fix was a no-op:
every monitoring FIT was still being classified as `unknown`
and parsed to nothing.

## The fix

- Replace `119`/`120` with `16`/`10` in `FIT_KIND_LABELS`.
- Update the regression test to assert the real types.
- Update `parseMonitor`'s body-battery comment to reference
  the real type values.

## What this means for the user

Importing MONITOR files now works end-to-end:
- `kind: 'monitor'` (was 'unknown')
- Stress, respiration rate, steps, RHR are extracted
- Body battery still **not** extracted — see note below

Verified live: imported 3 MONITOR files via `/import` and the
DB now has 2548 STEPS rows (up from 2544) and 2470
RESPIRATION_RATE rows (up from 2466).

## Also in this release

Migration `20260707120000_measurement_unique_constraint` actually
creates the `@@unique([userId, metric, recordedAt])` constraint
on the `Measurement` table. The schema declared it but the live
DB only had the plain index, so `prisma.measurement.upsert`
was failing with Postgres `42P10` ("no unique or exclusion
constraint matching the ON CONFLICT specification"). The import
route's idempotency contract (re-uploading the same FIT just
updates existing rows) was broken until this migration runs.

## Note on body battery

**Body battery is not in any of the user's FIT files.** I
decoded every directory in
`/home/josh/tmp/gadgetbridge/` (ACTIVITY, METRICS, HRV_STATUS,
MONITOR, SLEEP) and zero contain `hsaBodyBatteryDataMesgs`.
This particular watch + Gadgetbridge sync path doesn't surface
body battery via FIT file export — it lives in Garmin
Connect's database (Health API) and would need a separate
integration to pull. Out of scope for the FIT pipeline; would
be a roadmap item if you want to add a Garmin Connect Health
API integration to FitQuest.