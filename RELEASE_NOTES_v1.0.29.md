# FitQuest Android v1.0.29

Two improvements: scroll-to-top on every nav + a much smarter AI Coach.

## Scroll-to-top on sidebar nav

Clicking a sidebar item now snaps to the top of the new page. Long
pages (Spiritual, Coach, Insights, etc.) used to load scrolled to
the bottom — you'd land somewhere in the footer and have to scroll
up to see the actual content. Now every route change scrolls to
top.

Hash deep-links (`#class`, `#anchor`) still work — the new
component defers one frame and retries up to 10 times for the
target element to mount, then falls back to top.

## AI Coach sees a lot more now

The coach's user-context block went from ~500 tokens (hearts /
streak / 7d workout count / avg sleep / today recovery) to ~1500-
2000 tokens covering:

- Last 5 workouts with exercise names + top sets (highest-volume
  set per workout, reps × weight) + total sets + duration
- Per-night sleep for the last 7 local days (not just the average)
- Substance counts broken down: caffeine today, caffeine / alcohol
  / nicotine / electrolyte this week
- Latest weight + body fat + 14-day weight trend
- Last 5 habit logs with direction + deltas + 7d positive/negative
  counts
- Yesterday's daily completion + 7d completion rate
- Today's nutrition totals (cal / protein / carb / fat / meal count)
  + yesterday's calories
- Last 5 PRs (exercise + value + type + date)
- Pending skill unlocks (count + last 3)

You can now ask the coach things like "what was my last squat?",
"how much caffeine today?", "what was my weight trend this
week?" — and it has the data without making you paste anything.

The Coach page sidebar adds a "Coach also sees" section under
the existing chips so you can sanity-check what data is
available (recent workouts count, pending skills, today's
caffeine, yesterday's calories, latest weight, latest body fat).