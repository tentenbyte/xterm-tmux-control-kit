#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
stamp="$(date +%Y%m%d-%H%M%S)"

backup_if_exists() {
  local dest="$1"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    cp -a "$dest" "$dest.bak.$stamp"
    printf 'backup: %s -> %s\n' "$dest" "$dest.bak.$stamp"
  fi
}

render_template() {
  local src="$1"
  local dest="$2"
  local mode="$3"
  local tmp

  tmp="$(mktemp)"
  sed "s|@HOME@|$HOME|g" "$src" >"$tmp"
  backup_if_exists "$dest"
  install -Dm"$mode" "$tmp" "$dest"
  rm -f "$tmp"
  printf 'install: %s\n' "$dest"
}

install_file() {
  local src="$1"
  local dest="$2"
  local mode="$3"

  backup_if_exists "$dest"
  install -Dm"$mode" "$src" "$dest"
  printf 'install: %s\n' "$dest"
}

render_template "$repo_dir/xterm/Xresources" "$HOME/.Xresources" 0644
render_template "$repo_dir/tmux/tmux.conf" "$HOME/.tmux.conf" 0644
install_file "$repo_dir/bin/open-selected-url" "$HOME/.local/bin/open-selected-url" 0755
install_file "$repo_dir/bin/tmux-open-url" "$HOME/.local/bin/tmux-open-url" 0755
install_file "$repo_dir/bin/tmux-new-codex-cockpit" "$HOME/.local/bin/tmux-new-codex-cockpit" 0755
install_file "$repo_dir/bin/tmux-codex-cockpit-layout" "$HOME/.local/bin/tmux-codex-cockpit-layout" 0755
install_file "$repo_dir/bin/kc-tmux-paste" "$HOME/.local/bin/kc-tmux-paste" 0755

cat <<'EOF'

Reload:
  xrdb -merge ~/.Xresources
  tmux source-file ~/.tmux.conf

Open a new xterm window if an existing xterm did not reload all resources.
EOF
