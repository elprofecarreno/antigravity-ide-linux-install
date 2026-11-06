#!/bin/sh
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CONFIG_FILE="$SCRIPT_DIR/antigravity.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: no se encontró el archivo de configuración $CONFIG_FILE." >&2
    exit 1
fi

. "$CONFIG_FILE"

if [ -z "$ANTIGRAVITY_VERSION" ]; then
    echo "Error: ANTIGRAVITY_VERSION no está definida en $CONFIG_FILE." >&2
    exit 1
fi

ANTIGRAVITY_URL="https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/$ANTIGRAVITY_VERSION/linux-x64/Antigravity%20IDE.tar.gz"

if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl no está instalado." >&2
    echo "Instálalo e intenta nuevamente." >&2
    exit 1
fi

echo "INSTALL ANTIGRAVITY IDE"
FILE=Antigravity-IDE
rm -rf "$FILE" "$FILE.tar.gz"
curl -o "$FILE.tar.gz" "$ANTIGRAVITY_URL"
tar -xvf "$FILE.tar.gz"
rm -rf $HOME/antigravity-ide
rm -rf $HOME/.antigravity-ide
rm -rf $HOME/.gemini
rm -rf $HOME/.config/Antigravity
mkdir -p $HOME/antigravity-ide
mv "Antigravity IDE"/* $HOME/antigravity-ide/
rm "Antigravity IDE"
rm -rf "$FILE" "$FILE.tar.gz"

if ! grep -q 'export PATH="$HOME/antigravity-ide/bin:$PATH"' "$HOME/.bashrc"; then
    echo '' >> "$HOME/.bashrc"
    echo '# Antigravity IDE' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/antigravity-ide/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "CREATE ICON"
mkdir -p "$HOME/.local/share/applications"
cp antigravity-ide.desktop.template antigravity-ide.desktop
sed -i "s|\$HOME|$HOME|g" antigravity-ide.desktop
mv antigravity-ide.desktop "$HOME/.local/share/applications/"

echo "PERMISSION ICON"
chmod +x "$HOME/.local/share/applications/antigravity-ide.desktop"

echo "UPDATE DESKTOP ICON"
update-desktop-database "$HOME/.local/share/applications/"