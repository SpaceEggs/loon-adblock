#!/bin/sh

set -eu

root_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$root_dir"

plugin_count=0
for plugin in plugins/*/*.plugin; do
  [ -f "$plugin" ] || continue
  plugin_count=$((plugin_count + 1))

  grep -q '^#!name = ' "$plugin"
  grep -q '^#!desc = ' "$plugin"
  grep -q '^#!type = normal$' "$plugin"
  grep -Eq '^\[(Rewrite|Rule|Script)\]$' "$plugin"
done

if [ "$plugin_count" -eq 0 ]; then
  echo "No plugin files found" >&2
  exit 1
fi

cmp -s FotMob_remove_ads.plugin plugins/fotmob/FotMob_remove_ads.plugin || {
  echo "Legacy FotMob entry differs from canonical plugin" >&2
  exit 1
}

if rg -n -i --glob '!README.md' --glob '!scripts/verify.sh' \
  '(auth_token=|authorization:|cookie:|eyJ[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\.)' .; then
  echo "Potential secret found" >&2
  exit 1
fi

echo "Validated $plugin_count plugin(s)"
