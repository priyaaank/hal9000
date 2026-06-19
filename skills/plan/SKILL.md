---
name: plan
description: >-
  Generate today's daily planner in the Obsidian vault — carry forward every pending todo
  from previous days (verifying nothing is missed), archive past-day planners into a
  subfolder while keeping today's in DailyPlanner/, and classify tasks into the Eisenhower
  quadrants with a Work/Personal split. Trigger for "plan my day", "generate today's
  planner", "make my daily plan", "start my day", "set up today", "plan", "roll over my
  todos". Preserves completion history so retrospectives can be run later.
---

# Plan

Build today's daily planner, carry over unfinished work safely, and archive the past.

## Setup
- Vault root: `/Users/priyank/Library/Mobile Documents/iCloud~md~obsidian/Documents/work-v2`
- **Read `Master Context — Obsidian Vault.md` first** — esp. §6 (Daily Planner Structure,
  template, Eisenhower 2×2, Work/Personal split) and §9 (Metadata). All formatting below
  defers to it.
- Get today's date: `TODAY=$(date +%Y%m%d)` (filename) and `date +%Y-%m-%d` (YAML).

## Procedure
1. **Find the day's planner.** Target file: `DailyPlanner/<YYYYMMDD>-Daily.md`. List
   `DailyPlanner/*.md` to see existing day planners and the latest one. If today's
   already exists, you're updating it — read it first, never overwrite (§12.1–12.2).

2. **Gather ALL pending todos so nothing is missed.** Scan every planner in
   `DailyPlanner/` **and** `DailyPlanner/Archive/` for open checkboxes:
   ```
   grep -rn '^\s*- \[ \]' "<vault>/DailyPlanner"
   ```
   For each open `- [ ]`: capture the task text, its quadrant (Q1–Q4), its Work/Personal
   bucket, any `📅` due date, and its source planner date (= "first appeared"; age =
   today − that date). **De-duplicate** carried-over copies (normalise text, drop the
   checkbox/tags); keep the earliest first-appeared date and count how many days it has
   recurred. Completed `- [x]` tasks are NOT carried — they stay as retrospective data in
   their original (soon-to-be-archived) planner.

3. **Archive past days.** For every `DailyPlanner/<date>-Daily.md` whose date is
   **before today**, move it (intact, with all `- [x]`/`- [ ]` state preserved) into
   `DailyPlanner/Archive/` — create that subfolder if missing. Keep **today's** planner in
   `DailyPlanner/`. Log each move to `Metadata/SkillUsageLog.md` (timestamp, move, source,
   dest, reason). Archiving (not deleting) is what preserves retrospective data — never
   delete a planner (§12.5).

4. **Create / update today's planner** using the §6.5 template:
   ```markdown
   ---
   date: YYYY-MM-DD
   tags:
     - daily
   ---

   # Daily Planner — DD MMM YYYY

   ## Focus Areas
   - 

   ---

   ## Q1 — Urgent + Important
   ### Work
   ### Personal
   ## Q2 — Not Urgent + Important
   ### Work
   ### Personal
   ## Q3 — Urgent + Not Important
   ### Work
   ### Personal
   ## Q4 — Not Urgent + Not Important
   ### Work
   ### Personal

   ---

   ## Carry-Overs from Yesterday
   ## End-of-Day Notes
   ```
   - Place each carried-over task back under its original **quadrant + Work/Personal**
     bucket. Re-evaluate urgency for the new day (an item due today is now urgent → Q1/Q3;
     §6.3). Preserve any `📅` due date on the line.
   - Under **Carry-Overs from Yesterday**, log a one-line trace: how many tasks carried,
     from which dates, and flag any item carried over many days (chronic stall).
   - Leave **Focus Areas** for Priyank, or propose 2–3 themes (§6.2) drawn from the
     heaviest Q1/Q2 items and ask him to confirm.

5. **Append unfinished, chronically-recurring items to `Metadata/OpenLoops.md`** (§9) so
   they surface as unresolved threads — especially anything carried > ~7 days.

6. **Record retrospective data.** Append a dated snapshot to
   `Metadata/PlannerHistory.md` (create if absent — Metadata is skill-managed, §9):
   ```
   ## 2026-06-19
   Archived: 20260618-Daily (done 6/9, carried 3).
   Carried into today: 9 open tasks (Q1=2 Q2=4 Q3=1 Q4=2; oldest 11d).
   ```
   This is the data the `review` skill and any future retrospective read from.

7. **Confirm**: today's planner path, count of tasks carried (by quadrant), what got
   archived, and the oldest stalled item.

## Notes
- Read before write; append, never silently replace (§12.1–12.2).
- If the carry-over set is large, summarise rather than dump — but never drop a task.
- A task's effective due date is the planner it lives in; use `📅 YYYY-MM-DD` only when a
  task is parked earlier than its real deadline.
- Use the `add-todo` skill to add new individual tasks; use `followups` to pull the
  person-centric slice out of the backlog.
