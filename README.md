# xterm tmux control kit

Small X11/xterm + tmux configuration kit for a keyboard-light, mouse-useful terminal workflow.

It keeps tmux mouse scrolling enabled while making right-click useful:

- outside tmux, xterm right-click opens the selected URL in Chrome;
- inside tmux, right-click opens the URL or local file path under the pointer;
- web URLs open in Chrome;
- local files and directories open through `xdg-open`, so images, audio, video, PDFs, PPT, Excel files, and folders use the system default app;
- tmux keeps middle-click paste and mouse wheel scrolling;
- Alt+number switches tmux windows.

## Files

```text
xterm/Xresources        xterm font, Meta/Alt, and right-click selection opener
tmux/tmux.conf          tmux mouse, right-click opener, window shortcuts
bin/open-selected-url   xterm selection URL opener
bin/tmux-open-url       tmux right-click URL/path opener
bin/kc-tmux-paste       optional KDE Connect clipboard paste helper
tests/test-tmux-open-url
install.sh
```

## Requirements

- xterm
- tmux 3.4 or compatible
- bash
- `xdg-open`
- Chrome or Chromium for web URLs: `google-chrome`, `google-chrome-stable`, `chromium`, or `chromium-browser`
- optional: `xclip` or `xsel` for KDE Connect clipboard paste

## Install

Run:

```bash
./install.sh
```

The installer writes:

```text
~/.Xresources
~/.tmux.conf
~/.local/bin/open-selected-url
~/.local/bin/tmux-open-url
~/.local/bin/kc-tmux-paste
```

Existing files are backed up with a timestamp before replacement.

Then reload:

```bash
xrdb -merge ~/.Xresources
tmux source-file ~/.tmux.conf
```

New xterm windows will use the updated Xresources.

## Test

```bash
tests/test-tmux-open-url
```

Expected output:

```text
tmux-open-url tests passed
```

## Usage

In xterm outside tmux:

- select a URL with left mouse;
- right-click to open it in Chrome;
- middle-click keeps PRIMARY paste behavior.

Inside tmux:

- scroll wheel keeps working;
- right-click on `https://example.com` opens Chrome;
- right-click on `file:///home/user/file.pdf` opens the local file;
- right-click on `/home/user/file.pdf` opens the local file through the default application.

