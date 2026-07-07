# FitQuest Android v1.0.30

The AI Coach now remembers your conversations.

## What's new

### Conversation persistence

Close the browser (or kill the APK), come back tomorrow, your
coach chat is still there. The server stores one rolling
conversation per user — every message + assistant reply is
persisted in a `CoachConversation` + `CoachMessage` pair.

### Rate limits

To keep the LLM budget sustainable and prevent spam:

- **5 messages / 1 minute** burst limit (anti-spam)
- **50 messages / 24 hours** daily cap (cost ceiling)

Hitting either returns a 429 with a `Retry-After` header; the UI
shows "Slow down a bit — try again in 12s." instead of a raw
error.

### Sliding window

The LLM only sees the most recent 20 messages. Older turns are
either folded into a conversation summary (once the convo
crosses 30 messages) or dropped — so the prompt stays bounded
no matter how long you've been chatting.

### LLM summary compaction

When the conversation crosses 30 messages, a fire-and-forget
LLM call summarizes the oldest 10 turns and stores the result
on the conversation. Future requests see a "Summary of earlier
conversation" block at the start of the prompt, so the coach
remembers your goals / programs / PRs even after the sliding
window has dropped the raw turns.

### UI

- Page header shows "12 messages" + a "summarized" badge so
  you know what state the conversation is in.
- "clear conversation" button in the chat panel header — wipes
  messages + summary but keeps your personality choice.
- "thinking…" bubble while waiting on the LLM.
- Friendly error messages for 429 (slow down), 502 (provider
  hiccup), 422 (admin hasn't configured the LLM).