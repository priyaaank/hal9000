# HAL 9000 — Obsidian Vault Co-pilot for Claude Code

A Claude Code skill bundle that runs Priyank's Obsidian **ai-vault** — organizing raw
captures, planning the day, coaching on habits, tracking people follow-ups, and adding
todos. Every skill reads and defers to the vault's **`Master Context — Obsidian Vault.md`**
(the authoritative reference for folders, naming, tags, YAML, the daily-planner template,
and the AI operating principles). No vault migration needed.

> **Not installed yet.** This repo only contains the skill files. See **Install** below.

## The skills

| Skill | What it does | Say something like |
|-------|--------------|--------------------|
| **organize** | Reviews `Staging/`, auto-classifies each pending note into its proper folder per the routing rules, paraphrases/restructures the content, names + tags + front-matters it, and logs the move. Ambiguous notes stay in Staging, flagged. | "organize my vault", "process staging" |
| **plan** | Generates today's planner from the template, carries forward every pending todo (verifying nothing is missed), archives past-day planners into `DailyPlanner/Archive/` (keeping today in place), and classifies tasks into the Eisenhower quadrants with a Work/Personal split. Preserves completion history for retrospectives. | "plan my day", "roll over my todos" |
| **review** | Reads planner history + metadata to coach on habits and procrastination, citing specific stalled tasks and quadrant imbalances — and validates current behaviour against **past** recommendations, saving new ones with IDs/status so the next review can measure follow-through. | "review my habits", "am I procrastinating?" |
| **followups** | Finds every follow-up owed to/from a person across todos, meeting/feedback notes, and open loops; groups them by person with a specified-or-assumed due date; flags stale ones as relationship risk. | "who do I need to follow up with?" |
| **add-todo** | Adds a task to the right day's planner (creating it if missing) with an inferred quadrant and due date — both assumed sensibly when unspecified, and always surfaced. | "add a todo: …", "remind me tomorrow to …" |

## How it works

- **Single source of truth:** every skill reads `Master Context — Obsidian Vault.md` first,
  so conventions live in the vault, not duplicated in code.
- **Metadata brain** (`Metadata/`, skill-managed per §9): `SkillUsageLog.md` (every
  move/create), `PeopleIndex.md` & `ClientRegistry.md` (vocabulary, self-enriched),
  `IntrospectionNotes.md` (review recommendations + status), `OpenLoops.md` (recurring
  threads), `PlannerHistory.md` (per-day completion/carry-over snapshots for retrospectives),
  `VaultHealthReport.md` (staging backlog etc.).
- **Retrospective data is never deleted** — `plan` *archives* past planners (with their
  `- [x]`/`- [ ]` state intact) into `DailyPlanner/Archive/`, and snapshots stats to
  `PlannerHistory.md`. `review` reads both.
- **Operating principles honored** (§12): read before write, append never overwrite,
  preserve Priyank's voice, flag ambiguity, ask before bulk (>5 notes), respect
  `Thinking Space/`, never edit Master Context.

### Vault path (externalized — no machine paths in the skills)
The skills resolve the Obsidian vault root at runtime, in this order:
1. the `OBSIDIAN_VAULT` environment variable, else
2. the path stored in `${XDG_CONFIG_HOME:-$HOME/.config}/hal9000/vault`, else
3. they ask you for it (and offer to save it to that config file).

Configure it once, either way:
```bash
# Option 1 — environment variable (add to your shell profile)
export OBSIDIAN_VAULT="/path/to/your/Obsidian/Vault"

# Option 2 — config file (works for background/cron agents too)
mkdir -p ~/.config/hal9000
printf '%s\n' "/path/to/your/Obsidian/Vault" > ~/.config/hal9000/vault
```
No absolute path is baked into any `SKILL.md` — moving machines or vaults only means
updating the env var or that one config file.

## Install

This bundle is **not installed**. Two ways to enable it:

**A. Symlink each skill into `~/.claude/skills/`:**
```bash
cd /path/to/hal9000   # this repo
./install.sh
```
Because they're symlinks, editing a `SKILL.md` here takes effect immediately.

**B. Use as a Claude Code plugin** (a `.claude-plugin/plugin.json` is included): add this
directory through your plugin/marketplace config.

Then the skills are available by name — `/organize`, `/plan`, `/review`, `/followups`,
`/add-todo` — and Claude auto-triggers them from natural phrasing.

### Uninstall (symlink method)
```bash
rm ~/.claude/skills/{organize,plan,review,followups,add-todo}
```
(Removing symlinks touches neither this repo nor the vault.)

## Repo layout
```
hal9000/
├── .claude-plugin/plugin.json
├── README.md
├── install.sh
└── skills/
    ├── organize/SKILL.md
    ├── plan/SKILL.md
    ├── review/SKILL.md
    ├── followups/SKILL.md
    └── add-todo/SKILL.md
```
