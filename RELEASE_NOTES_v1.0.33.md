# FitQuest Android v1.0.33

Bug fix: imported FIT monitoring files now extract body battery
+ HRV data.

## What was wrong

The FIT parser's `detectFitKind()` only mapped 5 of Garmin's
many file types. Modern watches (FR255, FR955, Fenix 7) write
the all-day monitoring file as numeric type 119
(`FIT_FILE_MONITORING_B`), which fell through to the `?? 'unknown'`
default. Every monitoring FIT uploaded by the bridge got
classified as 'unknown' and parsed to nothing — no body battery,
no HRV summary, no nothing.

Additionally, body battery + HRV extraction was in
`parseMetrics` (file type 44, rare daily rollup) instead of
`parseMonitor` (where the HSA messages actually live). Even
when monitoring files were correctly classified, the body
battery path was on the wrong code branch.

## The fix

- Expand `FIT_KIND_LABELS` with `119` (modern monitoring) and
  `120` (older monitoring format). Map cruft types (1 settings,
  2 sport, 3 totals) to 'unknown' explicitly so the import log
  shows why.
- Move body battery + HRV extraction from `parseMetrics` into
  `parseMonitor`. `parseMetrics` now delegates to
  `parseMonitor`.
- All the existing extraction (stress, respiration rate, steps,
  RHR) was working correctly in `parseMonitor` — left alone.

## To backfill old monitoring files

The bridge dedupes by absolute file path in its
`knownFilePaths` set, so files that were ALREADY uploaded as
'unknown' before this fix won't be re-uploaded automatically.
Two options:

1. **Clear GB's app data** (Android Settings → Apps →
   Gadgetbridge → Storage → Clear Data) and re-sync. GB
   regenerates all the FIT files, which will all be 'new' to
   the bridge and re-uploaded with the new parser.
2. **Wait for new uploads** (next sync of new monitoring data).
   These will start populating `BODY_BATTERY` rows.

A "force resync" button on the bridge would be a nice follow-up
to avoid the GB-clear workaround (roadmap candidate).