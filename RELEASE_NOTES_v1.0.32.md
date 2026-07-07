# FitQuest Android v1.0.32

Hotfix: AI Coach messages panel scrolls to top on entry.

## What's fixed

v1.0.31's scroll-to-top fix moved the Layout-level `<main>` to
the top on every nav. The Coach page has a *second* scrollable
surface — the messages list (`max-h-[60vh] overflow-y-auto`)
inside the conversation Panel — which has its own independent
scroll position. Navigating to /coach still landed at the
bottom of the conversation because the auto-scroll-to-bottom
effect fired on every messages render, including the initial
mount.

This version:
- **Initial render** (first time messages load): scroll the
  messages div to its top so the user sees the start of the
  conversation (or the empty state).
- **Subsequent renders** (a new message was just appended):
  scroll to bottom so the latest reply is visible.

Tracked via refs (`initializedRef` + `prevMsgCountRef`) so the
distinction is reliable across re-renders.

The dev server picks this up live via HMR.