#!/bin/sh
set -eu

APP_NAME="${ANTIGRAVITY_NAME:-${1:-Antigravity IDE}}"

echo "UNINSTALL ${APP_NAME}"

if [ -d "$HOME/code" ]; then
    rm -rf "$HOME/code"
    echo "Removed $HOME/code"
fi

if [ -d "$HOME/.antigravity-ide" ]; then
    rm -rf "$HOME/.antigravity-ide"
    echo "Removed $HOME/.antigravity-ide"
fi

if [ -d "$HOME/antigravity-ide" ]; then
    rm -rf "$HOME/antigravity-ide"
    echo "Removed $HOME/antigravity-ide"
fi

if [ -d "$HOME/.gemini" ]; then
    rm -rf "$HOME/.gemini"
    echo "Removed $HOME/.gemini"
fi

if [ -f "$HOME/.local/share/applications/code.desktop" ]; then
    rm -f "$HOME/.local/share/applications/code.desktop"
    echo "Removed desktop launcher"
fi

if [ -f "$HOME/.bashrc" ]; then
    tmp_file=$(mktemp)
    awk -v app_name="$APP_NAME" '
        $0 == "# " app_name { next }
        $0 == "# VS Code" { next }
        $0 == "export PATH=\"$HOME/code/bin:$PATH\"" { next }
        { print }
    ' "$HOME/.bashrc" > "$tmp_file"
    mv "$tmp_file" "$HOME/.bashrc"
    echo "Cleaned PATH entry from .bashrc"
fi

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$HOME/.local/share/applications/"
fi

echo "Uninstall finished"