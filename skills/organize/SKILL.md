---
name: organize
description: >-
  Review the Obsidian vault's Staging area and auto-classify pending raw notes into the
  correct folders, paraphrasing and restructuring them along the way. Trigger for
  "organize", "organize my vault", "process staging", "clear my staging", "classify
  these notes", "file my pending notes", "clean up staging", or whenever raw captures
  have piled up in Staging/ and need to be routed. Rewords raw input into crisp,
  structured bullets, adds the right tags and YAML, names the file per convention, and
  leaves anything genuinely ambiguous in Staging with a flag.
---

# Organize

Process the `Staging/` backlog: classify each note into its proper folder, restructure
the content, name and tag it per the vault conventions, and log what was moved.

## Setup
- Vault root: `/Users/priyank/Library/Mobile Documents/iCloud~md~obsidian/Documents/work-v2`
- **Read `Master Context — Obsidian Vault.md` first** (the authoritative reference) for
  folder routing rules (§3), naming convention (§4), tagging system (§5), YAML front
  matter (§11), and operating principles (§12). Everything below defers to it.
- **Read `Metadata/ClientRegistry.md` and `Metadata/PeopleIndex.md`** for the known
  client/person vocabulary before inferring any tag.
- Get today's date with `date +%Y%m%d` (filename form) and `date +%Y-%m-%d` (YAML form).

## Procedure
1. **List the staging backlog.** Read every note in `Staging/`. For each, note its age
   from its `date:` field / filename. Show the user the list of notes you're about to
   process. **If there are more than 5 notes, confirm before proceeding** (operating
   principle §12.7 — ask before bulk operations).

2. **Classify each note → folder** using the Staging routing rules (MasterContext §3,
   mapped to the real on-disk folder names):
   1. Named client / client meeting → `ClientMeetings/`
   2. Internal leadership / office group / council / MD / team meeting → `InternalMeetings/`
   3. Daily task list or carry-over → `DailyPlanner/` (prefer the `plan` / `add-todo` skills)
   4. Feedback or expectations about a person → `Feedback&ExpectationSetting/`
   5. Interview notes / candidate observation → `Interviews/`
   6. Tied to a named project → `Project/<ProjectSubfolder>/`
   7. Personal (travel, finance, fitness, family) → `Personal/`
   8. Exploratory / thinking-in-progress → `ThinkingSpace/`
   9. **Ambiguous → leave in `Staging/`**, add `#toprocess`, and note the ambiguity for
      Priyank (operating principle §12.4 & §12.6). Never guess silently.
   - **Never route anything to `Metadata/`** — that folder is skill-managed only.

3. **Paraphrase & restructure the content** (only when it improves it):
   - Rewrite raw/voice-dump input into crisp, factual bullets in Priyank's terse,
     direct, first-person voice (operating principle §12.3). Remove filler; fix
     structure; **never invent facts** — preserve every concrete detail, name, number,
     date, and decision.
   - Group under `## Section` headers fitting the type:
     - client/catchup → `## Discussion` / `## Decisions` / `## Actions`
     - feedback → `## Feedback` / `## Expectations` / `## Follow-up`
     - interview → `## Notes` / `## Signals` / `## Recommendation`
     - project → `## Context` / `## Decisions` / `## Next steps`
     - thinking → leave loose; do not over-structure exploratory notes.
   - (You may lean on the `paraphrase-crisp` skill's style for the rewording.)

4. **Name the file** per §4: `YYYYMMDD-NoteTitle` — date of the event/creation, Title
   Case, hyphens for spaces, 3–6 words, no tags/folder in the name.
   e.g. `20240315-SiteMinder-Kickoff-Call`.

5. **Choose tags** (§5) — at least 2–3, lowercase: person/group tags, meeting/discussion
   type, category, client (only one, from `ClientRegistry.md`), and status/frequency
   where relevant.

6. **Write the Obsidian Properties (YAML front matter) block** at the very top of the
   file. Tags go **inside this block as a YAML list with bare names — no `#` prefix**
   (a `#` in YAML is read as a comment and breaks the tag, and Obsidian adds the `#`
   itself). Required: `date`, `folder`, `tags`; optional `client`/`people`/`project`/`status`:
   ```yaml
   ---
   date: 2026-06-15
   folder: ClientMeetings
   client: Altrata
   people: [Andy, Jude]
   tags:
     - altrata
     - clientkickoff
     - andy
   ---
   ```
   Then add `[[WikiLinks]]` per §10 — client meeting notes link to their `Project/` note;
   feedback notes link back to relevant meetings. For `Feedback&ExpectationSetting/`,
   **append to the existing `PersonFirstname-FeedbackLog` note** (newest entry at top)
   rather than creating a new file (§7, §12.4).

7. **Move/write the file**, then **log the action** to `Metadata/SkillUsageLog.md` with
   timestamp, action type (move/create), source, destination, and reason (§9.3).

8. **Self-enrich metadata:** add any new person (full name) to `Metadata/PeopleIndex.md`
   and any new client to `Metadata/ClientRegistry.md` before using their tag (§9.1–9.2).

9. **Report** a short summary: each note → where it went and why; which were left in
   Staging as ambiguous; any duplicates flagged to `Metadata/IntrospectionNotes.md`
   (don't delete — §12.5).

## Notes
- Read before write; append, never overwrite (§12.1–12.2).
- Respect `ThinkingSpace/` — never reorganise notes already there (§12.8).
- If a note has sat in Staging > 7 days, flag it in `Metadata/VaultHealthReport.md` (§9.6).
- If a note clearly contains action items, offer to add them via the `add-todo` skill.
