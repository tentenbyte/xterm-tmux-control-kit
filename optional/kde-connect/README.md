# KDE Connect bridge

Optional helper for pasting KDE Connect shared text into the active xterm tmux pane.

Install manually:

```bash
install -Dm755 optional/kde-connect/bin/kc-kdeconnect-tmux-bridge ~/.local/bin/kc-kdeconnect-tmux-bridge
sed "s|@HOME@|$HOME|g" optional/kde-connect/systemd-user/kc-kdeconnect-tmux-bridge.service > /tmp/kc-kdeconnect-tmux-bridge.service
install -Dm644 /tmp/kc-kdeconnect-tmux-bridge.service ~/.config/systemd/user/kc-kdeconnect-tmux-bridge.service
systemctl --user daemon-reload
systemctl --user enable --now kc-kdeconnect-tmux-bridge.service
```

Check status:

```bash
systemctl --user status kc-kdeconnect-tmux-bridge.service
```

