# FitQuest Android v1.0.28

Resilience fix.

## What's fixed

`publicUser()` (called on every `/auth/me` and login) now degrades
gracefully when a column referenced in the code hasn't been
migrated to the live database yet. Previously this caused every
authenticated user to be kicked to the login screen until the
admin ran `npx prisma migrate deploy` (which happened today
after the v1.0.27 /coach feature shipped — 25 min of forced
re-logins while the fix was being written).

## Notes

- No code behavior change when the DB schema matches the code
  (the safe path runs once per /me, ~1ms, cached by Prisma)
- Real Prisma errors (P2002 unique violations, P2025 not-found,
  network failures) still propagate normally — only P2022
  (column does not exist) is swallowed, and logged as a warning
  so the missing-migration situation is visible in the API logs
- Other one-off fetches inside `publicUser` (soulstone count,
  `creatineActive`, classLock status) are unaffected — only the
  fields that read straight off the User row go through the
  guard