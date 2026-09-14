#!/bin/sh
if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl no está instalado." >&2
    echo "Instálalo e intenta nuevamente." >&2
    exit 1
fi

echo "INSTALL ANTIGRAVITY IDE"
ANTIGRAVITY_URL=https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/2.5.5-4923483625488384/linux-x64/Antigravity%20IDE.tar.gz
FILE=Antigravity-IDE
rm -rf $FILE $FILE.tar.gz
curl -o $FILE.tar.gz $ANTIGRAVITY_URL
tar -xvf $FILE.tar.gz
rm -rf $HOME/antigravity-ide
rm -rf $HOME/.antigravity-ide
rm -rf $HOME/.gemini
rm -rf $HOME/.config/Antigravity
mkdir -p $HOME/antigravity-ide
mv "Antigravity IDE"/* $HOME/antigravity-ide/
rm "Antigravity IDE"
rm -rf $FILE $FILE.tar.gz

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