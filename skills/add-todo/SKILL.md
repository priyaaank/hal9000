---
name: add-todo
description: >-
  Add a TODO/task into Priyank's Obsidian daily planner with an inferred Eisenhower
  priority (quadrant) and a due date — both assumed sensibly if not specified. Trigger
  when the user says "add a todo", "add task", "remind me to", "I need to", "todo:", "put
  this on my list", or otherwise describes something they have to do. Places the task in
  the correct day's planner (creating it from the template if missing), in the right
  quadrant and Work/Personal bucket.
---

# AddTodo

Capture a task into the right daily planner, with a quadrant and a date — inferred when
not stated.

## Setup
- Vault root: `/Users/priyank/Library/Mobile Documents/iCloud~md~obsidian/Documents/work-v2`
- **Read `Master Context — Obsidian Vault.md` first** — esp. §6 (Daily Planner Structure,
  Eisenhower 2×2, Work/Personal split, §6.5 template).
- Get today's date with `date +%Y%m%d` (filename) and `date +%Y-%m-%d` (YAML / `📅`).

## Procedure
1. **Parse the task.** Extract the action text; strip filler ("remind me to", "I need
   to"). Keep it terse, imperative, in Priyank's voice — match existing task lines.

2. **Resolve the due date** → which planner the task lives in (the planner date IS the
   task's working date):
   - Explicit date / weekday / "tomorrow" / "next monday" / "in 3 days" → compute it
     (`date -v+1d +%Y%m%d`, etc.).
   - **Not specified → assume**, and say so: deadline-ish/blocking/"asap" → today;
     otherwise → today by default (or the next sensible day). Mark assumed dates clearly.

3. **Decide the quadrant** (§6.3) — assume if not specified, and state the reasoning:
   - *Urgent* cues: deadline today/this week, "asap", blocking someone, "follow up",
     "respond to", a waiting person, expiring opportunity.
   - *Important* cues: strategic/growth, leadership, hiring, client commitments,
     people/compensation decisions, anything tied to a Focus Area.
   - Map: **Q1** Urgent+Important · **Q2** Important, not urgent · **Q3** Urgent, not
     important · **Q4** neither.
   - Infer confidently when you can; if genuinely ambiguous, ask **one** concise question
     with a recommended default.

4. **Decide Work vs Personal** (§6.4) from the content (client/hiring/team = Work;
   travel/finance/fitness/family = Personal).

5. **Compose the line:** `- [ ] <task text>`
   - Add `📅 YYYY-MM-DD` only if the task is parked in an earlier planner than its real
     deadline.

6. **Write to the planner** `DailyPlanner/<YYYYMMDD>-Daily.md`:
   - If it doesn't exist, create it from the §6.5 template (Obsidian Properties block with
     `date` and a `tags:` list containing `daily` — bare, no `#`,
     `# Daily Planner — DD MMM YYYY`, the four Q-sections each with `### Work` /
     `### Personal`, Carry-Overs, End-of-Day Notes).
   - Read it first; append the task under the correct `## Q… → ### Work/Personal`
     subsection. Never overwrite existing content (§12.1–12.2).
   - If the user says it's a theme for the day, add it under `## Focus Areas` instead
     (no checkbox — focus areas are themes, not tracked tasks, §6.2).

7. **Confirm** what was added, to which planner, the quadrant label (e.g. "added to
   today's planner under **Q1 — Urgent + Important / Work**"), and explicitly note any
   date or quadrant that was **assumed** vs specified.

8. **Self-enrich:** if the task names a new person/client, add them to
   `Metadata/PeopleIndex.md` / `Metadata/ClientRegistry.md` (§9.1–9.2).

## Notes
- Don't duplicate a task already open in a recent planner — mention it instead.
- Batch input ("add these three…") → one line each, one confirmation summary.
- Always surface assumptions (date + quadrant) so Priyank can correct them in one reply.
