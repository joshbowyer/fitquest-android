# FitQuest Android v1.0.31

Hotfix: scroll-to-top actually scrolls now.

## What's fixed

The v1.0.29 ScrollToTop component called `window.scrollTo(0, 0)`
on every navigation — but the app's scrollable surface is
`<main className="overflow-y-auto">` (inside Layout), not the
window. The window doesn't actually scroll, so the effect was
a no-op. Reloading or clicking a sidebar item kept landing at
the bottom of the previous page.

This version targets `<main>` directly via querySelector (with
a window fallback only if Layout hasn't mounted yet). It also
fires on initial mount with a requestAnimationFrame defer so
the scroll wins the race against the browser's built-in scroll
restoration on back/forward and hard reload.

The dev server (vite on :5173) picks this up live via HMR; the
next APK install gets it bundled.