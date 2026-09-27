#!/usr/bin/env bash
# Builds upload-ready zips for the Claude apps (chat, desktop, Cowork):
#   dist/plugins/<plugin>.zip  plugin contents at the zip root (.claude-plugin/plugin.json, skills/...),
#                              for Customize > Plugins > upload.
#   dist/skills/<skill>.zip    the skill folder at the zip root (<skill>/SKILL.md),
#                              for Customize > Skills > upload.
# Output is deterministic (fixed timestamps, sorted entries) so CI can check it is up to date.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
dist="$root/dist"
rm -rf "$dist"
mkdir -p "$dist/plugins" "$dist/skills"

# pack <source dir> <output zip> <wrap>: zips the files of <source dir>; with wrap=1 they
# sit under a top-level folder named after it, otherwise directly at the zip root.
pack() {
  local src="${1%/}" out="$2" wrap="$3" name stage
  name="$(basename "$src")"
  stage="$(mktemp -d)"
  cp -R "$src" "$stage/$name"
  find "$stage/$name" -exec touch -h -d '2000-01-01 00:00:00 UTC' {} +
  if [ "$wrap" = 1 ]; then cd "$stage"; else cd "$stage/$name"; fi
  find . -type f | sed 's#^\./##' | LC_ALL=C sort | TZ=UTC zip -X -q "$out" -@
  cd "$root"
  rm -rf "$stage"
  echo "built ${out#"$root"/}"
}

for plugin_dir in "$root"/plugins/*/; do
  [ -f "$plugin_dir/.claude-plugin/plugin.json" ] || { echo "missing plugin.json in $plugin_dir" >&2; exit 1; }
  pack "$plugin_dir" "$dist/plugins/$(basename "$plugin_dir").zip" 0

  for skill_dir in "$plugin_dir"skills/*/; do
    [ -d "$skill_dir" ] || continue
    [ -f "$skill_dir/SKILL.md" ] || { echo "missing SKILL.md in $skill_dir" >&2; exit 1; }
    pack "$skill_dir" "$dist/skills/$(basename "$skill_dir").zip" 1
  done
done
