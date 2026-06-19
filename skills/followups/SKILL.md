---
name: followups
description: >-
  Find every follow-up that needs to happen with a person across Priyank's Obsidian vault
  — pending todos, action items in meeting/feedback notes, and open loops — and group them
  by person with a due date (specified, or sensibly assumed). Trigger for "follow ups",
  "who do I need to follow up with", "people followups", "what do I owe people", "pending
  follow-ups by person", "who am I waiting on", "follow-up list". Surfaces stale follow-ups
  as relationship risk.
---

# FollowUps

Pull the person-centric slice out of the vault: every commitment to or from a person,
grouped by person, each with a date.

## Setup
- **Vault root** — resolve at runtime; never hardcode a machine path. Run:
  ```
  VAULT="${OBSIDIAN_VAULT:-$(cat "${XDG_CONFIG_HOME:-$HOME/.config}/hal9000/vault" 2>/dev/null)}"
  ```
  and use `$VAULT` as the vault root throughout. If `$VAULT` is empty or not an existing
  directory, ask the user for their Obsidian vault path and offer to save it to
  `${XDG_CONFIG_HOME:-$HOME/.config}/hal9000/vault`.
- **Read `Master Context.md`** for tagging (§5, person tags) and folders.
- **Read `Metadata/PeopleIndex.md` and `Metadata/ClientRegistry.md`** for the known
  person/client vocabulary, and **`Metadata/OpenLoops.md`** for already-tracked threads.
- Get today's date with `date +%Y-%m-%d` for age / due-date math.

## Procedure
1. **Gather candidate follow-ups from across the vault:**
   - Open `- [ ]` tasks in `DailyPlanner/*.md` and `DailyPlanner/Archive/*.md`
     (de-duplicated; record first-appeared date + age).
   - Action items in `ClientMeetings/`, `InternalMeetings/`, `Feedback&Expectations/`,
     and `Project/*/` notes (lines under `## Actions` / `## Follow-up`, or `- [ ]` items there).
   - Entries in `Metadata/OpenLoops.md`.

2. **Identify which are people follow-ups.** A item qualifies if it either:
   - names a person (a `#firstname` tag, a name in `PeopleIndex.md`, or a clearly
     capitalised human name), OR
   - uses an interpersonal verb: "follow up", "respond to", "reply", "call", "ask",
     "share with", "introduce", "check with", "ping", "send to", "confirm with",
     "feedback for/to", "expectation", "schedule 1:1 / catch up with".
   - Client/account contacts count too (e.g. "respond to Tesla on SoW" → Tesla contact).

3. **Resolve a date for each follow-up:**
   - **Specified** — explicit date / "by Friday" / "next week" / a `📅` tag → use it
     (compute with `date -v` on macOS).
   - **Assumed** — none stated → infer from urgency and mark it `(assumed)`:
     blocking someone / "asap" / Q1 → today or tomorrow; routine reply → +2–3 days; a
     scheduled catch-up → its known cadence. State the assumption explicitly.

4. **Group by person/account**, ordered by urgency then count. Label direction —
   "I owe them" (I must send/do) vs "waiting on them" — when the wording makes it clear:
   ```
   ### Rajesh
   - [ ] Send Q1 feedback writeup — due 2026-06-20 — I owe — 4d old
   - [ ] Confirm 1:1 slot — due 2026-06-19 (assumed) — I owe — 1d old

   ### Tesla (account)
   - [ ] Respond on SoW draft — due 2026-06-20 — waiting on them — 6d old
   ```
   - Put genuinely unattributable items under `### Unattributed`.
   - **Flag any follow-up stale > 14 days** as relationship risk.

5. **Offer next actions:** draft a short message for any follow-up; add a dated reminder
   via the `add-todo` skill; or append the commitment to the relevant
   `Feedback&Expectations/` or `ClientMeetings/` note.

## Notes
- Read-only by default — only write when asked.
- Add any newly-encountered person/client to `Metadata/PeopleIndex.md` /
  `Metadata/ClientRegistry.md` (§9.1–9.2).
- Always show whether a date was specified or assumed — never present an inferred date as
  fact.
