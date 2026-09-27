# mndrake plugins

A Claude plugin marketplace. Every plugin here works in **Claude chat** (claude.ai, desktop, mobile), **Claude Cowork**, and **Claude Code**.

| Plugin | What it does | Try it |
| --- | --- | --- |
| [eli5](plugins/eli5) | Explain any topic like I'm 5: a dead-simple HTML picture explainer with big visuals and few words. | `/eli5 how does DNS work` |

## Install

### Claude chat and Claude Cowork (recommended)

Add this repository as a marketplace once. Plugins you install are saved to your Claude account, so their skills are then available in chat, Cowork, and Claude Code.

1. In the Claude app, open **Customize** in the sidebar, then **Plugins**.
2. Choose **Add marketplace** and enter `mndrake/claude-plugins`.
3. Find **eli5** under **Discover** and click **Install**.

To pick up new versions, select **Check for updates** on the marketplace, or turn on **Sync automatically**.

### Upload a file instead

No marketplace needed — download a zip from [`dist/`](dist) and upload it:

- **Whole plugin:** [`dist/plugins/eli5.zip`](dist/plugins/eli5.zip) → **Customize → Plugins →** upload.
- **Just the skill:** [`dist/skills/eli5.zip`](dist/skills/eli5.zip) → **Customize → Skills →** upload. Useful where plugins aren't enabled but skills are.

In chat, make sure **Code execution and file creation** is on (Settings → Capabilities) so skills can run.

### Claude Code

```bash
claude plugin marketplace add mndrake/claude-plugins
claude plugin install eli5@mndrake-plugins
```

Or inside a session: `/plugin marketplace add mndrake/claude-plugins`, then `/plugin install eli5@mndrake-plugins`.

## Using eli5

- **Chat / Cowork:** type `/eli5 <topic>`, or just ask "ELI5 how vaccines work" — the skill triggers from its description. Chat renders the explainer as an HTML artifact; Cowork saves an `.html` file you can open.
- **Claude Code:** `/eli5 <topic>` writes an `.html` explainer to the current directory.

## Repository layout

```
.claude-plugin/marketplace.json   marketplace catalog (name: mndrake-plugins)
plugins/<plugin>/                 one folder per plugin
  .claude-plugin/plugin.json
  skills/<skill>/SKILL.md
dist/plugins/<plugin>.zip         upload-ready plugin packages (generated)
dist/skills/<skill>.zip           upload-ready skill packages (generated)
scripts/package.sh                rebuilds dist/
```

## Adding a plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json` and put skills in `plugins/<name>/skills/<skill>/SKILL.md`. The skill's `name` must match its folder (lowercase, digits, hyphens); keep the `description` specific about when to use it, since that is how chat and Cowork decide to trigger it.
2. Add an entry to `.claude-plugin/marketplace.json` with `"source": "./plugins/<name>"`.
3. Write skills so they work everywhere: don't rely only on `$ARGUMENTS` (it's only filled in for slash commands in Claude Code) and say how to deliver output on each surface.
4. Run `claude plugin validate .` and `./scripts/package.sh`, then commit `dist/` with your change. CI fails if `dist/` is stale.

## Credits

`eli5` is by Thariq Shihipar (MIT), extracted from [anthropics/claude-plugins-community](https://github.com/anthropics/claude-plugins-community/tree/main/eli5) and adapted to work across chat, Cowork, and Code.
