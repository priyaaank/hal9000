---
name: review
description: >-
  Review the Obsidian vault's metadata and planner history to coach Priyank on better
  habits — surface procrastination patterns, chronically-stalled tasks, and quadrant
  imbalances, then make concrete recommendations. Crucially, it reflects on whether PAST
  recommendations were acted on by validating current behaviour against them. Trigger for
  "review", "review my habits", "how am I doing", "coach me", "am I procrastinating",
  "retrospective", "productivity review", "what should I change". Saves every
  recommendation to metadata with a status so the next review can measure follow-through.
---

# Review

Be a candid coach: read the longitudinal data, judge progress against past advice, and
give specific, checkable recommendations for better habits and less procrastination.

## Setup
- **Vault root** — resolve at runtime; never hardcode a machine path. Run:
  ```
  VAULT="${OBSIDIAN_VAULT:-$(cat "${XDG_CONFIG_HOME:-$HOME/.config}/hal9000/vault" 2>/dev/null)}"
  ```
  and use `$VAULT` as the vault root throughout. If `$VAULT` is empty or not an existing
  directory, ask the user for their Obsidian vault path and offer to save it to
  `${XDG_CONFIG_HOME:-$HOME/.config}/hal9000/vault`.
- **Read `Master Context.md`** for conventions (esp. §6 quadrants, §9
  Metadata files).
- **Read the metadata brain first:**
  - `Metadata/IntrospectionNotes.md` — the log of past reviews + recommendations (with
    IDs/status). This is what you reflect against. Create it if absent.
  - `Metadata/PlannerHistory.md` — per-day completion / carry-over snapshots from `plan`.
  - `Metadata/OpenLoops.md` — recurring unresolved threads.
- Get today's date with `date +%Y-%m-%d`.

## Procedure
1. **Scan the planner history.** Read `DailyPlanner/*.md` and `DailyPlanner/Archive/*.md`.
   For each day count completed `- [x]` vs open `- [ ]`. Build a timeline of completion
   rate per day/week.

2. **Derive habit & procrastination signals — quote specifics, never generalise vaguely:**
   - **Chronic stalls / procrastination:** tasks carried over across many planners and
     never done. List the worst offenders with their age in days. These are the
     procrastination evidence.
   - **Quadrant balance** (§6.3): distribution of done + open across Q1–Q4. Flag
     firefighting (everything Q1/Q3, reactive) and a starved Q2 (important-not-urgent
     work — the strategic stuff — perpetually deferred). A neglected Q2 is the #1 habit
     risk for this role.
   - **Work/Personal balance** (§6.4): is one bucket consistently empty? Personal items
     dropped every day is a real signal.
   - **Focus-area follow-through** (§6.2): do stated Focus Areas turn into completed tasks,
     or are they aspirational and ignored?

3. **Validate behaviour against PAST recommendations.** For every recommendation in
   `IntrospectionNotes.md` still `open`/`partial`, look in the current data for evidence
   it was acted on (the targeted task now done/gone; a suggested habit now visible; Q2
   block now appearing). Update each to `implemented` / `partial` / `ignored` / `dropped`
   **with the evidence/why**. This closes the loop — recommendations that keep getting
   ignored should be named as such.

4. **Produce the report:**
   - 3–5 honest observations, each citing specific tasks/numbers.
   - A reflection on prior recommendations and what actually changed.
   - 2–4 **concrete, prioritized, checkable** recommendations for better habits / beating
     procrastination — e.g. "Block a recurring 90-min Q2 slot — 0/12 days had any Q2
     completion", "Kill or delegate the 'expense report' task carried 14 days", not
     platitudes like "focus more".

5. **Save recommendations to metadata** so the next review can validate them. Prepend a
   dated section to `Metadata/IntrospectionNotes.md`, using stable IDs `R-YYYYMMDD-n`:
   ```
   ## 2026-06-19
   Completion: 68% over 14 days. Quadrants: Q1=.. Q2=.. Q3=.. Q4=..
   Observations: ...
   Prior-recommendation updates: R-20260605-1 → ignored (Q2 block never appeared); R-20260605-2 → implemented.
   New recommendations:
   - R-20260619-1 [open] Book a weekly 90-min Q2 strategy block.
   - R-20260619-2 [open] Delegate or drop the 3 tasks carried > 10 days.
   ```

## Notes
- Be a coach, not a cheerleader — name the uncomfortable pattern if the data shows it
  (per Priyank's direct-voice preference, §12.3).
- Read-only on planners; only write to the `Metadata/` files named above (§12.2, §9).
- If history is too short for a trend, say so rather than over-interpret.
- Don't modify `MasterContext` — propose any convention change in `IntrospectionNotes.md`
  instead (§12.9).
