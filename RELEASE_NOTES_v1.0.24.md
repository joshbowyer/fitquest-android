# FitQuest Android v1.0.24

Skill-tree icon alignment — the real fix.

## What changed

**Every skill-tree icon now sits at exactly the same Y.** Root cause
(missed by the last three attempts): skill names wrap to 1 or 2 lines,
which made the node buttons different heights — `min-h-[92px]` floors a
button's height but can't cap it. The `items-center` chain wrapper then
centered the shorter (1-line-name) buttons inside the `items-stretch`
row, pushing their circles ~4px lower than their 2-line-name neighbors.

The fix removes the height variable from the equation entirely:

- Chain nodes are **top-anchored** (`items-start`), so an icon's Y
  depends only on the fixed-height parts above it (tier label 10px +
  gap 6px) — never on how the name wraps.
- The name label is a fixed two-line box (`h-[22px]`), making every
  button exactly 100px tall.
- The connector bar is pinned at the icon center (y=44) measured from
  the top (`mt-[43px]`), replacing the center-then-translate math that
  had to be re-tuned every release.

Also in this build:

- Hand-coded SVG skill icons now render at 28px, matching the calitree
  PNG masks (they were 24px, so icon sizes looked inconsistent between
  branches).
