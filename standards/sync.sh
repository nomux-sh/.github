#!/bin/sh
# Copies the shared files of this directory into a repository clone.
# Usage: standards/sync.sh <path-to-repository>
set -eu

src=$(cd "$(dirname "$0")" && pwd)
dst=$1

mkdir -p "$dst/.githooks"
cp "$src/commit-msg" "$dst/.githooks/commit-msg"
chmod +x "$dst/.githooks/commit-msg"

agents="$dst/AGENTS.md"
if ! grep -q '^<!-- nomux:common:start -->$' "$agents"; then
  echo "sync: $agents has no organization block. Add the start and end markers first." >&2
  exit 1
fi
tmp=$(mktemp)
awk -v block="$src/AGENTS.common.md" '
  /^<!-- nomux:common:start -->$/ { while ((getline line < block) > 0) print line; skip = 1; next }
  /^<!-- nomux:common:end -->$/ { skip = 0; next }
  !skip { print }
' "$agents" >"$tmp"
mv "$tmp" "$agents"
